package models.Servicies;

import models.Entities.Usuario;
import models.Repositories.UsuarioRepository;

public class SignUpService {
	 private final UsuarioRepository usuarioRepository;

	    public SignUpService() {
	        this.usuarioRepository = new UsuarioRepository();
	    }

	    public boolean validateAndRegisterUser(Usuario user) {
	    	
	        if (user.getUsername() == null || user.getUsername().isEmpty() || user.getUsername().length() > 15) {
	            System.out.println("Username inválido");
	            return false;
	        }
	        if (user.getPassword() == null || user.getPassword().length() < 8) {
	            System.out.println("La contraseña debe tener al menos 8 caracteres");
	            return false;
	        }

/*	        if (usuarioRepository.existePorUsername(user.getUsername())) {
	            System.out.println("El username ya existe");
	            return false;
	        }
	        if (usuarioRepository.existePorEmail(user.getEmail())) {
	            System.out.println("El email ya existe");
	            return false;
	        }
*/
	        return usuarioRepository.createUser(user);
	    }
}
