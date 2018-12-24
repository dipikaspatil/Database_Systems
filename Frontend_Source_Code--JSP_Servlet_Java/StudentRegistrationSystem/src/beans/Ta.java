package beans;

/**
 * POJO Class to represent Teaching Assistant content in TAs DB Table
 */
public class Ta {

	/**
	 * Private Data Members
	 */
	private String bNumber;
	private String taLevel;
	private String office;

	/**
	 * Overridden toString() method
	 */
	@Override
	public String toString() {
		return bNumber + "\t\t" + taLevel + "\t\t" + office;
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
	public String getTaLevel() {
		return taLevel;
	}
	public void setTaLevel(String taLevel) {
		this.taLevel = taLevel;
	}
	public String getOffice() {
		return office;
	}
	public void setOffice(String office) {
		this.office = office;
	}
}
