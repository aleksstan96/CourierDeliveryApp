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

import rs.etf.sab.operations.CourierOperations;
import rs.etf.sab.student.connection.DB;

public class sa150288_CourierOperations implements CourierOperations {

	@Override
	public boolean deleteCourier(String username) {
		Connection conn = DB.getInstance().getConnection();
		String query="delete from kuriri where username=?";
		try(PreparedStatement ps = conn.prepareStatement(query)){
			ps.setString(1, username);
			int res = ps.executeUpdate();
			if(res>0) return true;
			
		} catch (SQLException e) {
			Logger.getLogger(sa150288_CourierOperations.class.getName()).log(Level.SEVERE, null, e);

		}
		return false;
	}

	@Override
	public List<String> getAllCouriers() {
		 List<String> lista = new ArrayList<String>();
		 Connection con = DB.getInstance().getConnection();
		 String query="select username from kuriri order by profit desc";
		 try(PreparedStatement ps = con.prepareStatement(query)){
			 ResultSet rs = ps.executeQuery();
			 while(rs.next()) {
				 lista.add(rs.getString(1));
			 }
		 } catch (SQLException e) {
			 Logger.getLogger(sa150288_CourierOperations.class.getName()).log(Level.SEVERE, null, e);

		}
		return lista;
	}

	@Override
	public BigDecimal getAverageCourierProfit(int brIsporuka) {
		BigDecimal avg = new BigDecimal(0);
		String query;
		 Connection con = DB.getInstance().getConnection();
		 if(brIsporuka==-1) {
			 query="select avg(profit) from kuriri";
			 try(PreparedStatement ps = con.prepareStatement(query)){
				 ps.setInt(1, brIsporuka);
				 ResultSet rs = ps.executeQuery();
				 if(rs.next()) {
					 return rs.getBigDecimal(1);
				 }
			 } catch (SQLException e) {
				 Logger.getLogger(sa150288_CourierOperations.class.getName()).log(Level.SEVERE, null, e);

			}
		 }else {
			  query="select avg(profit) from kuriri where br_isporucenih_paketa=?";
		 }
		 
		 try(PreparedStatement ps = con.prepareStatement(query)){
			 ps.setInt(1, brIsporuka);
			 ResultSet rs = ps.executeQuery();
			 if(rs.next()) {
				 return rs.getBigDecimal(1);
			 }
		 } catch (SQLException e) {
			 Logger.getLogger(sa150288_CourierOperations.class.getName()).log(Level.SEVERE, null, e);

		}
		return avg;
	}

	@Override
	public List<String> getCouriersWithStatus(int status) {
		List<String> lista = new ArrayList<String>();
		
		 Connection con = DB.getInstance().getConnection();
		 String query="select username from kuriri where status=?";
		 try(PreparedStatement ps = con.prepareStatement(query)){
			 ps.setInt(1, status);
			 ResultSet rs = ps.executeQuery();
			 while(rs.next()) {
				 lista.add(rs.getString(1).trim());
			 }
		 } catch (SQLException e) {
			 Logger.getLogger(sa150288_CourierOperations.class.getName()).log(Level.SEVERE, null, e);

		}
		return lista;
	}

	@Override
	public boolean insertCourier(String username, String vozacka) {
		Connection conn = DB.getInstance().getConnection();
		String query="insert into kuriri (username,br_vozacke) values (?,?)";
		try(PreparedStatement ps = conn.prepareStatement(query)){
			ps.setString(1, username);
			ps.setString(2, vozacka);
			int res = ps.executeUpdate();
			if(res>0) return true;
			
		} catch (SQLException e) {
			Logger.getLogger(sa150288_CourierOperations.class.getName()).log(Level.SEVERE, null, e);

		}
		return false;
	}

}
