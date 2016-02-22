package com.vestas.events
{
	import flash.events.Event;
	/**
	 * 
	 * @author Karthy
	 * 
	 */	
	public class VestasApplicationEvent extends Event
	{
		public var params:Object;
		public static var LOGIN_SUCCESS:String="loginSuccess";
		public static var CHANGE_VIEW:String="changeView";

		/**
		 *
		 * @param type
		 * @param params
		 *
		 */
		public function VestasApplicationEvent(type:String, params:Object)
		{
			super(type, bubbles, cancelable);
			this.params=params;
		}
	}
}
