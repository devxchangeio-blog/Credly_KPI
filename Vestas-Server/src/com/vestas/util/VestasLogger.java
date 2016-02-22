/**
 * 
 */
package com.vestas.util;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

/**
 * @author Karthy
 *
 */
public class VestasLogger extends Logger
{
	
	static final Logger logger = Logger.getLogger(VestasLogger.class);
	

	protected VestasLogger(String name) {
		super(name);
		PropertyConfigurator.configure("log4j.properties");
	}
	
	public static void enterMethod(String method)
	{
		logger.info("Entering "+method);
	}
	
	public static void exitMethod(String method)
	{
		logger.info("Exit "+method);
	}
	

}
