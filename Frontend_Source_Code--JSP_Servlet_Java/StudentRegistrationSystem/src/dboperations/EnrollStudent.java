package dboperations;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbconutil.DBManagerOracle;

/**
 * Class to Enroll Student to Class
 */
public class EnrollStudent {

	/**
	 * Method to call DB procedure to enroll input Student into specific ClassId
	 * @param conn
	 * @param bNumber
	 * @param classId
	 * @return
	 * @throws SQLException
	 */
	public static List<String> enrollStudent(Connection conn, String bNumber, String classId) throws SQLException {
		// Local variable
		String query = "begin student_registration_system.enroll_student(:1, :2); end;";

		// Enable DBMS_OUTPUT
		DBManagerOracle.enableDbmsOutput(conn);

		// Prepare to call stored procedure
		CallableStatement cs = conn.prepareCall(query);

		// Set bNumber and classId as input parameter
		cs.setString(1, bNumber);
		cs.setString(2, classId);

		// Execute the stored procedure
		cs.executeQuery();

		// Print DBMAS_OUTPUT contents on Standard Output
		String dbmsOutputContent = DBManagerOracle.getDbmsOutputContent(conn);

		// Disable DBMS_OUTPUT
		DBManagerOracle.disableDbmsOutput(conn);

		List<String> enrollStudentList = new ArrayList<>();
		if (dbmsOutputContent != null) {
			//System.out.println("DBMS Output --> " + dbmsOutputContent);
			if (dbmsOutputContent.startsWith("MSG")) {
				enrollStudentList.add("Warning");
				enrollStudentList.add(dbmsOutputContent);
			} else {
				enrollStudentList.add("Error");
				enrollStudentList.add(dbmsOutputContent);
			}
		} else {
			enrollStudentList.add("Error");
			enrollStudentList.add("Some unexpected problem occured.");
		}

		return enrollStudentList;
	}
}
