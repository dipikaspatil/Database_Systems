package dboperations;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbconutil.DBManagerOracle;

/**
 * Class to Delete Enrollment of Student from specific Class
 */
public class DeleteStudentEnrollment {

	/**
	 * Method to call DB procedure to delete input Student's enrollment from specific ClassId
	 * @param conn
	 * @param bNumber
	 * @param classId
	 * @return
	 * @throws SQLException
	 */
	public static List<String> deleteStudentEnrollment(Connection conn, String bNumber, String classId) throws SQLException {
		// Local variable
		String query = "begin student_registration_system.delete_student_enrollment(:1, :2); end;";

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

		List<String> deleteStudentEnrollmentList = new ArrayList<>();
		if (dbmsOutputContent != null) {
			//System.out.println("DBMS Output --> " + dbmsOutputContent);
			if (dbmsOutputContent.startsWith("MSG")) {
				deleteStudentEnrollmentList.add("Warning");
				deleteStudentEnrollmentList.add(dbmsOutputContent);
			} else {
				deleteStudentEnrollmentList.add("Error");
				deleteStudentEnrollmentList.add(dbmsOutputContent);
			}
		} else {
			deleteStudentEnrollmentList.add("Error");
			deleteStudentEnrollmentList.add("Some unexpected problem occured.");
		}

		return deleteStudentEnrollmentList;
	}
}
