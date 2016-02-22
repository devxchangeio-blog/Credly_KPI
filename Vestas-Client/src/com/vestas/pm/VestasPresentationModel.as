package com.vestas.pm
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * 
	 * @author Karthy
	 * 
	 */
	public class VestasPresentationModel extends EventDispatcher
	{
		private var _breadCrumb:String;
		public function VestasPresentationModel(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function set breadCrumb(value:String):void{
			
			_breadCrumb=value;
		}
		public function get breadCrumb():String{
			
			return _breadCrumb;
		}
				
	}
}