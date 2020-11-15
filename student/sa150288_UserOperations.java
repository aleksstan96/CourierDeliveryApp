package rs.etf.sab.student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.UserOperations;
import rs.etf.sab.student.connection.DB;

public class sa150288_UserOperations implements UserOperations {

	@Override
	public boolean declareAdmin(String username) {
		Connection con = DB.getInstance().getConnection();
		
		String query = "select * from korisnici where isAdmin=? and username=? ";
		try(PreparedStatement ps =con.prepareStatement(query)){
			ps.setInt(1, 1);
			ps.setString(2, username);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				//System.out.println("Vec admin");
				return false;
			}
				
			
		}catch (SQLException e) {
			Logger.getLogger(sa150288_UserOperations.class.getName()).log(Level.SEVERE, null, e);
			return false;
		}
		
		int res = 0;
		query="update korisnici set isAdmin=? where username=?";
		try(PreparedStatement ps=con.prepareStatement(query)){
			ps.setInt(1, 1);
			ps.setString(2, username);
			res = ps.executeUpdate();
		}catch (SQLException e) {
			//Logger.getLogger(sa150288_UserOperations.class.getName()).log(Level.SEVERE, null, e);
			return false;
		}
		if(res>0) return true;
		return false;
	}

	@Override
	public int deleteUsers(String... arg0) {
		int result = 0;
		Connection con = DB.getInstance().getConnection();
		String query = "delete from korisnici where username=?";
		for(int i=0; i<arg0.length;i++) {
			try(PreparedStatement ps = con.prepareStatement(query)){
				
					ps.setString(1, arg0[i]);
					result+= ps.executeUpdate();
				
			}catch (Exception e) {
			//	Logger.getLogger(sa150288_UserOperations.class.getName()).log(Level.SEVERE, null, e);
				
			}
		
		}
		return result;
	}

	@Override
	public List<String> getAllUsers() {
		Connection con = DB.getInstance().getConnection();
		List<String> korisnici = new ArrayList<String>();
		String query = "select username from korisnici";
		try(PreparedStatement ps =con.prepareStatement(query)){
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				korisnici.add(rs.getString(1).trim());
			}
			
		}catch (SQLException e) {
		//	Logger.getLogger(sa150288_UserOperations.class.getName()).log(Level.SEVERE, null, e);
			
		}
		return korisnici;
		
	}

	@Override
	public int getSentPackages(String... arg0) {
		
		String usernames = HelperClass.formatirajUSkup(arg0);
		Connection conn=DB.getInstance().getConnection();
		int result = 0;
        String query="select count(*) as cnt from korisnici where username in " + usernames;
        try (
            PreparedStatement stmt=conn.prepareStatement(query)){
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) result = rs.getInt("cnt");
            
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(result==0) return -1;
        
		int cnt = 0;
		Connection con = DB.getInstance().getConnection();
		String quer = "select count(*) from isporuke where username=? and (status=? or status=? or status=?)";
		for(int i=0; i<arg0.length;i++) {
			try(PreparedStatement ps = con.prepareStatement(quer)){
				ps.setString(1, arg0[i]);
				ps.setInt(2, 1);
				ps.setInt(3, 2);
				ps.setInt(4, 3);
				ResultSet rs = ps.executeQuery();
				if(rs.next()) cnt+=rs.getInt(1);
			} catch (SQLException e) {
				Logger.getLogger(sa150288_UserOperations.class.getName()).log(Level.SEVERE, null, e);
				return -1;
			}
		}
		return cnt;
	}

	@Override
	public boolean insertUser(String username, String ime, String prezime, String password, int idAdr) {
		// System.out.println(username +" "+ ime+" "+prezime+" "+password);
	     String pattern = "(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[.,@#$%^&_:*;+=]).{8,}";
//	   //  System.out.println(password);
	      if(!password.matches(pattern)) {
	    	// System.out.println("Password ne valja");
	    	  return false;
	      }
	      pattern = "^[A-Z].{0,}";
	  //    System.out.println(ime);
	      if(!ime.matches(pattern)) {
	    //	  System.out.println("ime ne valja");
	    	  return false;
	      }
	      if(!prezime.matches(pattern)) {
	   // 	  System.out.println("prezime ne valja");
	    	  return false;
	      }
		
		
		int res = 0;
		Connection con = DB.getInstance().getConnection();
		String query = "insert into korisnici (username, ime, prezime, password, id_adresa, isAdmin) values (?, ?, ?, ?, ?, ?)";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setString(1, username);
			ps.setString(2, ime);
			ps.setString(3, prezime);
			ps.setString(4, password);
			ps.setInt(5, idAdr);
			ps.setInt(6, 0);
			res = ps.executeUpdate();
		}catch (SQLException ex) {
		//	Logger.getLogger(sa150288_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
		return false;
		}
		if(res>0) return true;
		return false;
	}



}
