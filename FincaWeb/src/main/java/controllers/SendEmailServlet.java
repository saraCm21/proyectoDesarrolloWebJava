package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Entities.Usuario;
import models.Repositories.UsuarioRepository;
import models.Servicies.SendEmailService;

@WebServlet("/sendEmail")
public class SendEmailServlet extends HttpServlet {
	
	UsuarioRepository repository = new UsuarioRepository();
	SendEmailService emailService = new SendEmailService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");

        if (email == null || email.isEmpty()) {
            response.sendRedirect("Login.jsp?error=email_required");
            return;
        }

        Usuario usuario = repository.buscarPorUsernameOEmail(email);
        if (usuario == null) {
            response.sendRedirect("Login.jsp?error=email_required");
            return;
        }

        boolean enviado = emailService.sendEmail(email);

        if (enviado) {
            response.sendRedirect("ChangePassword.jsp??success=email_sent");
        } else {
            response.sendRedirect("Login.jsp??error=email_failed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect("Login.jsp?");
    }
}