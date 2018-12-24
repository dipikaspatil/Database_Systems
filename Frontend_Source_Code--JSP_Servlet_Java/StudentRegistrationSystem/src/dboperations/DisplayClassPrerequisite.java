package dboperations;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import dbconutil.DBManagerOracle;

/**
 * Class to display Course Prerequisites for input DEPT_CODE and COURSE#
 */
public class DisplayClassPrerequisite {

	/**
	 * Method to return Prerequisite courses for input DEPT_CODE and COURSE#
	 * @param conn
	 * @param deptCode
	 * @param courseNumber
	 * @return
	 * @throws SQLException
	 */
	public static List<String> getCoursePrerequisite(Connection conn, String deptCode, int courseNumber) throws SQLException {
		// Local variable
		String query = "begin student_registration_system.class_prereq(:1, :2, :3); end;";

		// Enable DBMS_OUTPUT
		DBManagerOracle.enableDbmsOutput(conn);

		// Prepare to call stored procedure
		CallableStatement cs = conn.prepareCall(query);

		// Set dept_code and course# as input parameter
		cs.setString(1, deptCode);
		cs.setInt(2, courseNumber);

		// register the out parameter
		cs.registerOutParameter(3, Types.VARCHAR);

		// Execute the stored procedure
		cs.executeQuery();

		// Print DBMAS_OUTPUT contents on Standard Output
		String dbmsOutputContent = DBManagerOracle.getDbmsOutputContent(conn);

		// Disable DBMS_OUTPUT
		DBManagerOracle.disableDbmsOutput(conn);

		List<String> prereqList = new ArrayList<>();
		if (dbmsOutputContent != null) {
			//System.out.println("DBMS Output --> " + dbmsOutputContent);
			prereqList.add("Error");
			prereqList.add(dbmsOutputContent);
		} else {
			String prereqStr = cs.getString(3);
			if (prereqStr != null && !prereqStr.equals("")) {
				String prereqArr[]= prereqStr.split(",");
				// Save Prerequisite Courses in List of string
				for (String prereq : prereqArr) {
					prereqList.add(prereq.trim());
				}
			}
		}

		return prereqList;
	}
}
