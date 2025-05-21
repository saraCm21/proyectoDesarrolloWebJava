package models.Entities;

import java.time.LocalDateTime;
import java.util.Random;

public class Usuario {

	    private int idUsuario;
	    private String codigoUsuario;
	    private String username;
	    private String password;
	    private String nombre;
	    private String email;
	    private String rol;
	    private int codRecuperacion = 0;
	    private LocalDateTime  timeLimit = null;

	    public Usuario() {}
	    
	    // CONSTRUCTOR PARA EXTREAR Y MANEJAR UN USUARIO
	    public Usuario(int idUsuario, String codigoUsuario, String username, String password, String nombre, String email, String rol) {
		     this.idUsuario = idUsuario;
		     this.codigoUsuario = codigoUsuario;
		     this.username = username;
		     this.password = password;
		     this.nombre = nombre;
		     this.email = email;
		     this.rol = rol;
		 }


	    // CONSTRUCTOR PARA CREAR UN NUEVO USUARIO
	    public Usuario(String username, String password,
	                   String nombre, String email, String rol) {
	    	Random random = new Random();
	    	int number = 100000 + random.nextInt(900000);
	        this.codigoUsuario = String.valueOf(number);
	        this.username = username;
	        this.password = password;
	        this.nombre = nombre;
	        this.email = email;
	        this.rol = rol;
	    }

	    public int getIdUsuario() {
	        return idUsuario;
	    }

	    public String getCodigoUsuario() {
	        return codigoUsuario;
	    }

	    public String getUsername() {
	        return username;
	    }

	    public void setUsername(String username) {
	        this.username = username;
	    }

	    public String getPassword() {
	        return password;
	    }

	    public void setPassword(String password) {
	        this.password = password;
	    }

	    public String getNombre() {
	        return nombre;
	    }

	    public void setNombre(String nombre) {
	        this.nombre = nombre;
	    }

	    public String getEmail() {
	        return email;
	    }

	    public void setEmail(String email) {
	        this.email = email;
	    }

	    public String getRol() {
	        return rol;
	    }

	    public void setRol(String rol) {
	        this.rol = rol;
	    }

	    public int generateCodRecuperacion() {
	    	Random random = new Random();
	    	int codigo = 100000 + random.nextInt(900000);
	    	return codigo;
	    }
	    
	    public int getCodRecuperacion() {
	        return codRecuperacion;
	    }

	    public void setCodRecuperacion(int codRecuperacion) {
	        this.codRecuperacion = codRecuperacion;
	    }

	    public LocalDateTime generateTimeLimit() {
	    	return LocalDateTime.now().plusMinutes(15);
	    }
	    
	    public LocalDateTime getTimeLimit() {
	        return timeLimit;
	    }

	    public void setTimeLimit(LocalDateTime timeLimit) {
	        this.timeLimit = timeLimit;
	    }

	    @Override
	    public String toString() {
	        return "Usuario{" +
	                "idUsuario=" + idUsuario +
	                ", codigoUsuario='" + codigoUsuario + '\'' +
	                ", username='" + username + '\'' +
	                ", nombre='" + nombre + '\'' +
	                ", email='" + email + '\'' +
	                ", rol='" + rol + "}";
	    }
}

