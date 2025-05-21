package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Entities.Finca;
import models.Repositories.FincaRepository;

@WebServlet("/DeleteFincaServlet")
public class DeleteFincaServlet extends HttpServlet{
	

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { 
		
		
		String codigo = request.getParameter("codigo_finca");
		
		boolean eliminado = FincaRepository.deleteFincaByCod(codigo);
		
		if (eliminado) {
			response.sendRedirect("Home.jsp?delete_finca");
		}else {
			response.sendRedirect("Home.jsp?Error_delete_finca");
		}
		
		
	}
	
	
}
