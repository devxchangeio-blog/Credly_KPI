package com.vestas.delegate
{
	import com.vestas.model.UserParams;

	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;

	/**
	 *
	 * @author Karthy
	 *
	 */
	public class VestasDelegate
	{
		public var remoteObjectInterface:RemoteObject;

		/**
		 *
		 * @param params
		 * @return
		 *
		 */
		public function fetchUserProfile():AsyncToken
		{

			return remoteObjectInterface.fetchUserProfile();
		}

		/**
		 *
		 * @param params
		 * @return
		 *
		 */
		public function loginValidation(params:UserParams):AsyncToken
		{

			return remoteObjectInterface.loginValidation(params);
		}

		public function fetchInjuryDetail():AsyncToken
		{

			return remoteObjectInterface.fetchInjuryDetail();

		}

		public function fetchAbsenceDetails():AsyncToken
		{
			return remoteObjectInterface.fetchAbsenceDetails();
		}

	}
}
