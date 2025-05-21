package models.Servicies;

import models.Entities.Usuario;
import models.Repositories.UsuarioRepository;
import utils.HashUtil;

public class LoginService {

    public boolean login(String usernameOrEmail, String password) {
        UsuarioRepository repo = new UsuarioRepository();
        Usuario usuario = repo.buscarPorUsernameOEmail(usernameOrEmail);

        if (usuario != null && HashUtil.verificarPassword(password, usuario.getPassword())) {
            return true;
        }

        return false;
    }
}  