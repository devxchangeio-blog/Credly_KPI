package com.vestas.daoImpl;

import java.util.ArrayList;

import org.apache.log4j.Logger;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

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
public class UsersDaoImpl extends SqlMapClientDaoSupport implements UsersDao
{
	static final Logger logger = Logger.getLogger(UsersDaoImpl.class);

	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<EmployeeDetails> fetchUserProfile()
	{
		logger.info("entering fetchUserProfile");
		return (ArrayList<EmployeeDetails>) getSqlMapClientTemplate()
				.queryForList("User.fetchUserProfile");
	}

	@Override
	public boolean loginValidation(UserParams params)
	{
		logger.info("entering loginValidation");
		params = (UserParams) getSqlMapClientTemplate().queryForObject(
				"User.loginValidation", params);
		
		if (params == null)
		{
			return false;
		}

		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<InjuryDetails> fetchInjuryDetail()
	{
		logger.info("entering fetchInjuryDetail");
		return (ArrayList<InjuryDetails>) getSqlMapClientTemplate()
				.queryForList("User.fetchInjuryDetail");
	}

	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<AbsenceDetails> fetchAbsenceDetails()
	{
		logger.info("entering fetchAbsenceDetails");
		return (ArrayList<AbsenceDetails>) getSqlMapClientTemplate()
				.queryForList("User.fetchAbsenceDetails");
	}

}
