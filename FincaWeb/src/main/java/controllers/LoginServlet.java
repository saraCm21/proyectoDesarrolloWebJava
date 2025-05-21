package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.HashUtil;

import models.Servicies.LoginService;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final LoginService loginService = new LoginService();
    
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try {
            Class.forName("org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder");
            System.out.println("BCryptPasswordEncoder está disponible");
        } catch (ClassNotFoundException e) {
            System.out.println("Clase NO encontrada");
        }

        boolean esValido = loginService.login(username, password);

        if (esValido) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("Home.jsp");
        } else {
            response.sendRedirect("Login.jsp?error=login_failed");
        }
    }
    
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("Login.jsp");
    }
    
    
}

