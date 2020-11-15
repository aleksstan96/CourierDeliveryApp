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

import rs.etf.sab.operations.AddressOperations;
import rs.etf.sab.student.connection.DB;

public class sa150288_AddressOperations implements AddressOperations {

	@Override
	public int deleteAllAddressesFromCity(int id_grada) {
		Connection conn=DB.getInstance().getConnection();
		int brObrisanih = 0;
        String query="delete from adrese where id_grad= ?";
        try (
            PreparedStatement stmt=conn.prepareStatement(query)){
       
            stmt.setInt(1, id_grada);
            brObrisanih = stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_AddressOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return brObrisanih;
	}

	@Override
	public boolean deleteAdress(int id) {
		Connection conn=DB.getInstance().getConnection();
		boolean result = false;
		int brObrisanih = 0;
        String query="delete from adrese where id= ?";
        try (
            PreparedStatement stmt=conn.prepareStatement(query)){
            stmt.setInt(1, id);
            brObrisanih = stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_AddressOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(brObrisanih!=0) result=true;
        return result;
	}

	@Override
	public int deleteAddresses(String naziv, int broj) {
		Connection conn=DB.getInstance().getConnection();
		int brObrisanih = 0;
        String query="delete from adrese where ulica= ? and broj= ?";
        try (
            PreparedStatement stmt=conn.prepareStatement(query)){
        	stmt.setString(1, naziv);
            stmt.setInt(2, broj);
            brObrisanih = stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_AddressOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return brObrisanih;
	}

	@Override
	public List<Integer> 	getAllAddresses() {
		Connection conn=DB.getInstance().getConnection();
		List<Integer> result = new ArrayList<Integer>();
        try (
            Statement stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery("select id from adrese")){
        	while(rs.next()){
                result.add(rs.getInt("id"));               
            }
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_AddressOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
		return result;
	}

	@Override
	public List<Integer> getAllAddressesFromCity(int id_grada) {
		Connection conn=DB.getInstance().getConnection();
		List<Integer> result = new ArrayList<Integer>();
		String query = "select id from adrese where id_grad= ?";
        try (PreparedStatement ps=conn.prepareStatement(query)){
        	ps.setInt(1, id_grada);
        	ResultSet rs = ps.executeQuery();
        	while(rs.next()){
                result.add(rs.getInt("id"));               
            }
        	
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_AddressOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(result.size()==0) {
        	return null;
        }else {
        	return result;
        }
		
	}

	@Override
	public int insertAddress(String ulica, int broj, int gradId, int x, int y) {
		//System.out.println("insertAdress");
		if(gradId<1) return -1;
		Connection conn=DB.getInstance().getConnection();
		
//		String q1= "select * from gradovi where id=?";
//		 try (PreparedStatement ps=conn.prepareStatement(q1)){
//	        	ps.setInt(1, gradId);
//	        	ResultSet rs = ps.executeQuery();
//	        	if(!rs.next()){
//	        		System.out.println("Minus jedan");
//	                return -1;               
//	            }
//	        } catch (SQLException ex) {
//	        	
//	            Logger.getLogger(sa150288_AddressOperations.class.getName()).log(Level.SEVERE, null, ex);
//	            return -1; 
//	        }
		
        String query="insert into adrese (id_grad, ulica, broj, x, y) values(?, ?, ?, ?, ?)";
        try (PreparedStatement ps=conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)){
            ps.setInt(1, gradId);
            ps.setString(2, ulica);
            ps.setInt(3, broj);
            ps.setInt(4, x);
            ps.setInt(5, y);
            ps.executeUpdate();
            ResultSet rs=ps.getGeneratedKeys();
            if(rs.next()) {
            	//System.out.println("Insertovanje adrese, novi id-jevi:" + rs);
            	//System.out.println(rs.getInt(1));
                return rs.getInt(1);
            }
            	
        } catch (SQLException ex) {
        //    Logger.getLogger(sa150288_AddressOperations.class.getName()).log(Level.SEVERE, null, ex);
           
        }
   //     System.out.println("Minus jedan");
        return -1;
	}

}
