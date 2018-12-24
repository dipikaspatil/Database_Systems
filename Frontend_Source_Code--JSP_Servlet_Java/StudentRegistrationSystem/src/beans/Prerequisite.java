package beans;

/**
 * POJO Class to represent Prerequisite content in Prerequisites DB Table
 */
public class Prerequisite {

	/**
	 * Private Data Members
	 */
	private String deptCode;
	private int courseNumber;
	private String preDeptCode;
	private int preCourseNumber;

	/**
	 * Overridden toString() method
	 */
	@Override
	public String toString() {
		return deptCode + "\t\t" + Integer.toString(courseNumber) + "\t\t" + preDeptCode + Integer.toString(preCourseNumber);
	}

	/**
	 * Getters and Setters
	 */
	public String getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	public int getCourseNumber() {
		return courseNumber;
	}
	public void setCourseNumber(int courseNumber) {
		this.courseNumber = courseNumber;
	}
	public String getPreDeptCode() {
		return preDeptCode;
	}
	public void setPreDeptCode(String preDeptCode) {
		this.preDeptCode = preDeptCode;
	}
	public int getPreCourseNumber() {
		return preCourseNumber;
	}
	public void setPreCourseNumber(int preCourseNumber) {
		this.preCourseNumber = preCourseNumber;
	}
}
