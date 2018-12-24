package beans;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * POJO Class to represent Student content in Students DB Table
 */
public class Student {

	/**
	 * Private Data Members
	 */
	private String bNumber;
	private String firstName;
	private String lastName;
	private String status;
	private float gpa;
	private String email;
	private Date birthDate;
	private String deptName;

	/**
	 * Overridden toString() method
	 */
	@Override
	public String toString() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
		return bNumber + "\t\t" + firstName + "\t\t" + lastName + "\t\t"
		+ status + "\t\t" + Float.toString(gpa) + "\t\t"
		+ email + "\t\t" + dateFormat.format(birthDate) + "\t\t" + deptName;
	}

	/**
	 * Getters and Setters
	 */
	public String getbNumber() {
		return bNumber;
	}
	public void setbNumber(String bNumber) {
		this.bNumber = bNumber;
	}
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public float getGpa() {
		return gpa;
	}
	public void setGpa(float gpa) {
		this.gpa = gpa;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
}
