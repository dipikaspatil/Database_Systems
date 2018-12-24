package beans;

/**
 * POJO Class to represent Class content in Classes DB Table
 */
public class Classes {

	/**
	 * Private Data Members
	 */
	private String classId;
	private String deptCode;
	private int courseNumber;
	private int sectionNumber;
	private int year;
	private String semester;
	private int limit;
	private int classSize;
	private String room;
	private String taBNumber;

	/**
	 * Overridden toString() method
	 */
	@Override
	public String toString() {
		return classId + "\t\t" + deptCode + "\t\t" + Integer.toString(courseNumber) + "\t\t"
				+ Integer.toString(sectionNumber) + "\t\t" + Integer.toString(year) + "\t\t"
				+ semester + "\t\t" + Integer.toString(limit) + "\t\t" + Integer.toString(classSize) + "\t\t"
				+ room + "\t\t" + taBNumber;
	}

	/**
	 * Getters and Setters
	 */
	public String getClassId() {
		return classId;
	}
	public void setClassId(String classId) {
		this.classId = classId;
	}
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
	public int getSectionNumber() {
		return sectionNumber;
	}
	public void setSectionNumber(int sectionNumber) {
		this.sectionNumber = sectionNumber;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public String getSemester() {
		return semester;
	}
	public void setSemester(String semester) {
		this.semester = semester;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public int getClassSize() {
		return classSize;
	}
	public void setClassSize(int classSize) {
		this.classSize = classSize;
	}
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public String getTaBNumber() {
		return taBNumber;
	}
	public void setTaBNumber(String taBNumber) {
		this.taBNumber = taBNumber;
	}
}
