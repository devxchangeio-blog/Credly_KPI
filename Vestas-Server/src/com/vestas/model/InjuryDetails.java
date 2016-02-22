/**
 * 
 */
package com.vestas.model;

/**
 * @author Karthy
 * 
 */
public class InjuryDetails
{

	private String countryOfEmployment;
	private String region;
	private String position;
	private String Function = "";
	private String period;
	private String ipe;
	private String organization;
	private String jobs;
	private Integer salariedPaid;
	private Integer hourlyPaid;
	private Integer noOfRepotableInjuries;
	private Double totalWorkingHours;
	private String updatedDate;
	private Double incidenceInjuries;

	public String getCountryOfEmployment()
	{
		return countryOfEmployment;
	}

	public void setCountryOfEmployment(String countryOfEmployment)
	{
		this.countryOfEmployment = countryOfEmployment;
	}

	public String getRegion()
	{
		return region;
	}

	public void setRegion(String region)
	{
		this.region = region;
	}

	public String getPosition()
	{
		return position;
	}

	public void setPosition(String position)
	{
		this.position = position;
	}

	public String getFunction()
	{
		return Function;
	}

	public void setFunction(String function)
	{
		Function = function;
	}

	public String getPeriod()
	{
		return period;
	}

	public void setPeriod(String period)
	{
		this.period = period;
	}

	public String getIpe()
	{
		return ipe;
	}

	public void setIpe(String ipe)
	{
		this.ipe = ipe;
	}

	public String getOrganization()
	{
		return organization;
	}

	public void setOrganization(String organization)
	{
		this.organization = organization;
	}

	public String getJobs()
	{
		return jobs;
	}

	public void setJobs(String jobs)
	{
		this.jobs = jobs;
	}

	public Integer getSalariedPaid()
	{
		return salariedPaid;
	}

	public void setSalariedPaid(Integer salariedPaid)
	{
		this.salariedPaid = salariedPaid;
	}

	public Integer getHourlyPaid()
	{
		return hourlyPaid;
	}

	public void setHourlyPaid(Integer hourlyPaid)
	{
		this.hourlyPaid = hourlyPaid;
	}

	public Integer getNoOfRepotableInjuries()
	{
		return noOfRepotableInjuries;
	}

	public void setNoOfRepotableInjuries(Integer noOfRepotableInjuries)
	{
		this.noOfRepotableInjuries = noOfRepotableInjuries;
	}

	public Double getTotalWorkingHours()
	{
		return totalWorkingHours;
	}

	public void setTotalWorkingHours(Double totalWorkingHours)
	{
		this.totalWorkingHours = totalWorkingHours;
	}

	public String getUpdatedDate()
	{
		return updatedDate;
	}

	public void setUpdatedDate(String updatedDate)
	{
		this.updatedDate = updatedDate;
	}

	public void setIncidenceInjuries(Double incidenceInjuries)
	{
		this.incidenceInjuries = incidenceInjuries;
	}

	public Double getIncidenceInjuries()
	{
		return incidenceInjuries;
	}

}
