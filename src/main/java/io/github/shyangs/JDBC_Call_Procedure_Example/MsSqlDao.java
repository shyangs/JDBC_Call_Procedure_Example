/**
 * 
 */
package io.github.shyangs.JDBC_Call_Procedure_Example;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Types;

public class MsSqlDao {

	private Connection connection = null;

	// ConnectionString to the database
//	private final static String dbConnection = "jdbc:mysql://localhost/MyDbName?user=hartigehap&password=wachtwoord";
//	private final static String dbConnection = "jdbc:mariadb://127.0.0.1:3306/MyDbName?user=root&password=pa55w0rd123456";
//	private final static String dbConnection = "jdbc:sqlserver://127.0.0.1\\SQLEXPRESS:1433;databaseName=MyDbName";
	private final static String dbConnection = "jdbc:sqlserver://127.0.0.1\\MSSQLSERVER:1433;databaseName=MyDbName";

	public void useDataBase() {

		try {
			// This will load the DB driver; each different DB provider has its own driver
//			Class.forName("com.mysql.jdbc.Driver");
//			Class.forName("org.mariadb.jdbc.Driver");
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			System.out.println("Successfully found the database driver");
		} catch (Exception ex) {
			System.out.println("Exception: " + ex.getMessage());
		}

		try {
			// Setup the connection with the DB
			connection = DriverManager.getConnection(dbConnection, "sa", "pa55w0rd123456");
			System.out.println("Successfully connected to the database");
		} catch (Exception ex) {
			System.out.println("Exception: " + ex.getMessage());
		}
		System.out.println("-------");

		
		//
		// DEMO: calling database stored procedures
		//
		CallableStatement cs;
		try {
			// 設定 CallableStatement
			cs = connection.prepareCall("{call MYSPCONCAT(?,?,?)}");

			// 設定 IN參數的 Index 及值
			cs.setString(1, "ABCD");
			cs.setString(2, "123");
			
			// 定義 OUT 參數的 Index 與型態
			cs.registerOutParameter(3, Types.VARCHAR);
			
		    // 執行並取回 OUT 參數值 
		    cs.execute(); 
		    String outParam = cs.getString(3); // OUT 回傳值.
		    System.out.println(outParam);
		} catch (SQLException ex) {
			System.out.println("Exception: " + ex.getMessage());
		}
		System.out.println("-------");

		// Finally, close the connection to the database.
		close();
	}


	/**
	 * You need to close the resultSet after its last use.
	 */
	private void close() {
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (Exception e) {

		}
	}
}
