package rs.etf.sab.student;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.DriveOperation;
import rs.etf.sab.student.connection.DB;

public class sa150288_DriveOperation implements DriveOperation {

	@Override
	public List<Integer> getPackagesInVehicle(String usernameKurir) {
		
		List<Integer> ids = new ArrayList<Integer>();
		
		Connection con = DB.getInstance().getConnection();
		String query="select i.id from isporuke i\r\n" + 
				"join voznje v on v.id=i.id_voznja\r\n" + 
				"join vozila vo on vo.reg_br=v.reg_br\r\n" + 
				"join kuriri k on k.username=v.username\r\n" + 
				"where i.status=2 and v.status=1 and k.username=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setString(1, usernameKurir);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ids.add(rs.getInt(1));
			}
			return ids;
		} catch (SQLException e) {
			Logger.getLogger(sa150288_DriveOperation.class.getName()).log(Level.SEVERE, null, e);
		}
		
		return null;
	}

	@Override
	public int nextStop(String courierUsername) {
		Connection con = DB.getInstance().getConnection();
		String query = "{ call nextStop (?,?) }";
		int res = 0;
		try(CallableStatement cs = con.prepareCall(query)){
			cs.setString(1, courierUsername);
			cs.registerOutParameter(2, java.sql.Types.INTEGER);
			cs.execute();
			res = cs.getInt(2);
			
		} catch (SQLException e) {
			  Logger.getLogger(sa150288_DriveOperation.class.getName()).log(Level.SEVERE, null, e);
	            
		}
		return res;
	}

	@Override
	public boolean planingDrive(String courierUsername) {
		Connection conn=DB.getInstance().getConnection();
        String query="{ call planiranjeRute (?,?) }";
        try (CallableStatement cs= conn.prepareCall(query)){
            cs.setString(1, courierUsername);
            cs.registerOutParameter(2, java.sql.Types.INTEGER);
            cs.execute();
            int res = cs.getInt(2);
            return res < 0 ? false : true;
        } catch (SQLException ex) {
            Logger.getLogger(sa150288_DriveOperation.class.getName()).log(Level.SEVERE, null, ex);
            
        }
        return false;
	}

}
