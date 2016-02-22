package com.vestas.utils.preloader
{
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.geom.ColorTransform;
	import flash.media.SoundChannel;
	import flash.utils.*;
	/**
	 * 
	 * @author Karthy
	 * 
	 */	
	public class TweenLite {
		public static var version:Number = 6.21;
		public static var killDelayedCallsTo:Function = killTweensOf;
		public static var defaultEase:Function = TweenLite.easeOut;
		protected static var _all:Dictionary = new Dictionary(); //Holds references to all our tween targets.
		protected static var _curTime:uint;
		private static var _classInitted:Boolean;
		private static var _sprite:Sprite = new Sprite(); //A reference to the sprite that we use to drive all our ENTER_FRAME events.
		private static var _listening:Boolean; //If true, the ENTER_FRAME is being listened for (there are tweens that are in the queue)
		private static var _timer:Timer = new Timer(2000);
	
		public var duration:Number; //Duration (in seconds)
		public var vars:Object; //Variables (holds things like alpha or y or whatever we're tweening)
		public var delay:Number; //Delay (in seconds)
		public var startTime:int; //Start time
		public var initTime:int; //Time of initialization. Remember, we can build in delays so this property tells us when the frame action was born, not when it actually started doing anything.
		public var tweens:Array; //Contains parsed data for each property that's being tweened (each has to have a target, property, start, and a change).
		public var target:Object; //Target object (often a MovieClip)
		
		protected var _active:Boolean; //If true, this tween is active.
		protected var _subTweens:Array; //Only used for associated sub-tweens like tint and volume
		protected var _hst:Boolean; //Has sub-tweens. We track this with a boolean value as opposed to checking _subTweens.length for speed purposes
		protected var _initted:Boolean;
		
		public function TweenLite($target:Object, $duration:Number, $vars:Object) {
			if ($target == null) {return};
			if (($vars.overwrite != false && $target != null) || _all[$target] == undefined) { 
				delete _all[$target];
				_all[$target] = new Dictionary();
			}
			_all[$target][this] = this;
			this.vars = $vars;
			this.duration = $duration || 0.001; //Easing equations don't work when the duration is zero.
			this.delay = $vars.delay || 0;
			this.target = $target;
			if (!(this.vars.ease is Function)) {
				this.vars.ease = defaultEase;
			}
			if (this.vars.easeParams != null) {
				this.vars.proxiedEase = this.vars.ease;
				this.vars.ease = easeProxy;
			}
			if (!isNaN(Number(this.vars.autoAlpha))) {
				this.vars.alpha = Number(this.vars.autoAlpha);
			}
			this.tweens = [];
			_subTweens = [];
			_hst = _initted = false;
			_active = ($duration == 0 && this.delay == 0);
			if (!_classInitted) {
				_curTime = getTimer();
				_sprite.addEventListener(Event.ENTER_FRAME, executeAll);
				_classInitted = true;
			}
			this.initTime = _curTime;
			if ((this.vars.runBackwards == true && this.vars.renderOnStart != true) || _active) {
				initTweenVals();
				this.startTime = _curTime;
				if (_active) { //Means duration is zero and delay is zero, so render it now, but add one to the startTime because this.duration is always forced to be at least 0.001 since easing equations can't handle zero.
					render(this.startTime + 1);
				} else {
					render(this.startTime);
				}
			}
			if (!_listening && !_active) {
				_timer.addEventListener("timer", killGarbage);
            	_timer.start();
				_listening = true;
			}
		}
		
		public function initTweenVals($hrp:Boolean = false, $reservedProps:String = ""):void {
			var isDO:Boolean = (this.target is DisplayObject);
			var p:String, i:int;
			if (this.target is Array) {
				var endArray:Array = this.vars.endArray || [];
				for (i = 0; i < endArray.length; i++) {
					if (this.target[i] != endArray[i] && this.target[i] != undefined) {
						this.tweens.push({o:this.target, p:i.toString(), s:this.target[i], c:endArray[i] - this.target[i]}); //o: object, p:property, s:starting value, c:change in value,
					}
				}
			} else {
				for (p in this.vars) {
					if (p == "ease" || p == "delay" || p == "overwrite" || p == "onComplete" || p == "onCompleteParams" || p == "onCompleteScope" || p == "runBackwards" || p == "onUpdate" || p == "onUpdateParams" || p == "onUpdateScope" || p == "autoAlpha" || p == "onStart" || p == "onStartParams" || p == "onStartScope" ||p == "renderOnStart" || p == "proxiedEase" || p == "easeParams" || ($hrp && $reservedProps.indexOf(" " + p + " ") != -1)) { //"type" is for TweenFilterLite, and it's an issue when trying to tween filters on TextFields which do actually have a "type" property.
						
					} else if (p == "tint" && isDO) { //If we're trying to change the color of a DisplayObject, then set up a quasai proxy using an instance of a TweenLite to control the color.
						var clr:ColorTransform = this.target.transform.colorTransform;
						var endClr:ColorTransform = new ColorTransform();
						if (this.vars.alpha != undefined) {
							endClr.alphaMultiplier = this.vars.alpha;
							delete this.vars.alpha;
							for (i = this.tweens.length - 1; i > -1; i--) {
								if (this.tweens[i].p == "alpha") {
									this.tweens.splice(i, 1);
									break;
								}
							}
						} else {
							endClr.alphaMultiplier = this.target.alpha;
						}
						if ((this.vars[p] != null && this.vars[p] != "") || this.vars[p] == 0) { //In case they're actually trying to remove the colorization, they should pass in null or "" for the tint
							endClr.color = this.vars[p];
						}
						addSubTween(tintProxy, {progress:0}, {progress:1}, {target:this.target, color:clr, endColor:endClr});
					} else if (p == "frame" && isDO) {
						addSubTween(frameProxy, {frame:this.target.currentFrame}, {frame:this.vars[p]}, {target:this.target});
					} else if (p == "volume" && (isDO || this.target is SoundChannel)) { //If we're trying to change the volume of a MovieClip or Sound object, then set up a quasai proxy using an instance of a TweenLite to control the volume.
						addSubTween(volumeProxy, this.target.soundTransform, {volume:this.vars[p]}, {target:this.target});
					} else {
						if (this.target.hasOwnProperty(p)) {
							if (typeof(this.vars[p]) == "number") {
								this.tweens.push({o:this.target, p:p, s:this.target[p], c:this.vars[p] - this.target[p]}); //o:object, p:property, s:starting value, c:change in value
							} else {
								this.tweens.push({o:this.target, p:p, s:this.target[p], c:Number(this.vars[p])}); //o:object, p:property, s:starting value, c:change in value
							}
						}
					}
				}
			}
			if (this.vars.runBackwards == true) {
				var tp:Object;
				for (i = this.tweens.length - 1; i > -1; i--) {
					tp = this.tweens[i];
					tp.s += tp.c;
					tp.c *= -1;
				}
			}
			if (typeof(this.vars.autoAlpha) == "number") {
				this.target.visible = !(this.vars.runBackwards == true && this.target.alpha == 0);
			}
			_initted = true;
		}
		
		protected function addSubTween($proxy:Function, $target:Object, $props:Object, $info:Object = null):void {
			var sub:Object = {proxy:$proxy, target:$target, info:$info};
			_subTweens.push(sub);
			for (var p:String in $props) {
				if ($target.hasOwnProperty(p)) {
					if (typeof($props[p]) == "number") {
						this.tweens.push({o:$target, p:p, s:$target[p], c:$props[p] - $target[p], sub:sub}); //o:Object, p:Property, s:Starting value, c:Change in value, sub:Subtween object;
					} else {
						this.tweens.push({o:$target, p:p, s:$target[p], c:Number($props[p]), sub:sub});
					}
				}
			}
			_hst = true; //has sub tweens. We track this with a boolean value as opposed to checking _subTweens.length for speed purposes
		}
		
		public static function to($target:Object, $duration:Number, $vars:Object):TweenLite {
			return new TweenLite($target, $duration, $vars);
		}
		
		//This function really helps if there are objects (usually MovieClips) that we just want to animate into place (they are already at their end position on the stage for example). 
		public static function from($target:Object, $duration:Number, $vars:Object):TweenLite {
			$vars.runBackwards = true;
			return new TweenLite($target, $duration, $vars);
		}
		
		public static function delayedCall($delay:Number, $onComplete:Function, $onCompleteParams:Array = null, $onCompleteScope:* = null):TweenLite {
			return new TweenLite($onComplete, 0, {delay:$delay, onComplete:$onComplete, onCompleteParams:$onCompleteParams, onCompleteScope:$onCompleteScope, overwrite:false}); //NOTE / TO-DO: There may be a bug in the Dictionary class that causes it not to handle references to objects correctly! (I haven't verified this yet)
		}
		
		public function render($t:uint):void {
			var time:Number = ($t - this.startTime) / 1000;
			if (time > this.duration) {
				time = this.duration;
			}
			var factor:Number = this.vars.ease(time, 0, 1, this.duration);
			var tp:Object, i:int;
			for (i = this.tweens.length - 1; i > -1; i--) {
				tp = this.tweens[i];
				tp.o[tp.p] = tp.s + (factor * tp.c);
			}
			if (_hst) { //has sub-tweens
				for (i = _subTweens.length - 1; i > -1; i--) {
					_subTweens[i].proxy(_subTweens[i]);
				}
			}
			if (this.vars.onUpdate != null) {
				this.vars.onUpdate.apply(this.vars.onUpdateScope, this.vars.onUpdateParams);
			}
			if (time == this.duration) {
				complete(true);
			}
		}
		
		public static function executeAll($e:Event = null):void {
			var t:uint = _curTime = getTimer();
			if (_listening) {
				var a:Dictionary = _all; //speeds things up slightly
				var p:Object, tw:Object;
				for each (p in a) {
					for (tw in p) {
						if (p[tw] != undefined && p[tw].active) {
							p[tw].render(t);
						}
					}
				}
			}
		}
		
		
		public function complete($skipRender:Boolean = false):void {
			if (!$skipRender) {
				if (!_initted) {
					initTweenVals();
				}
				this.startTime = _curTime - (this.duration * 1000);
				render(_curTime); //Just to force the final render
				return;
			}
			if (typeof(this.vars.autoAlpha) == "number" && this.target.alpha == 0) { 
				this.target.visible = false;
			}
			if (this.vars.onComplete != null) {
				this.vars.onComplete.apply(this.vars.onCompleteScope, this.vars.onCompleteParams);
			}
			removeTween(this);
		}
		
		public static function removeTween($t:TweenLite = null):void {
			if ($t != null && _all[$t.target] != undefined) {
				delete _all[$t.target][$t];
			}
		}
		
		public static function killTweensOf($tg:Object = null, $complete:Boolean = false):void {
			if ($tg != null && _all[$tg] != undefined) {
				if ($complete) {
					var o:Object = _all[$tg];
					for (var tw:* in o) {
						o[tw].complete(false);
					}
				}
				delete _all[$tg];
			}
		}
		
		public static function killGarbage($e:TimerEvent):void {
			var tg_cnt:uint = 0;
			var found:Boolean;
			var p:Object, twp:Object, tw:Object;
			for (p in _all) {
				found = false;
				for (twp in _all[p]) {
					found = true;
					break;
				}
				if (!found) {
					delete _all[p];
				} else {
					tg_cnt++;
				}
			}
			if (tg_cnt == 0) {
				_timer.removeEventListener("timer", killGarbage);
				_timer.stop();
				_listening = false;
			}
		}
		
		public static function easeOut($t:Number, $b:Number, $c:Number, $d:Number):Number {
			return -$c * ($t /= $d) * ($t - 2) + $b;
		}
		
//---- PROXY FUNCTIONS ------------------------------------------------------------------------
		
		protected function easeProxy($t:Number, $b:Number, $c:Number, $d:Number):Number { //Just for when easeParams are passed in via the vars object.
			return this.vars.proxiedEase.apply(null, arguments.concat(this.vars.easeParams));
		}
		public static function tintProxy($o:Object):void {
			var n:Number = $o.target.progress;
			var r:Number = 1 - n;
			var sc:Object = $o.info.color;
			var ec:Object = $o.info.endColor;
			$o.info.target.transform.colorTransform = new ColorTransform(sc.redMultiplier * r + ec.redMultiplier * n,
																		  sc.greenMultiplier * r + ec.greenMultiplier * n,
																		  sc.blueMultiplier * r + ec.blueMultiplier * n,
																		  sc.alphaMultiplier * r + ec.alphaMultiplier * n,
																		  sc.redOffset * r + ec.redOffset * n,
																		  sc.greenOffset * r + ec.greenOffset * n,
																		  sc.blueOffset * r + ec.blueOffset * n,
																		  sc.alphaOffset * r + ec.alphaOffset * n);
		}
		public static function frameProxy($o:Object):void {
			$o.info.target.gotoAndStop(Math.round($o.target.frame));
		}
		public static function volumeProxy($o:Object):void {
			$o.info.target.soundTransform = $o.target;
		}
		
		
//---- GETTERS / SETTERS -----------------------------------------------------------------------
		
		public function get active():Boolean {
			if (_active) {
				return true;
			} else if ((_curTime - this.initTime) / 1000 > this.delay) {
				_active = true;
				this.startTime = this.initTime + (this.delay * 1000);
				if (!_initted) {
					initTweenVals();
				} else if (typeof(this.vars.autoAlpha) == "number") {
					this.target.visible = true;
				}
				if (this.vars.onStart != null) {
					this.vars.onStart.apply(this.vars.onStartScope, this.vars.onStartParams);
				}
				if (this.duration == 0.001) { //In the constructor, if the duration is zero, we shift it to 0.001 because the easing functions won't work otherwise. We need to offset the this.startTime to compensate too.
					this.startTime -= 1;
				}
				return true;
			} else {
				return false;
			}
		}
		
	}
	
}