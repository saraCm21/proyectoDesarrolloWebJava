package controllers;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Entities.Usuario;
import models.Repositories.FincaRepository;
import models.Repositories.UsuarioRepository;

@WebServlet("/updateFinca")
public class UpDateFinca extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String codigoFinca = request.getParameter("codigo_finca");
        String nombre = request.getParameter("nombre");
        String codigoPropietario = request.getParameter("codigo_propietario");
        String codigoCapataz = request.getParameter("codigo_capataz");
        String codigoVendedor = request.getParameter("codigo_vendedor");

        String leche = request.getParameter("siProduceLeche");
        String cereales = request.getParameter("siProduceCereales");
        String frutas = request.getParameter("siProduceFrutas");
        String verduras = request.getParameter("siProduceVerduras");

        if (codigoFinca == null || codigoFinca.isEmpty()) {
            response.sendRedirect("Home.jsp?error=missing_id");
            return;
        }

        try {
            UsuarioRepository usuarioRepo = new UsuarioRepository();

            Usuario propietario = usuarioRepo.findUserByCode(codigoPropietario);
            Usuario capataz = usuarioRepo.findUserByCode(codigoCapataz);
            Usuario vendedor = usuarioRepo.findUserByCode(codigoVendedor);

            if (propietario == null || capataz == null || vendedor == null) {
                response.sendRedirect("Home.jsp?error=user_not_found");
                return;
            }
            
            
            int propietarioId = propietario.getIdUsuario();
            int capatazId = capataz.getIdUsuario();
            int vendedorId = vendedor.getIdUsuario();
            boolean siProduceLeche = Boolean.parseBoolean(leche);
            boolean siProduceCereales = Boolean.parseBoolean(cereales);
            boolean siProduceFrutas = Boolean.parseBoolean(frutas);
            boolean siProduceVerduras = Boolean.parseBoolean(verduras);

            Map<String, Object> data = new HashMap<>();
            data.put("nombre", nombre);
//            data.put("propietario_id", propietario.getIdUsuario());
//            data.put("capataz_id", capatazId);
//            data.put("vendedor_id", vendedorId);
            data.put("siProduceLeche", siProduceLeche);
            data.put("siProduceCereales", siProduceCereales);
            data.put("siProduceFrutas", siProduceFrutas);
            data.put("siProduceVerduras", siProduceVerduras);

            FincaRepository fincaRepo = new FincaRepository();
            boolean updated = fincaRepo.updateFinca(codigoFinca, data);

            if (updated) {
                response.sendRedirect("Home.jsp?success");
            } else {
                response.sendRedirect("Home.jsp?error=update_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Home.jsp?error=" + URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}