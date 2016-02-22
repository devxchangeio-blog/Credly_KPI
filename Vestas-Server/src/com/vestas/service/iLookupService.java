package com.vestas.service;

import java.util.ArrayList;

import com.vestas.model.AbsenceDetails;
import com.vestas.model.EmployeeDetails;
import com.vestas.model.InjuryDetails;
import com.vestas.model.UserParams;
/**
 * 
 * @author Karthy
 *
 */
public interface iLookupService {
	
	public ArrayList<EmployeeDetails> fetchUserProfile() throws Exception;
	public boolean loginValidation(UserParams params);
	public ArrayList<InjuryDetails> fetchInjuryDetail();
	public ArrayList<AbsenceDetails> fetchAbsenceDetails();

}
