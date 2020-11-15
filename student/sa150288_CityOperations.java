package rs.etf.sab.student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.CityOperations;
import rs.etf.sab.student.connection.DB;

public class sa150288_CityOperations implements CityOperations {

//	@Override
//	public int deleteCity(String... arg0) {
//		String gradoviImena = HelperClass.formatirajUSkup(arg0);
//		Connection conn=DB.getInstance().getConnection();
//		int result = 0;
//        String query="delete from gradovi where naziv in " + gradoviImena;
//        try (
//            PreparedStatement stmt=conn.prepareStatement(query)){
//            
//            result = stmt.executeUpdate();
//        } catch (SQLException ex) {
//            Logger.getLogger(sa150288_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return result;
//	}
	
	@Override
	public int deleteCity(String... arg0) {
		//String gradoviImena = HelperClass.formatirajUSkup(arg0);
		Connection conn=DB.getInstance().getConnection();
		 String query="delete from gradovi where naziv= ?";
		//String[] gradovi = arg0;
		int result = 0;
		for(int i=0; i<arg0.length;i++) {
			
			try (
            PreparedStatement stmt=conn.prepareStatement(query)){
            stmt.setString(1, arg0[i]);
            result += stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
           // return -1;
        }
			
		}
       
        
        return result;
	}

	@Override
	public boolean deleteCity(int arg0) {
		//System.out.println("Brisanje grada id=" + arg0);
		Connection conn=DB.getInstance().getConnection();
		boolean result = false;
		int brObrisanih = 0;
        String query="delete from gradovi where id= ?";
        try (
            PreparedStatement stmt=conn.prepareStatement(query)){
            stmt.setInt(1, arg0);
            brObrisanih = stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(brObrisanih!=0) result=true;
        return result;
	}

	@Override
	public List<Integer> getAllCities() {
		//System.out.println("Get all cities ");
		Connection conn=DB.getInstance().getConnection();
		List<Integer> result = new ArrayList<Integer>();
        try (
            Statement stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery("select id from gradovi")){
        	while(rs.next()){
                result.add(rs.getInt("id"));               
            }
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
		return result;
	}

	@Override
	public int insertCity(String arg0, String arg1) {
		
		//System.out.println("Insertovanje grada" + arg0);
		Connection conn=DB.getInstance().getConnection();
		
		
		String query="insert into gradovi (naziv, postanski_br) values(?, ?)";
		
        try (PreparedStatement ps=conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)){
            ps.setString(1, arg0);
            ps.setString(2, arg1);
            ps.executeUpdate();
            ResultSet rs=ps.getGeneratedKeys();
            if(rs.next())
                return rs.getInt(1);
        } catch (SQLException ex) {
          //  Logger.getLogger(sa150288_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
            //return -1;
        }
        return -1;
        
	}

}
