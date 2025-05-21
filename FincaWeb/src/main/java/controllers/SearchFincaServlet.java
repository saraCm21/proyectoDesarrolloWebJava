package controllers;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Entities.Finca;
import models.Repositories.FincaRepository;

@WebServlet("/SearchFincaServlet")
public class SearchFincaServlet extends HttpServlet {

    FincaRepository repository = new FincaRepository();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String codigo = request.getParameter("search_input");
        Finca finca = repository.findFincaByCod(codigo);

        if (finca == null) {
            response.sendRedirect("Home.jsp?error=Finca_not_found");
            return;
        }

        String queryParams = String.format(
        	    "codigo_finca=%s&nombre=%s&pais=%s&departamento=%s&ciudad=%s&metros=%s&hectareas=%s" +
        	    "&leche=%s&cereales=%s&frutas=%s&verduras=%s" +
        	    "&codigo_propietario=%s&codigo_vendedor=%s&codigo_capataz=%s",
        	    URLEncoder.encode(finca.getCodigoFinca(), "UTF-8"),
        	    URLEncoder.encode(finca.getNombre(), "UTF-8"),
        	    URLEncoder.encode(finca.getPais(), "UTF-8"),
        	    URLEncoder.encode(finca.getDepartamento(), "UTF-8"),
        	    URLEncoder.encode(finca.getCiudad(), "UTF-8"),
        	    URLEncoder.encode(String.valueOf(finca.getMetrosCuadrados()), "UTF-8"),
        	    URLEncoder.encode(String.valueOf(finca.getNumHectareas()), "UTF-8"),
        	    URLEncoder.encode(String.valueOf(finca.isSiProduceLeche()), "UTF-8"),
        	    URLEncoder.encode(String.valueOf(finca.isSiProduceCereales()), "UTF-8"),
        	    URLEncoder.encode(String.valueOf(finca.isSiProduceFrutas()), "UTF-8"),
        	    URLEncoder.encode(String.valueOf(finca.isSiProduceVerduras()), "UTF-8"),
        	    URLEncoder.encode(finca.getCodigo_propietario(), "UTF-8"),
        	    URLEncoder.encode(finca.getCodigo_vendedor(), "UTF-8"),
        	    URLEncoder.encode(finca.getCodigo_capataz(), "UTF-8")
        	);
        response.sendRedirect("Home.jsp?" + queryParams);
    }
}
