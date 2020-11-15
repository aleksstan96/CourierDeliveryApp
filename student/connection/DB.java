package rs.etf.sab.student.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB {
	
	private static final String username = "sa";
	private static final String password = "123";
	private static final String nazivBaze = "sab_projekat_2020";
	private static final String server = "localhost";
	private static final int port = 1433;
	private static final String connectionUrl = "jdbc:sqlserver://" + server + ":" +  port + ";database=" + nazivBaze;
	
	private static DB db = null;
	
	private Connection con;
	
	private DB() {
		 try {
			con = DriverManager.getConnection(connectionUrl, username, password);
			System.out.println("Konekcija uspela");
		} catch (SQLException e) {
			System.out.println("Konekcija nije uspela");
		}
	}
	
	public static DB getInstance() {
		if(db==null) 
			db = new DB();
		return db;
		
	}

	public Connection getConnection() {
		return con;
	}

	
	
	

}
