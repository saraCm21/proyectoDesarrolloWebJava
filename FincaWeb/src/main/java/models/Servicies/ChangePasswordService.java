package models.Servicies;

import java.time.LocalDateTime;

import models.Entities.Usuario;
import models.Repositories.UsuarioRepository;
import utils.HashUtil;

public class ChangePasswordService {

	UsuarioRepository repository = new UsuarioRepository();
	HashUtil hashUtil = new HashUtil();
	
    public boolean changePassword(int code, String password, String email) {
        Usuario usuario = repository.buscarPorUsernameOEmail(email);

        if (usuario == null) {
            return false;
        }

        String codeS = String.valueOf(code);
        String codigo = String.valueOf(usuario.getCodRecuperacion());
        boolean sip = LocalDateTime.now().isBefore(usuario.getTimeLimit());
        System.out.println(sip);
        
        
       if (codeS.trim().equals(codigo)){
        	if (LocalDateTime.now().isBefore(usuario.getTimeLimit())) {
        		System.out.println("siii");
                usuario.setPassword(password);
                repository.updateUser(usuario.getCodigoUsuario(), usuario.getUsername(), usuario.getNombre(), usuario.getEmail(), usuario.getPassword());
                System.out.println("true");
                return true;
        	}
        }
       System.out.println("false");
        return false;
        
    }
}