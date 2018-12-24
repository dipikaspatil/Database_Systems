package dboperations;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import dbconutil.DBManagerOracle;

/**
 * Class to display TA details for specific ClassId
 */
public class DisplayClassTADetails {

	/**
	 * Method to return TA details for input ClassId
	 * @param conn, classId
	 * @return TA Details
	 * @throws SQLException
	 */
	public static List<String> showClassTaDetails(Connection conn, String classId) throws SQLException {
		// Local variable
		String query = "begin student_registration_system.class_ta(:1, :2, :3, :4); end;";

		// Enable DBMS_OUTPUT
		DBManagerOracle.enableDbmsOutput(conn);

		// Prepare to call stored procedure
		CallableStatement cs = conn.prepareCall(query);

		// Set classId as input parameter
		cs.setString(1, classId);

		// register the out parameter (second, third and fourth parameters)
		cs.registerOutParameter(2, Types.VARCHAR);
		cs.registerOutParameter(3, Types.VARCHAR);
		cs.registerOutParameter(4, Types.VARCHAR);

		// Execute the stored procedure
		cs.executeQuery();

		// Print DBMAS_OUTPUT contents on Standard Output
		String dbmsOutputContent = DBManagerOracle.getDbmsOutputContent(conn);

		// Disable DBMS_OUTPUT
		DBManagerOracle.disableDbmsOutput(conn);

		List<String> taDeatilsList = new ArrayList<>();
		if (dbmsOutputContent != null) {
			//System.out.println("DBMS Output --> " + dbmsOutputContent);
			taDeatilsList.add("Error");
			taDeatilsList.add(dbmsOutputContent);
		} else {
			String bNumber = cs.getString(2);
			String firstName = cs.getString(3);
			String lastName = cs.getString(4);

			// Save TA details in List of string
			if (bNumber != null) {
				taDeatilsList.add(bNumber);
			}
			if (firstName != null) {
				taDeatilsList.add(firstName);
			}
			if (lastName != null) {
				taDeatilsList.add(lastName);
			}
		}

		return taDeatilsList;
	}
}
