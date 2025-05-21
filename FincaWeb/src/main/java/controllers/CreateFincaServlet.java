package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Entities.Finca;
import models.Servicies.CreateFincaService;

@WebServlet("/registerFinca")
public class CreateFincaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        String nombre = request.getParameter("nombre");
        String numHectareasStr = request.getParameter("numHectaras");
        String metrosCuadradosStr = request.getParameter("metrosCuadrados");
        String codigoPropietario = request.getParameter("codigo_propietario");
        String codigoCapataz = request.getParameter("codigo_capataz");
        String codigoVendedor = request.getParameter("codigo_vendedor");
        String pais = request.getParameter("pais");
        String departamento = request.getParameter("departamento");
        String ciudad = request.getParameter("ciudad");
        
        System.out.println(numHectareasStr);

        boolean siProduceLeche = "1".equals(request.getParameter("siProduceLeche"));
        boolean siProduceCereales = "1".equals(request.getParameter("siProduceCereales"));
        boolean siProduceFrutas = "1".equals(request.getParameter("siProduceFrutas"));
        boolean siProduceVerduras = "1".equals(request.getParameter("siProduceVerduras"));

       
        if (nombre == null || nombre.isEmpty() || pais == null || pais.isEmpty() ||
            departamento == null || departamento.isEmpty() || ciudad == null || ciudad.isEmpty()) {
            response.sendRedirect("RegisterFinca.jsp?error=empty_fields");
            return;
        }
        
        Float numHectareas;
        Float metrosCuadrados;
        try {
            numHectareas = Float.parseFloat(numHectareasStr);
            metrosCuadrados = Float.parseFloat(metrosCuadradosStr);
        } catch (NumberFormatException e) {
        	System.out.println("no se puedo hacer el cambio de dato");
        	response.sendRedirect("RegisterFinca.jsp?error=change_type_number");
        	return;
        }

        // Crear objeto finca
        Finca finca = new Finca(nombre, numHectareas, metrosCuadrados, codigoPropietario, codigoCapataz, codigoVendedor, pais, departamento, ciudad, siProduceLeche, siProduceCereales, siProduceFrutas, siProduceVerduras);

        CreateFincaService createFincaService = new CreateFincaService();
        boolean created = createFincaService.create(finca);

        if (created) {
            response.sendRedirect("RegisterFinca.jsp?success");
        } else {
            response.sendRedirect("RegisterFinca.jsp?error=error_crear_finca");
        }
    }
}
