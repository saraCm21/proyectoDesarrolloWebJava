package controllers;

import java.io.IOException;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Entities.Usuario;
import models.Repositories.UsuarioRepository;
import models.Servicies.ChangePasswordService;
import utils.HashUtil;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {

    private final UsuarioRepository repository = new UsuarioRepository();
    private final ChangePasswordService service = new ChangePasswordService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String codeStr = request.getParameter("code");

        if (email == null || password == null || codeStr == null || email.isBlank() || password.isBlank() || codeStr.isBlank()) {
            response.sendRedirect("ChangePassword.jsp?error=missing_fields");
            return;
        }

        int code;
        try {
            code = Integer.parseInt(codeStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("ChangePassword.jsp?error=invalid_code_format");
            return;
        }
        
        System.out.println(code);

        Usuario usuario = repository.buscarPorUsernameOEmail(email);

        if (usuario == null) {
            response.sendRedirect("ChangePassword.jsp?error=email_not_found");
            return;
        }

        boolean changed = service.changePassword(code, password, email);

        if (changed) {
            response.sendRedirect("Login.jsp?success=password_changed");
        } else {
            response.sendRedirect("ChangePassword.jsp?error=invalid_code_or_expired");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("ChangePassword.jsp");
    }
}