package com.vestas.model
{

	[RemoteClass(alias=" com.vestas.model.InjuryDetails")]
	/**
	 * 
	 * @author Karthy
	 * 
	 */	
	public class InjuryDetails
	{
		private var _countryOfEmployment:String;
		private var _region:String;
		private var _position:String;
		private var _Function="";
		private var _period:String;
		private var _ipe:String;
		private var _organization:String;
		private var _jobs:String;
		private var _salariedPaid:int;
		private var _hourlyPaid:int;
		private var _noOfRepotableInjuries:int;
		private var _totalWorkingHours:Number;
		private var _updatedDate:String;
		private var _incidenceInjuries:Number;

		public function get incidenceInjuries():Number
		{
			return _incidenceInjuries;
		}

		public function set incidenceInjuries(value:Number):void
		{
			_incidenceInjuries=value;
		}

		public function get updatedDate():String
		{
			return _updatedDate;
		}

		public function set updatedDate(value:String):void
		{
			_updatedDate=value;
		}

		public function get totalWorkingHours():Number
		{
			return _totalWorkingHours;
		}

		public function set totalWorkingHours(value:Number):void
		{
			_totalWorkingHours=value;
		}

		public function get noOfRepotableInjuries():int
		{
			return _noOfRepotableInjuries;
		}

		public function set noOfRepotableInjuries(value:int):void
		{
			_noOfRepotableInjuries=value;
		}

		public function get hourlyPaid():int
		{
			return _hourlyPaid;
		}

		public function set hourlyPaid(value:int):void
		{
			_hourlyPaid=value;
		}

		public function get salariedPaid():int
		{
			return _salariedPaid;
		}

		public function set salariedPaid(value:int):void
		{
			_salariedPaid=value;
		}

		public function get jobs():String
		{
			return _jobs;
		}

		public function set jobs(value:String):void
		{
			_jobs=value;
		}

		public function get organization():String
		{
			return _organization;
		}

		public function set organization(value:String):void
		{
			_organization=value;
		}

		public function get ipe():String
		{
			return _ipe;
		}

		public function set ipe(value:String):void
		{
			_ipe=value;
		}

		public function get period():String
		{
			return _period;
		}

		public function set period(value:String):void
		{
			_period=value;
		}

		public function get Function()
		{
			return _Function;
		}

		public function set Function(value):void
		{
			_Function=value;
		}

		public function get position():String
		{
			return _position;
		}

		public function set position(value:String):void
		{
			_position=value;
		}

		public function get region():String
		{
			return _region;
		}

		public function set region(value:String):void
		{
			_region=value;
		}

		public function get countryOfEmployment():String
		{
			return _countryOfEmployment;
		}

		public function set countryOfEmployment(value:String):void
		{
			_countryOfEmployment=value;
		}

	}
}
