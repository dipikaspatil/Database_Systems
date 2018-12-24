package dbconutil;

import java.sql.CallableStatement;
import java.sql.Connection;

/**
 * Utility class to get contents printed by DBMS_OUTPUT.PUT_LINE at Oracle side
 */
public class DBManagerOracle {

	/**
	 * Method to enable DBMS_OUTPUT
	 * @param conn
	 */
	public static void enableDbmsOutput(Connection conn) {
		try {
			CallableStatement stmt = conn.prepareCall("{call sys.dbms_output.enable()}");
			stmt.execute();
		} catch(Exception e) {
			System.out.println("Problemrred during enabling dbms_output " + e.toString());
		}
	}

	/**
	 * Method to get contents of DBMS_OUTPUT
	 * @param conn
	 */
	public static String getDbmsOutputContent(Connection conn) {
		String outputContent = null;
		try {
			CallableStatement stmt = conn.prepareCall("{call sys.dbms_output.get_line(?,?)}"); 
			stmt.registerOutParameter(1,java.sql.Types.VARCHAR);
			stmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			//stmt.execute();
			//outputContent = stmt.getString(1);
			//int status = stmt.getInt(2);
			int status;
			do {
				stmt.execute();
				//System.out.println(" " + stmt.getString(1));
				if (outputContent == null) {
					outputContent = stmt.getString(1);
				} else {
					if (stmt.getString(1) != null) {
						outputContent = outputContent + stmt.getString(1);
					}
				}
				status = stmt.getInt(2);
			} while (status == 0);

		} catch (Exception e) {
			System.out.println("Problem during getting content of dbms_output! "+e.toString());
		}
		return outputContent;
	}

	/**
	 * Method to disable DBMS_OUTPUT
	 * @param conn
	 */
	public static void disableDbmsOutput(Connection conn) {
		try { 
			CallableStatement stmt = conn.prepareCall("{call sys.dbms_output.disable()}");
			stmt.execute();
		} catch(Exception e) {
			System.out.println("Problemrred during disabling dbms_output " + e.toString());
		}
	}
}
