package beans;

/**
 * POJO Class to represent Course content in Courses DB Table
 */
public class Course {

	/**
	 * Private Data Members
	 */
	private String deptCode;
	private int courseNumber;
	private String title;

	/**
	 * Overridden toString() method
	 */
	@Override
	public String toString() {
		return deptCode + "\t\t" + Integer.toString(courseNumber) + "\t\t" + title;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
}
