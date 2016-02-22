package com.vestas.model
{
	[RemoteClass(alias=" com.vestas.model.UserParams")]
	/**
	 * 
	 * @author Karthy
	 * 
	 */	
	public class UserParams
	{
		private var _email:String;
		private var _password:String;
		private var _phone:String;
		private var _username:String;

		public function get email():String
		{
			return _email;
		}

		public function set email(value:String):void
		{
			_email = value;
		}

		public function get password():String
		{
			return _password;
		}

		public function set password(value:String):void
		{
			_password = value;
		}

		public function get phone():String
		{
			return _phone;
		}

		public function set phone(value:String):void
		{
			_phone = value;
		}

		public function get username():String
		{
			return _username;
		}

		public function set username(value:String):void
		{
			_username = value;
		}

	}
}