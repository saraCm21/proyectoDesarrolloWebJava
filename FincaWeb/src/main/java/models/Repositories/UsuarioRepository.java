package models.Repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import libs.Connect;
import models.Entities.Usuario;
import utils.HashUtil;

public class UsuarioRepository {

	public static boolean createUser(Usuario user){
		
	user.setPassword(HashUtil.hashPassword(user.getPassword()));
	    String sql = "INSERT INTO usuarios (codigo_usuario, username, password, nombre, email, rol) " + "VALUES (?, ?, ?, ?, ?, ?)";
		   try {
		       Connection conn = Connect.getInstance().getConexion();
		       PreparedStatement stmt = conn.prepareStatement(sql);
		       stmt.setString(1, user.getCodigoUsuario());
		       stmt.setString(2, user.getUsername());
		       stmt.setString(3, user.getPassword());
		       stmt.setString(4, user.getNombre());
		       stmt.setString(5, user.getEmail());
		       stmt.setString(6, user.getRol());
		       stmt.executeUpdate();
		       return true;
		   } catch (SQLException e) {
		       e.printStackTrace();
		       return false;
		   }
	}	
	
	public boolean deleteUserCod(int codigo_usuario) {
	    String sql = "DELETE FROM usuarios WHERE codigo_usuario = ?";
	    
	    try (Connection conn = Connect.getInstance().getConexion();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        
	        stmt.setInt(1, codigo_usuario);
	        int filasAfectadas = stmt.executeUpdate();
	        
	        return filasAfectadas > 0;
	        
	    }	catch (SQLIntegrityConstraintViolationException e) {
	        System.out.println("Error: No se puede eliminar el usuario porque está relacionado con una Finca registrada en el sistema."); // RECORDAR PONER LA ALERTA DE ERROR POR ESTO
	        e.printStackTrace();
	        return false;
	    } catch (SQLException e) {
	        System.out.println("Error general al eliminar usuario.");
	        e.printStackTrace();
	        return false;
	    }
 
	}

	public boolean deleteUserUsername(String username) {
	    String sql = "DELETE FROM usuarios WHERE username = ?";
	    
	    try (Connection conn = Connect.getInstance().getConexion();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        
	        stmt.setString(1, username);
	        int filasAfectadas = stmt.executeUpdate();
	        
	        return filasAfectadas > 0;
	        
	    }	catch (SQLIntegrityConstraintViolationException e) {
	        System.out.println("Error: No se puede eliminar el usuario porque está relacionado con una Finca registrada en el sistema."); // RECORDAR PONER LA ALERTA DE ERROR POR ESTO
	        e.printStackTrace();
	        return false;
	    } catch (SQLException e) {
	        System.out.println("Error general al eliminar usuario.");
	        e.printStackTrace();
	        return false;
	    }
 
	}
	
	public void updateUser(String codigo_usuario, String username, String nombre, String email, String password) {
	    String sql = "UPDATE usuarios SET username = ?, nombre = ?, email = ?, password = ? WHERE codigo_usuario = ?";
	    password = HashUtil.hashPassword(password);
	    try (Connection conn = Connect.getInstance().getConexion();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        
	        stmt.setString(1, username);
	        stmt.setString(2, nombre);
	        stmt.setString(3, email);
	        stmt.setString(4, password);
	        stmt.setString(5, codigo_usuario);
	        
	        int filasAfectadas = stmt.executeUpdate();
	        
	        if (filasAfectadas > 0) {
	        	System.out.println("Cambios hechos");
	        } else {
	            System.out.println("No se encontró el usuario o no se realizaron cambios.");
	        }
	        
	    } catch (SQLException e) {
	        System.out.println("Error al actualizar usuario");
	        e.printStackTrace();
	    }
	}

	public Usuario findUserByCode(String codigo_usuario) {
	    String sql = "SELECT * FROM usuarios WHERE codigo_usuario = ?";
	    
	    try (Connection conn = Connect.getInstance().getConexion();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        
	        stmt.setString(1, codigo_usuario);
	        ResultSet rs = stmt.executeQuery();

	        if (rs.next()) {
	            return new Usuario(
	            	rs.getInt("id_usuario"),
	                rs.getString("codigo_usuario"),
	                rs.getString("username"),
	                rs.getString("password"),
	                rs.getString("nombre"),
	                rs.getString("email"),
	                rs.getString("rol")
	            );
	            
		        
	        } else {
	            System.out.println("Usuario no encontrado");
	            return null;
	        }
	        
	    } catch (SQLException e) {
	        System.out.println("Error al buscar usuario");
	        e.printStackTrace();
	        return null;
	    }
	}
	
	public static Usuario buscarPorUsernameOEmail(String usernameOrEmail) {
	    String sql = "SELECT * FROM usuarios WHERE username = ? OR email = ? LIMIT 1";

	    try (Connection conn = Connect.getInstance().getConexion();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        stmt.setString(1, usernameOrEmail);
	        stmt.setString(2, usernameOrEmail);

	        ResultSet rs = stmt.executeQuery();

	        if (rs.next()) {
	            return new Usuario(
	                rs.getInt("id_usuario"),
	                rs.getString("codigo_usuario"),
	                rs.getString("username"),
	                rs.getString("password"),
	                rs.getString("nombre"),
	                rs.getString("email"),
	                rs.getString("rol")
	            );
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return null;
	}

	public boolean existePorUsername(String username) {
	    String sql = "SELECT 1 FROM usuarios WHERE username = ?";
	    try (Connection conn = Connect.getInstance().getConexion();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setString(1, username);
	        ResultSet rs = stmt.executeQuery();
	        return rs.next();
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	public boolean existePorEmail(String email) {
	    String sql = "SELECT 1 FROM usuarios WHERE email = ?";
	    try (Connection conn = Connect.getInstance().getConexion();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setString(1, email);
	        ResultSet rs = stmt.executeQuery();
	        return rs.next();
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

}























