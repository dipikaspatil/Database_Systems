package dbconutil;

import java.sql.Connection;
import java.sql.SQLException;

import oracle.jdbc.pool.OracleDataSource;

/**
 * Class to represent Oracle Connection functionality
 */
public class OraConnection {

	/**
	 * Private Constants
	 */
	private static final String port = "1521";
	private static final String dbName = "NITESHDB";
	private static final String hostName = "192.168.0.103";
	private static final String driverName = "jdbc:oracle:thin";

	/**
	 * Private Data Members
	 */
	private String username;
	private String password;
	public static Connection dbConnection;

	public OraConnection(String usernameIn, String passwordIn) {
		username = usernameIn;
		password = passwordIn;
	}

	/**
	 * Method to establish database connection
	 * @throws SQLException
	 */
	public void createConnection() throws SQLException {
		// Create data source object and initialize it
		OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
		ds.setURL(driverName + ":@" + hostName + ":" + port + ":" + dbName);
		dbConnection = ds.getConnection(username, password);
	}

	/**
	 * Method to close database connection
	 * @throws SQLException
	 */
	public void closeConnection() throws SQLException {
		dbConnection.close();
	}

	/**
	 * Setters and Getters
	 */
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
