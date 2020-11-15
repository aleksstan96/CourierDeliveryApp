package rs.etf.sab.student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.GeneralOperations;
import rs.etf.sab.student.connection.DB;

public class sa150288_GeneralOperations implements GeneralOperations {

	@Override
	public void eraseAll() {
		String query="";
		
		query="delete from kuriri_za_magacin";
        delete(query);
		
		query="delete from kuriri_isporuke";
        delete(query);
        
        query="delete from kuriri_preuzimanje";
        delete(query);
		
		query="delete from parkirana_vozila";
        delete(query);

		
		query="delete from isporuke";
        delete(query);
		
		query="delete from zahtevi_isporuka";
        delete(query);
        

		query="delete from voznje";
        delete(query);
		
		query="delete from kuriri";
        delete(query);
		
		query="delete from kurir_zahtevi";
        delete(query);
		
		query="delete from korisnici";
        delete(query);
		
		query="delete from vozila";
        delete(query);
        
		//magacini
		 query="delete from magacini";
	     delete(query);
	        
		//adrese
        query="delete from adrese";
        delete(query);
        
        //gradovi
        query="delete from gradovi";
        delete(query);

	}

	private void delete(String query) {
		Connection conn=DB.getInstance().getConnection();
		try (PreparedStatement stmt=conn.prepareStatement(query)){
            
            int result = stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
	}

}
