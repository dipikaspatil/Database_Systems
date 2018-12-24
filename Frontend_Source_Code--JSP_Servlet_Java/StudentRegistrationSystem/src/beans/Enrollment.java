package beans;

/**
 * POJO Class to represent Enrollment content in Enrollments DB Table
 */
public class Enrollment {

	/**
	 * Private Data Members
	 */
	private String bNumber;
	private String classId;
	private String lGrade;

	/**
	 * Overridden toString() method
	 */
	@Override
	public String toString() {
		return bNumber + "\t\t" + classId + "\t\t" + lGrade;
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
	public String getClassId() {
		return classId;
	}
	public void setClassId(String classId) {
		this.classId = classId;
	}
	public String getlGrade() {
		return lGrade;
	}
	public void setlGrade(String lGrade) {
		this.lGrade = lGrade;
	}
}
