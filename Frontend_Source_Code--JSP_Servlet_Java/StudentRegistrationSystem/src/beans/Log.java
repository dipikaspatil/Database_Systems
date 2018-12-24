package beans;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * POJO Class to represent Log content in Logs DB Table
 */
public class Log {

	/**
	 * Private Data Members
	 */
	private int logNumber;
	private String opName;
	private Date opTime;
	private String tableName;
	private String operation;
	private String keyvalue;

	/**
	 * Overridden toString() method
	 */
	@Override
	public String toString() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
		return Integer.toString(logNumber) + "\t\t" + opName + "\t\t" + dateFormat.format(opTime) + "\t\t"
		+ tableName + "\t\t" + operation + "\t\t" + keyvalue;
	}

	/**
	 * Getters and Setters
	 */
	public int getLogNumber() {
		return logNumber;
	}
	public void setLogNumber(int logNumber) {
		this.logNumber = logNumber;
	}
	public String getOpName() {
		return opName;
	}
	public void setOpName(String opName) {
		this.opName = opName;
	}
	public Date getOpTime() {
		return opTime;
	}
	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getOperation() {
		return operation;
	}
	public void setOperation(String operation) {
		this.operation = operation;
	}
	public String getKeyvalue() {
		return keyvalue;
	}
	public void setKeyvalue(String keyvalue) {
		this.keyvalue = keyvalue;
	}
}
