package rs.etf.sab.student;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.VehicleOperations;
import rs.etf.sab.student.connection.DB;

public class sa150288_VehicleOperations implements VehicleOperations {
	
	public boolean jeUMagacinu(String regBr) {
		
		Connection con = DB.getInstance().getConnection();
	//	String queqry="select m.id from  magacini m join adrese a on m.id_adresa=a.id where a.id_grad= ?";
		String query= "select * from parkirana_vozila where reg_br=?";
		try(PreparedStatement ps =con.prepareStatement(query)){
			ps.setString(1, regBr);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch (SQLException e) {
			 //Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, e);
		}
		
		return false;
	}
	
	public boolean voznjaUToku(String regBr) {
		Connection con = DB.getInstance().getConnection();
		String query = "select * from voznje v  where v.status=? and v.reg_br=?";
		try(PreparedStatement ps =con.prepareStatement(query)){
			ps.setInt(1, 1);
			ps.setString(2, regBr);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				//ako postoji znaci da je voznja u toku
				return true;
			}
		}catch (SQLException e) {
		//	 Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, e);
		}
		return false;
	}

	@Override
	public boolean changeCapacity(String regBr, BigDecimal nosivost) {
		if(this.jeUMagacinu(regBr)==false) return false;
		Connection con = DB.getInstance().getConnection();
		String query="update vozila set nosivost=? where reg_br=?";
		try(PreparedStatement ps =con.prepareStatement(query)){
			ps.setBigDecimal(1, nosivost);
			ps.setString(2, regBr);
			
			int res = ps.executeUpdate();
			if(res>0) {
				return true;
			}
			
		}catch (SQLException e) {
		//	Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, e);
		}
		
		return false;
	}

	@Override
	public boolean changeConsumption(String regBr, BigDecimal potrosnja) {
		if(this.jeUMagacinu(regBr)==false) return false;
		Connection con = DB.getInstance().getConnection();
		String query="update vozila set potrosnja=? where reg_br=?";
		try(PreparedStatement ps =con.prepareStatement(query)){
			ps.setBigDecimal(1, potrosnja);
			ps.setString(2, regBr);
			
			int res = ps.executeUpdate();
			if(res>0) {
				return true;
			}
			
		}catch (SQLException e) {
		//	Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, e);
		}
		
		return false;
	}

	@Override
	public boolean changeFuelType(String regBr, int tip) {
		if(this.jeUMagacinu(regBr)==false) return false;
		Connection con = DB.getInstance().getConnection();
		String query="update vozila set tip_goriva=? where reg_br=?";
		try(PreparedStatement ps =con.prepareStatement(query)){
			ps.setInt(1, tip);
			ps.setString(2, regBr);
			
			int res = ps.executeUpdate();
			if(res>0) {
				return true;
			}
			
		}catch (SQLException e) {
			//Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, e);
		}
		
		return false;
	}

	@Override
	public int deleteVehicles(String... regBrojevi) {
		//prazan niz
		if(regBrojevi.length==0) return 0;
		int result=0;
		Connection conn=DB.getInstance().getConnection();
		String query="delete from vozila where reg_br=?";
		for(int i=0; i<regBrojevi.length; i++) {
			 try (PreparedStatement ps=conn.prepareStatement(query)){
		            ps.setString(1, regBrojevi[i]);
		           
		           result+= ps.executeUpdate();
		        } catch (SQLException ex) {
		         //   Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, ex);
		        }
			
		}
		return result;
	}

	@Override
	public List<String> getAllVehichles() {
		List<String> rezultat = new ArrayList<String>();
		Connection conn=DB.getInstance().getConnection();
        String query="select reg_br from vozila";
        try (PreparedStatement ps=conn.prepareStatement(query)){
        
            ps.executeQuery();
            ResultSet rs= ps.executeQuery();
            while(rs.next()) {
            	rezultat.add(rs.getString("reg_br").trim());
            }
        } catch (SQLException ex) {
           // Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
		return rezultat;
	}

	@Override
	public boolean insertVehicle(String regBr, int tipGoriva, BigDecimal potrosnja, BigDecimal nosivnost) {
		
		if(tipGoriva !=0 && tipGoriva!=1 && tipGoriva!=2) {
			return false;
		}
		int res = -1;
		Connection conn=DB.getInstance().getConnection();
        String query="insert into vozila (reg_br, tip_goriva, potrosnja, nosivost) values(?, ?, ?, ?)";
        try (PreparedStatement ps=conn.prepareStatement(query)){
            ps.setString(1, regBr);
            ps.setInt(2, tipGoriva);
            ps.setBigDecimal(3, potrosnja);
            ps.setBigDecimal(4, nosivnost);
            
            res=ps.executeUpdate();
           
        } catch (SQLException ex) {
        	//Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, ex);
        	return false;
        }
		return res > 0 ? true : false;
	}

	@Override
	public boolean parkVehicle(String regBr, int idMagacin) {
		if(this.voznjaUToku(regBr)==true) return false;
		if(this.jeUMagacinu(regBr)==true) return false; //ako nije u magacinu znaci neko ga vozi
		
		//kod parkiranja postavim idMagacin u samom vozilu i takodje da u kuriru idVozila postavim na null ako ga je vozio
		
		Connection conn=DB.getInstance().getConnection();
        String query="insert into parkirana_vozila (reg_br,id_mag) values (?,?)";
        try (PreparedStatement ps=conn.prepareStatement(query)){
             ps.setString(1, regBr);
        	ps.setInt(2, idMagacin);
            
            int res = ps.executeUpdate();
            if(res<=0) return false; 
        } catch (SQLException ex) {
        //    Logger.getLogger(sa150288_StockroomOperations.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
		
		return true;
	}

	

}
