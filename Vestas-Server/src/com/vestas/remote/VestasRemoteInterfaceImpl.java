package com.vestas.remote;

import java.util.ArrayList;

import com.vestas.model.AbsenceDetails;
import com.vestas.model.EmployeeDetails;
import com.vestas.model.InjuryDetails;
import com.vestas.model.UserParams;
import com.vestas.service.iLookupService;

/**
 * 
 * @author Karthy
 * 
 */
public class VestasRemoteInterfaceImpl
{

	private iLookupService lookupService;

	public void setLookupService(iLookupService lookupService)
	{
		this.lookupService = lookupService;
	}

	public ArrayList<EmployeeDetails> fetchUserProfile()
			throws Exception
	{

		return lookupService.fetchUserProfile();

	}

	public boolean loginValidation(UserParams params)
	{

		return lookupService.loginValidation(params);
	}

	public ArrayList<InjuryDetails> fetchInjuryDetail()
	{

		return lookupService.fetchInjuryDetail();
	}

	public ArrayList<AbsenceDetails> fetchAbsenceDetails()
	{

		return lookupService.fetchAbsenceDetails();
	}

}
