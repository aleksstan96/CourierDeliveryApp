package rs.etf.sab.student;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.PackageOperations;
import rs.etf.sab.student.connection.DB;

public class sa150288_PackageOperations implements PackageOperations {

	public int statusPorudzbine(int idPor) {
		int status = -1;
		Connection con = DB.getInstance().getConnection();
		String query = "select status from isporuke where id=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setInt(1, idPor);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) return rs.getInt(1);
			
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);

		}
		return status;
	}
	
	public int uTransportu(int idPor) {
		int status = -1;
		Connection con = DB.getInstance().getConnection();
		String query = "select u_transportu from isporuke where id=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setInt(1, idPor);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) return rs.getInt(1);
			
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);

		}
		return status;
	}
	
	
	@Override
	public boolean acceptAnOffer(int id) {
		int status = this.statusPorudzbine(id);
		if(status!=0) return false;
		int updated=0;
		Connection con = DB.getInstance().getConnection();
		String query="update isporuke set status=?, vreme_prihvatanja=? where status=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setInt(1, 1);
			java.util.Date datum = new java.util.Date();
			Object param = new java.sql.Timestamp(datum.getTime());
			ps.setObject(2, param);
			ps.setInt(3, 0);
			updated  = ps.executeUpdate();
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
			return false;
		}
		if(updated>0) return true;
		return false;
	}

	@Override
	public boolean changeType(int paketId, int tip) {
		int status = this.statusPorudzbine(paketId);
		if(status!=0) return false;
		int idZahtev=0;
		Connection con = DB.getInstance().getConnection();
		String query= "select z.id from zahtevi_isporuka z join isporuke i on z.id=i.id_zahtev where i.id=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setInt(1, paketId);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) idZahtev = rs.getInt(1);
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
			return false;
		}
		
		int updated = 0;
		query="update zahtevi_isporuka set tip=? where id=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setInt(1, tip);
			ps.setInt(2, idZahtev);
			updated = ps.executeUpdate();
			
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
			return false;
		}
		if(updated>0)return true;
		return false;
	}

	@Override
	public boolean changeWeight(int paketId, BigDecimal tezina) {
		int status = this.statusPorudzbine(paketId);
		if(status!=0) return false;
		int idZahtev=0;
		Connection con = DB.getInstance().getConnection();
		String query= "select z.id from zahtevi_isporuka z join isporuke i on z.id=i.id_zahtev where i.id=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setInt(1, paketId);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) idZahtev = rs.getInt(1);
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
			return false;
		}
		
		int updated = 0;
		query="update zahtevi_isporuka set tezina=? where id=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setBigDecimal(1, tezina);
			ps.setInt(2, idZahtev);
			updated = ps.executeUpdate();
			
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
			return false;
		}
		if(updated>0)return true;
		return false;
	}

	@Override
	public boolean deletePackage(int id) {
		int status = this.statusPorudzbine(id);
		if(status!=0 && status!=4) return false;
		int deleted = 0;
		Connection con = DB.getInstance().getConnection();
		String query="delete from isporuke where id=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setInt(1, id);
			deleted = ps.executeUpdate();
			
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
					
		}
		
		if(deleted>0) return true;
		return false;
	}

	@Override
	public Date getAcceptanceTime(int id) {
		//KONVERZIJE CE MOZDA BITI PROBLEM
		Connection con = DB.getInstance().getConnection();
		String query="select vreme_prihvatanja from isporuke where id=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) return rs.getDate(1);
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
			
		}
		return null;
	}

	@Override
	public List<Integer> getAllPackages() {
		List<Integer> lista = new ArrayList<Integer>();
		Connection con = DB.getInstance().getConnection();
		String query="select id from isporuke";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				lista.add(rs.getInt(1));
			}
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
			
		}
		return lista;
	}

	@Override
	public List<Integer> getAllPackagesCurrentlyAtCity(int cityId) {
		List<Integer> ids = new ArrayList<Integer>();
		
		Connection con = DB.getInstance().getConnection();
		String query = "select i.id from isporuke i\r\n" + 
				"join adrese a on i.id_curr_adresa=a.id\r\n" + 
				"join gradovi g on g.id=a.id_grad\r\n" + 
				"where i.u_transportu<>1 and id_grad=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setInt(1, cityId);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ids.add(rs.getInt(1));
			}
			return ids;
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
		}
		
		return null;
	}

	@Override
	public List<Integer> getAllPackagesWithSpecificType(int tipPaketa) {
		
		List<Integer> lista = new ArrayList<Integer>();
		if(tipPaketa!= 0 && tipPaketa!= 1 && tipPaketa!= 2 && tipPaketa!= 3 )return lista;
		Connection con = DB.getInstance().getConnection();
		String query="select id from isporuke where tip=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setInt(1, tipPaketa);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				lista.add(rs.getInt(1));
			}
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
			
		}
		return lista;
	}

	@Override
	public List<Integer> getAllUndeliveredPackages() {
		 List<Integer> lista = new ArrayList<Integer>();
		 Connection con = DB.getInstance().getConnection();
		 String query="select id from isporuke where status=? or status=?";
		 try(PreparedStatement ps =con.prepareStatement(query)){
			 ps.setInt(1, 1);
			 ps.setInt(2, 2);
			 ResultSet rs = ps.executeQuery();
			 while(rs.next()) {
				 lista.add(rs.getInt(1));
			 }
		 } catch (SQLException e) {
			 Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
				
		}
		 
		return lista;
	}

	@Override
	public List<Integer> getAllUndeliveredPackagesFromCity(int gradId) {
		List<Integer> lista = new ArrayList<Integer>();
		 Connection con = DB.getInstance().getConnection();
		 String query="  select i.id from isporuke i \r\n" + 
		 		"  join adrese a on i.id_adresa_p=a.id\r\n" + 
		 		"  join gradovi g on a.id_grad=g.id\r\n" + 
		 		"   where (i.status=? or i.status=?) and g.id =?";
		 try(PreparedStatement ps =con.prepareStatement(query)){
			 ps.setInt(1, 1);
			 ps.setInt(2, 2);
			 ps.setInt(3, gradId);
			 ResultSet rs = ps.executeQuery();
			 while(rs.next()) {
				 lista.add(rs.getInt(1));
			 }
		 } catch (SQLException e) {
			 Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
				
		}
		 
		return lista;
	}

	@Override
	public int getCurrentLocationOfPackage(int packageId) {
		int status = uTransportu(packageId);
		if(status==1) return -1;
		Connection con = DB.getInstance().getConnection();
		String query= "select g.id from gradovi g\r\n" + 
				"join adrese a on a.id_grad=g.id\r\n" + 
				"join isporuke i on a.id=i.id_curr_adresa\r\n" + 
				"where i.id=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setInt(1, packageId);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
			
		} catch (SQLException e) {
			 Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
			return -1;
		}
		
		return -1;
	}

	@Override
	public int getDeliveryStatus(int arg0) {
		return this.statusPorudzbine(arg0);
	}

	@Override
	public BigDecimal getPriceOfDelivery(int arg0) {
		BigDecimal price = new BigDecimal(0);
		Connection con = DB.getInstance().getConnection();
		String query="select cena from isporuke where id=?";
		try(PreparedStatement ps=con.prepareStatement(query)){
			ps.setInt(1, arg0);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) price = rs.getBigDecimal(1);
		} catch (SQLException e) {
			 Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
			return new BigDecimal(-1);	
		}
		
		return price;
	}

	@Override
	public int insertPackage(int adressFrom, int adressTo, String username, int tipPaketa, BigDecimal tezina) {
		
		if(tipPaketa!= 0 && tipPaketa!= 1 && tipPaketa!= 2 && tipPaketa!= 3 ) return -1;
		int zahtevId = 0;
		Connection con = DB.getInstance().getConnection();
		String query="insert into zahtevi_isporuka (id_adresa_p, id_adresa_k, username, tip_paketa, tezina) values (?,?,?,?,?)";
		try(PreparedStatement ps = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS )){
			ps.setInt(1, adressFrom);
			ps.setInt(2, adressTo);
			ps.setString(3, username);
			ps.setInt(4, tipPaketa);
			ps.setBigDecimal(5, tezina);
			ps.executeUpdate();
			ResultSet rs= ps.getGeneratedKeys();
			if(rs.next()) {
				zahtevId= rs.getInt(1);
			}else return -1;
                
		} catch (SQLException e) {
			 Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
			 return -1;
		}
		
		query = "select id from isporuke where id_zahtev=?";
		try(PreparedStatement ps=con.prepareStatement(query)){
			ps.setInt(1, zahtevId);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) return rs.getInt(1);
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
			 return -1;
		}
		
		return -1;
	}

	@Override
	public boolean rejectAnOffer(int id) {
		int status = this.statusPorudzbine(id);
		if(status!=0) return false;
		int updated=0;
		Connection con = DB.getInstance().getConnection();
		String query="update isporuke set status=?, vreme_prihvatanja=?";
		try(PreparedStatement ps = con.prepareStatement(query)){
			ps.setInt(1, 4);
			java.util.Date datum = new java.util.Date();
			Object param = new java.sql.Timestamp(datum.getTime());
			ps.setObject(2, param);
			updated  = ps.executeUpdate();
		} catch (SQLException e) {
			Logger.getLogger(sa150288_PackageOperations.class.getName()).log(Level.SEVERE, null, e);
			return false;
		}
		if(updated>0) return true;
		return false;
	}



}
