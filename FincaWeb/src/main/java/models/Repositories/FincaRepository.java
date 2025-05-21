package models.Repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import libs.Connect;
import models.Entities.Finca;

public class FincaRepository {

	public boolean createFinca(Finca finca) {
	    Random random = new Random();
	    int number = 100000 + random.nextInt(900000);
	    String codigoFinca = String.valueOf(number);

	    String sqlGetUsuario = "SELECT id_usuario FROM usuarios WHERE codigo_usuario = ?";
	    String sqlInsertFinca = "INSERT INTO fincas (codigo_Finca, nombre, numHectareas, metrosCuadrados, propietario_id, capataz_id, vendedor_id, pais, departamento, ciudad, siProduceLeche, siProduceCereales, siProduceFrutas, siProduceVerduras) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    try (Connection conn = Connect.getInstance().getConexion();
	         PreparedStatement stmtPropietario = conn.prepareStatement(sqlGetUsuario);
	         PreparedStatement stmtCapataz = conn.prepareStatement(sqlGetUsuario);
	         PreparedStatement stmtVendedor = conn.prepareStatement(sqlGetUsuario);
	         PreparedStatement stmtInsert = conn.prepareStatement(sqlInsertFinca)) {

	        // Obtener propietarioId
	        stmtPropietario.setString(1, finca.getCodigo_propietario());
	        ResultSet rsPropietario = stmtPropietario.executeQuery();
	        int propietarioId = rsPropietario.next() ? rsPropietario.getInt("id_usuario") : -1;

	        // Obtener capatazId
	        stmtCapataz.setString(1, finca.getCodigo_capataz());
	        ResultSet rsCapataz = stmtCapataz.executeQuery();
	        int capatazId = rsCapataz.next() ? rsCapataz.getInt("id_usuario") : -1;

	        // Obtener vendedorId
	        stmtVendedor.setString(1, finca.getCodigo_vendedor());
	        ResultSet rsVendedor = stmtVendedor.executeQuery();
	        int vendedorId = rsVendedor.next() ? rsVendedor.getInt("id_usuario") : -1;

	        if (propietarioId == -1 || capatazId == -1 || vendedorId == -1) {
	            System.out.println("Error: No se encontró uno de los usuarios requeridos.");
	            return false;
	        }

	        // Insertar finca
	        stmtInsert.setString(1, codigoFinca);
	        stmtInsert.setString(2, finca.getNombre());
	        stmtInsert.setInt(3, finca.getNumHectareas());
	        stmtInsert.setFloat(4, finca.getMetrosCuadrados());
	        stmtInsert.setInt(5, propietarioId);
	        stmtInsert.setInt(6, capatazId);
	        stmtInsert.setInt(7, vendedorId);
	        stmtInsert.setString(8, finca.getPais());
	        stmtInsert.setString(9, finca.getDepartamento());
	        stmtInsert.setString(10, finca.getCiudad());
	        stmtInsert.setBoolean(11, finca.isSiProduceLeche());
	        stmtInsert.setBoolean(12, finca.isSiProduceCereales());
	        stmtInsert.setBoolean(13, finca.isSiProduceFrutas());
	        stmtInsert.setBoolean(14, finca.isSiProduceVerduras());

	        int filasAfectadas = stmtInsert.executeUpdate();
	        return filasAfectadas > 0;

	    } catch (SQLException e) {
	        System.out.println("Error al crear finca");
	        e.printStackTrace();
	        return false;
	    }
	}

	public boolean deleteFincaByCod(String codigo_Finca) {
	    String sql = "DELETE FROM fincas WHERE codigo_Finca = ?";

	    try (Connection conn = Connect.getInstance().getConexion();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        stmt.setString(1, codigo_Finca);
	        int filasAfectadas = stmt.executeUpdate();
	        
	        if (filasAfectadas > 0) {
	            System.out.println("Finca eliminada con éxito.");
	            return true;
	        } else {
	            System.out.println("❌ No se encontró ninguna finca con el código especificado.");
	            return false;
	        }

	    } catch (SQLException e) {
	        System.out.println("Error al eliminar la finca");
	        e.printStackTrace();
	        return false;
	    }
	}

	public boolean updateFinca(String codigoFinca, Map<String, Object> data) {
	    StringBuilder sql = new StringBuilder("UPDATE fincas SET ");
	    List<Object> valores = new ArrayList<>();

	    if (data.containsKey("nombre")) {
	        sql.append("nombre = ?, ");
	        valores.add(data.get("nombre"));
	    }
	    if (data.containsKey("propietario_id")) {
	        sql.append("propietarioId = ?, ");
	        valores.add(data.get("propietario_id"));
	    }
	    if (data.containsKey("capataz_id")) {
	        sql.append("capatazId = ?, ");
	        valores.add(data.get("capataz_id"));
	    }
	    if (data.containsKey("vendedor_id")) {
	        sql.append("vendedorId = ?, ");
	        valores.add(data.get("vendedor_id"));
	    }
	    if (data.containsKey("siProduceLeche")) {
	        sql.append("siProduceLeche = ?, ");
	        valores.add(data.get("siProduceLeche"));
	    }
	    if (data.containsKey("siProduceCereales")) {
	        sql.append("siProduceCereales = ?, ");
	        valores.add(data.get("siProduceCereales"));
	    }
	    if (data.containsKey("siProduceFrutas")) {
	        sql.append("siProduceFrutas = ?, ");
	        valores.add(data.get("siProduceFrutas"));
	    }
	    if (data.containsKey("siProduceVerduras")) {
	        sql.append("siProduceVerduras = ?, ");
	        valores.add(data.get("siProduceVerduras"));
	    }

	    if (valores.isEmpty()) {
	        System.out.println("No hay cambios para actualizar.");
	        return false;
	    }

	    sql.setLength(sql.length() - 2);
	    sql.append(" WHERE codigo_Finca = ?");
	    valores.add(codigoFinca);

	    try (Connection conn = Connect.getInstance().getConexion();
	         PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

	        for (int i = 0; i < valores.size(); i++) {
	            stmt.setObject(i + 1, valores.get(i));
	        }

	        int filasAfectadas = stmt.executeUpdate();
	        return filasAfectadas > 0;

	    } catch (SQLException e) {
	        System.out.println("Error al actualizar la finca.");
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public Finca findFincaByCod(String codigoFinca) {
	    String sqlFinca = "SELECT * FROM fincas WHERE codigo_finca = ?";
	    String sqlGetCodigoUsuario = "SELECT codigo_usuario FROM usuarios WHERE id_usuario = ?";

	    try (Connection conn = Connect.getInstance().getConexion();
	         PreparedStatement stmtFinca = conn.prepareStatement(sqlFinca);
	         PreparedStatement stmtUsuario = conn.prepareStatement(sqlGetCodigoUsuario)) {

	        stmtFinca.setString(1, codigoFinca);
	        ResultSet rsFinca = stmtFinca.executeQuery();

	        if (!rsFinca.next()) {
	            System.out.println("No se encontró ninguna finca con el código: " + codigoFinca);
	            return null;
	        }

	        int propietarioId = rsFinca.getInt("propietario_id");
	        int capatazId = rsFinca.getInt("capataz_id");
	        int vendedorId = rsFinca.getInt("vendedor_id");

	        stmtUsuario.setInt(1, propietarioId);
	        ResultSet rsPropietario = stmtUsuario.executeQuery();
	        String codigoPropietario = rsPropietario.next() ? rsPropietario.getString("codigo_usuario") : "Desconocido";

	        stmtUsuario.setInt(1, capatazId);
	        ResultSet rsCapataz = stmtUsuario.executeQuery();
	        String codigoCapataz = rsCapataz.next() ? rsCapataz.getString("codigo_usuario") : "Desconocido";

	        stmtUsuario.setInt(1, vendedorId);
	        ResultSet rsVendedor = stmtUsuario.executeQuery();
	        String codigoVendedor = rsVendedor.next() ? rsVendedor.getString("codigo_usuario") : "Desconocido";

	        return new Finca(
	            rsFinca.getString("codigo_finca"),
	            rsFinca.getString("nombre"),
	            rsFinca.getInt("numHectareas"),
	            rsFinca.getFloat("metrosCuadrados"),
	            codigoPropietario,
	            codigoCapataz,
	            codigoVendedor,
	            rsFinca.getString("pais"),
	            rsFinca.getString("departamento"),
	            rsFinca.getString("ciudad"),
	            rsFinca.getBoolean("siProduceLeche"),
	            rsFinca.getBoolean("siProduceCereales"),
	            rsFinca.getBoolean("siProduceFrutas"),
	            rsFinca.getBoolean("siProduceVerduras")
	        );

	    } catch (SQLException e) {
	        System.out.println("Error al buscar la finca.");
	        e.printStackTrace();
	        return null;
	    }
	}
	
	
}
