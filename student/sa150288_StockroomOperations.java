package rs.etf.sab.student;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.StockroomOperations;
import rs.etf.sab.student.connection.DB;

public class sa150288_StockroomOperations implements StockroomOperations {

	@Override
	public boolean deleteStockroom(int id) {
		Connection conn=DB.getInstance().getConnection();
		boolean result = false;
		int brObrisanih = 0;
        String query="delete from magacini where id= ?";
        try (
            PreparedStatement stmt=conn.prepareStatement(query)){
            stmt.setInt(1, id);
            brObrisanih = stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(brObrisanih!=0) result=true;
        return result;
	}

	@Override
	public int deleteStockroomFromCity(int id_grada) {
		Connection conn=DB.getInstance().getConnection();
        String query="select m.id from  magacini m join adrese a on m.id_adresa=a.id where a.id_grad= ?";
       int magId=0;
        try (
            PreparedStatement stmt=conn.prepareStatement(query)){
            stmt.setInt(1, id_grada);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
            	magId= rs.getInt(1);
            	boolean deleted=false;
            	deleted = this.deleteStockroom(magId);
            	if(deleted) return magId;
            }
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
	}

	@Override
	public List<Integer> getAllStockrooms() {
		Connection conn=DB.getInstance().getConnection();
		List<Integer> result = new ArrayList<Integer>();
        try (
            Statement stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery("select id from magacini")){
        	while(rs.next()){
                result.add(rs.getInt("id"));               
            }
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
		return result;
	}

	@Override
	public int insertStockroom(int id_adrese) {
		
		if(brMagacinaUGradu(id_adrese)==0) {
			Connection conn=DB.getInstance().getConnection();
	        String query="insert into magacini (id_adresa) values(?)";
	        try (PreparedStatement ps=conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)){
	            ps.setInt(1, id_adrese);
	            ps.executeUpdate();
	            ResultSet rs=ps.getGeneratedKeys();
	            if(rs.next())
	                return rs.getInt(1);
	        } catch (SQLException ex) {
	            Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, ex);
	        }
		}
		
		return -1;
	}
	
	//poziva stored procedure koja vraca broj magacina u nekom gradu tj da li u gradu vec postoji magacin
	public int brMagacinaUGradu(int id_adrese) {
	        Connection conn=DB.getInstance().getConnection();
	        String query="{ call magaciniUGradu (?,?) }"; 
	        try (CallableStatement cs= conn.prepareCall(query)){
	            cs.setInt(1, id_adrese);
	            cs.registerOutParameter(2, java.sql.Types.INTEGER);
	            cs.execute();
	         //   System.out.println("stored procedure call");
	        //    System.out.println(cs.getInt(2));
	            return cs.getInt(2);
	        } catch (SQLException ex) {
	            Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, ex);
	        }
	        return 0;
	}

}
