package dboperations;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbconutil.DBManagerOracle;

/**
 * Class to delete existing Student from DB
 */
public class DeleteStudent {

	/**
	 * Method to call DB procedure to delete input Student
	 * @param conn
	 * @param bNumber
	 * @return
	 * @throws SQLException
	 */
	public static List<String> deleteStudent(Connection conn, String bNumber) throws SQLException {
		// Local variable
		String query = "begin student_registration_system.delete_student(:1); end;";

		// Enable DBMS_OUTPUT
		DBManagerOracle.enableDbmsOutput(conn);

		// Prepare to call stored procedure
		CallableStatement cs = conn.prepareCall(query);

		// Set bNumber as input parameter
		cs.setString(1, bNumber);

		// Execute the stored procedure
		cs.executeQuery();

		// Print DBMAS_OUTPUT contents on Standard Output
		String dbmsOutputContent = DBManagerOracle.getDbmsOutputContent(conn);

		// Disable DBMS_OUTPUT
		DBManagerOracle.disableDbmsOutput(conn);

		List<String> deleteStudentList = new ArrayList<>();
		if (dbmsOutputContent != null) {
			//System.out.println("DBMS Output --> " + dbmsOutputContent);
			if (dbmsOutputContent.startsWith("MSG")) {
				deleteStudentList.add("Warning");
				deleteStudentList.add(dbmsOutputContent);
			} else {
				deleteStudentList.add("Error");
				deleteStudentList.add(dbmsOutputContent);
			}
		} else {
			deleteStudentList.add("Error");
			deleteStudentList.add("Some unexpected problem occured.");
		}

		return deleteStudentList;
	}
}
