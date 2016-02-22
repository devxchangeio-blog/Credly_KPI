package com.vestas.service;

import java.util.ArrayList;

import com.vestas.dao.UsersDao;
import com.vestas.model.AbsenceDetails;
import com.vestas.model.EmployeeDetails;
import com.vestas.model.InjuryDetails;
import com.vestas.model.UserParams;
/**
 * 
 * @author Karthy
 *
 */
public class LookupServiceImpl implements iLookupService {

	private UsersDao usersDao;

	@Override
	public ArrayList<EmployeeDetails> fetchUserProfile() throws Exception {

		return usersDao.fetchUserProfile();

	}
	
	@Override
	public boolean loginValidation(UserParams params)
	{
		return usersDao.loginValidation(params);
	}

	public void setUsersDao(UsersDao usersDao) {
		this.usersDao = usersDao;
	}

	public UsersDao getUsersDao() {
		return usersDao;
	}

	@Override
	public ArrayList<InjuryDetails> fetchInjuryDetail()
	{
		return usersDao.fetchInjuryDetail();
	}

	@Override
	public ArrayList<AbsenceDetails> fetchAbsenceDetails()
	{
		return usersDao.fetchAbsenceDetails();
	}

	

}
