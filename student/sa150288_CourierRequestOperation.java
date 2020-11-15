package rs.etf.sab.student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.CourierRequestOperation;
import rs.etf.sab.student.connection.DB;

public class sa150288_CourierRequestOperation implements CourierRequestOperation {

	@Override
	public boolean changeDriverLicenceNumberInCourierRequest(String username, String brVozacke) {
		int changed = 0;
		Connection con = DB.getInstance().getConnection();
		String query="update kurir_zahtevi set br_vozacke=? where username=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setString(1, brVozacke);
			ps.setString(2,username);
			changed = ps.executeUpdate();
		} catch (SQLException e) {
			//Logger.getLogger(sa150288_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, e);
			return false;
		}
		if(changed>0) return true;
		return false;
	}

	@Override
	public boolean deleteCourierRequest(String username) {
		int deleted = 0;
		Connection con = DB.getInstance().getConnection();
		String query = "delete from kurir_zahtevi where username=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setString(1, username);
			deleted = ps.executeUpdate();
			
		} catch (SQLException e) {
		//	Logger.getLogger(sa150288_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, e);
			return false;
		}
		if(deleted>0) return true;
		return false;
	}

	@Override
	public List<String> getAllCourierRequests() {
		List<String> lista = new ArrayList<String>();
		Connection con = DB.getInstance().getConnection();
		String query = "select username from kurir_zahtevi";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				lista.add(rs.getString("username").trim());
			}
		} catch (SQLException e) {
			//Logger.getLogger(sa150288_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, e);
			return lista;
		}
		return lista;
	}

	@Override
	public boolean grantRequest(String username) {
		
		int updated = 0;
		Connection con = DB.getInstance().getConnection();
		String query = "update kurir_zahtevi set approved=? where username=?";
		try(PreparedStatement ps =con.prepareStatement(query)){
			ps.setInt(1, 1);
			ps.setString(2, username);
			updated = ps.executeUpdate();
		} catch (SQLException e) {
		//	Logger.getLogger(sa150288_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, e);
			return false;
		}
		if(updated<=0) return false;
		
		
		return true;
	}

	@Override
	public boolean insertCourierRequest(String username, String brVozacke) {

		int inserted=0;
		Connection con = DB.getInstance().getConnection();
		String query1="select * from kuriri where username=?";
		try(PreparedStatement ps = con.prepareStatement(query1))
		{
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				return false;
			}
			
		} catch (SQLException e) {
			//Logger.getLogger(sa150288_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, e);
			return false;
		}
		
		String query="insert into kurir_zahtevi (username,br_vozacke, approved) values (?, ?, ?)";
		try(PreparedStatement ps = con.prepareStatement(query))
		{
			ps.setString(1, username);
			ps.setString(2, brVozacke);
			ps.setInt(3, 0);
			inserted = ps.executeUpdate();
			
		} catch (SQLException e) {
			//Logger.getLogger(sa150288_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, e);
			return false;
		}
		if(inserted>0) return true;
		return false;
	}

	

}
