package com.vestas.model;
/**
 * 
 * @author Karthy
 *
 */
public class UserProfile {

	private String firstName;
	private String lastName;
	private String emailAddress;
	private String hometown;

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public void setHometown(String hometown) {
		this.hometown = hometown;
	}

	public String getHometown() {
		return hometown;
	}

}
