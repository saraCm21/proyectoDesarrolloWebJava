package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Entities.Usuario;
import models.Servicies.SignUpService;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String role = request.getParameter("role");

        // Verifica campos vacíos
        if (email == null || username == null || password == null || name == null || role == null ||
            email.isEmpty() || username.isEmpty() || password.isEmpty() || name.isEmpty() || role.isEmpty()) {
            response.sendRedirect("SignUp.jsp?error=empty_fields");
            return;
        }

        // Crea usuario
        Usuario usuario = new Usuario(username, password, name, email, role);


        // Servicio de registro
        SignUpService signUpService = new SignUpService();
        boolean registrado = signUpService.validateAndRegisterUser(usuario);

        if (registrado) {
            response.sendRedirect("Login.jsp");
        } else {
			response.sendRedirect("Login.jsp?error=login_failed");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect("SignUp.jsp");
    }
}