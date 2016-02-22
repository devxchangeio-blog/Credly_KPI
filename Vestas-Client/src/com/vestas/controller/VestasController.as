package com.vestas.controller
{

	import com.vestas.delegate.VestasDelegate;
	import com.vestas.events.VestasApplicationEvent;
	import com.vestas.model.UserParams;
	import com.vestas.utils.VestasProgressbar;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.Swiz;
	import org.swizframework.controller.AbstractController;

	/**
	 *
	 * @author Karthy
	 *
	 */
	public class VestasController extends AbstractController
	{

		[Autowire(bean="delegate")]
		public var delegate:VestasDelegate;

		[Autowire(bean="preLoader")]
		public var preLoader:VestasProgressbar;

		[Bindable]
		public var userProfile:ArrayCollection;

		[Bindable]
		public var injuriesDetails:ArrayCollection;
		
		[Bindable]
		public var absenceDetails:ArrayCollection;

		public var isValidUser:Boolean;

		[Dispatcher]
		public var dispatcher:IEventDispatcher;

		/**
		 *
		 * @param params
		 *
		 */
		public function loginValidation(params:UserParams):void
		{
			executeServiceCall(delegate.loginValidation(params), onLoginValidation, onFaultHandler);
		}

		/**
		 *
		 * @param event
		 *
		 */
		public function onLoginValidation(event:ResultEvent):void
		{
			isValidUser=event.result as Boolean;
			Swiz.dispatchEvent(new VestasApplicationEvent(VestasApplicationEvent.LOGIN_SUCCESS, {isValidUser: isValidUser}));
		}

		/**
		 *
		 * @param params
		 *
		 */
		public function fetchUserProfile():void
		{
			executeServiceCall(delegate.fetchUserProfile(), onFetchUserProfile, onFaultHandler);
		}

		/**
		 *
		 * @param event
		 *
		 */
		public function onFetchUserProfile(event:ResultEvent):void
		{
			userProfile=event.result as ArrayCollection;
		}

		/**
		 *
		 * @param event
		 *
		 */
		public function fetchInjuryDetail():void
		{
			executeServiceCall(delegate.fetchInjuryDetail(), onFetchInjuryDetail, onFaultHandler);

		}

		/**
		 *
		 * @param event
		 *
		 */
		public function onFetchInjuryDetail(event:ResultEvent):void
		{
			injuriesDetails=event.result as ArrayCollection;
		}
		
		/**
		 *
		 * @param event
		 *
		 */
		public function fetchAbsenceDetails():void
		{
			executeServiceCall(delegate.fetchAbsenceDetails(), onFetchAbsenceDetails, onFaultHandler);
			
		}
		
		/**
		 *
		 * @param event
		 *
		 */
		public function onFetchAbsenceDetails(event:ResultEvent):void
		{
			absenceDetails=event.result as ArrayCollection;
		}
		
		

		/**
		 *
		 * @param event
		 *
		 */
		public function onFaultHandler(event:FaultEvent):void
		{
			Alert.show(event.message+"", "Message");
			Alert.show(event.fault.rootCause+"", "Root Cause");
			Alert.show(event.fault+"", "Fault Event");


		}

	}
}
