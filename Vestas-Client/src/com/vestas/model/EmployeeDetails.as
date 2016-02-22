/**
 *
 */
package com.vestas.model
{

	[RemoteClass(alias=" com.vestas.model.EmployeeDetails")]
	/**
	 *
	 * @author Karthy
	 *
	 */
	public class EmployeeDetails
	{
		private var _seniorityPosition:String;
		private var _seniorityVestas:String;
		private var _gender:String;
		private var _nationality:String;
		private var _ownTermination:int=0;
		private var _vestasTermination:int=0;
		private var _countryOfEmployment:String;
		private var _region:String;
		private var _position:String;
		private var _Function:String="";
		private var _period:String;
		private var _ipe:String;
		private var _terminatedBy:String="";
		private var _buTransfer:int=0;
		public var department:String="";
		private var _newVestas:int=0;
		private var _lateralChange:int=0;
		private var _promotion:int=0;
		private var _filledPosition:int=0;
		private var _doj:String;
		private var _exitMonth:String;


		public function get exitMonth():String
		{
			return _exitMonth;
		}

		public function set exitMonth(value:String):void
		{
			_exitMonth = value;
		}

		public function get doj():String
		{
			return _doj;
		}

		public function set doj(value:String):void
		{
			_doj = value;
		}

		public function get filledPosition():int
		{
			return _filledPosition;
		}

		public function set filledPosition(value:int):void
		{
			_filledPosition = value;
		}

		public function get promotion():int
		{
			return _promotion;
		}

		public function set promotion(value:int):void
		{
			_promotion = value;
		}

		public function get lateralChange():int
		{
			return _lateralChange;
		}

		public function set lateralChange(value:int):void
		{
			_lateralChange = value;
		}

		public function get newVestas():int
		{
			return _newVestas;
		}

		public function set newVestas(value:int):void
		{
			_newVestas = value;
		}

		public function get buTransfer():int
		{
			return _buTransfer;
		}

		public function set buTransfer(value:int):void
		{
			_buTransfer=value;
		}

		public function get vestasTermination():int
		{
			return _vestasTermination;
		}

		public function set vestasTermination(value:int):void
		{
			_vestasTermination=value;
		}

		public function get ownTermination():int
		{
			return _ownTermination;
		}

		public function set ownTermination(value:int):void
		{
			_ownTermination=value;
		}

		public function get Function():String
		{
			return _Function;
		}

		public function set Function(value:String):void
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

		public function get nationality():String
		{
			return _nationality;
		}

		public function set nationality(value:String):void
		{
			_nationality=value;
		}

		public function get gender():String
		{
			return _gender;
		}

		public function set gender(value:String):void
		{
			_gender=value;
		}

		public function get seniorityVestas():String
		{
			return _seniorityVestas;
		}

		public function set seniorityVestas(value:String):void
		{
			_seniorityVestas=value;
		}

		public function get seniorityPosition():String
		{
			return _seniorityPosition;
		}

		public function set seniorityPosition(value:String):void
		{
			_seniorityPosition=value;
		}

		public function get period():String
		{
			return _period;
		}

		public function set period(value:String):void
		{
			_period=value;
		}

		public function get ipe():String
		{
			return _ipe;
		}

		public function set ipe(value:String):void
		{
			_ipe=value;
		}

	}
}
