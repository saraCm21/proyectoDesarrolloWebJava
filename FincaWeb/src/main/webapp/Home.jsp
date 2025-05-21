<%@page import="libs.Connect"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Fincas</title>
   <style>
        * {
          box-sizing: border-box;
          margin: 0;
          padding: 0;
          font-family: 'Segoe UI', sans-serif;
        }
        body {
          display: flex;
          height: 100vh;
          background-color: #f0f2f5;
        }
        .container {
          display: flex;
          width: 100%;
        }
        .sidebar {
          width: 200px;
          background-color: #2196f3;
          color: white;
          padding: 20px;
        }
        .sidebar h2 {
          margin-bottom: 30px;
          font-size: 20px;
        }
        .sidebar nav a {
          display: block;
          margin-bottom: 20px;
          color: white;
          text-decoration: none;
          font-size: 14px;
        }
        .sidebar nav a:hover {
          text-decoration: underline;
        }
        .main {
          flex: 1;
          background-color: #0b0d1b;
          padding: 20px;
          display: flex;
          flex-direction: column;
          justify-content: space-between;
        }
        .top-bar {
          display: flex;
          justify-content: flex-end;
          padding: 20px;
        }
        .search-form {
          display: flex;
          align-items: center;
          gap: 10px;
        }
        .search-input {
          padding: 8px 12px;
          border: 1px solid #ccc;
          border-radius: 12px;
          width: 250px;
          font-size: 16px;
          height: 40px;
        }
        .search-button {
          height: 40px;
          border: none;
          background-color: transparent;
          color: #333;
          font-size: 18px;
          border-radius: 12px;
          cursor: pointer;
        }
        .table-container {
          background-color: white;
          border-radius: 15px 15px 0 0;
          overflow: hidden;
          flex-grow: 1;
          padding: 10px;
        }
        table {
          width: 100%;
          border-collapse: collapse;
        }
        th, td {
          padding: 12px;
          text-align: left;
          border-bottom: 1px solid #ccc;
        }
        .gear-icon {
          font-size: 18px;
        }
        .filters {
          display: flex;
          align-items: center;
          justify-content: space-evenly;
          background-color: white;
          padding: 10px 20px;
          border-radius: 0 0 15px 15px;
          gap: 10px;
          margin-top: 10px;
        }
        .filters span {
          font-size: 14px;
        }
        .input-group {
          display: flex;
          align-items: center;
          gap: 5px;
        }
        .input-group input {
          padding: 6px;
          border-radius: 5px;
          border: 1px solid #aaa;
        }
        .input-group button {
          padding: 6px 10px;
          background-color: #eee;
          border: none;
          cursor: pointer;
          border-radius: 5px;
        }
        .modal {
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background-color: rgba(0, 0, 0, 0.5);
          display: flex;
          justify-content: center;
          align-items: center;
        }
        .modal-content {
          background-color: #fff;
          padding: 20px;
          border-radius: 5px;
          width: 400px;
          position: relative;
        }
        .close-btn {
          position: absolute;
          top: 10px;
          right: 10px;
          cursor: pointer;
          font-size: 20px;
        }
        label {
          display: block;
          margin-bottom: 5px;
        }
        input {
          margin-bottom: 15px;
          width: 100%;
        }
		/* Fondo oscuro semitransparente */
		#fondoModal {
		  display: none;
		  position: fixed;
		  top: 0; left: 0;
		  width: 100vw;
		  height: 100vh;
		  background-color: rgba(0,0,0,0.6);
		  z-index: 999;
		}
		
		/* Modal centrado */
		#modalEditar {
		  display: none;
		  position: fixed;
		  top: 50%;
		  left: 50%;
		  transform: translate(-50%, -50%);
		  background: #fff;
		  padding: 25px 30px;
		  border-radius: 12px;
		  box-shadow: 0 12px 25px rgba(0,0,0,0.3);
		  width: 400px;
		  max-height: 90vh;
		  overflow-y: auto;
		  z-index: 1000;
		  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		}
		
		/* Título */
		#modalEditar h3 {
		  margin-top: 0;
		  margin-bottom: 20px;
		  font-weight: 700;
		  font-size: 1.5em;
		  color: #333;
		  text-align: center;
		}
		
		/* Formulario y etiquetas */
		#formEditar .form-group {
		  display: flex;
		  align-items: center;
		  margin-bottom: 12px;
		}
		
		#formEditar label {
		  flex: 0 0 40%; /* la etiqueta ocupa 40% del ancho */
		  margin-bottom: 0;
		  font-weight: 600;
		  color: #555;
		  font-size: 0.9em;
		  align-self: center;
		}
		
		#formEditar input[type="text"],
		#formEditar input[type="number"] {
		  flex: 1; /* ocupa el resto del espacio */
		  padding: 6px 10px;
		  font-size: 0.9em;
		  border: 1.8px solid #ccc;
		  border-radius: 6px;
		  margin-left: 12px; /* espacio entre etiqueta e input */
		  transition: border-color 0.3s ease;
		}
		
		#formEditar input[type="text"]:focus,
		#formEditar input[type="number"]:focus {
		  outline: none;
		  border-color: #4a90e2;
		  box-shadow: 0 0 8px rgba(74,144,226,0.4);
		  background-color: #f0f8ff;
		}
		
		#formEditar input[readonly] {
		  background-color: #f5f5f5;
		  color: #999;
		  cursor: not-allowed;
		}
		
		/* Botones */
		#formEditar button {
		  padding: 10px 18px;
		  font-size: 1em;
		  font-weight: 600;
		  border-radius: 6px;
		  border: none;
		  cursor: pointer;
		  transition: background-color 0.25s ease, box-shadow 0.25s ease;
		}
		
		#formEditar button[type="submit"] {
		  background-color: #4a90e2;
		  color: white;
		  box-shadow: 0 6px 12px rgba(74,144,226,0.4);
		}
		
		#formEditar button[type="submit"]:hover {
		  background-color: #357ABD;
		  box-shadow: 0 8px 16px rgba(53,122,189,0.6);
		}
		
		#cerrarModal {
		  background-color: #ccc;
		  margin-left: 10px;
		  color: #444;
		  box-shadow: 0 4px 8px rgba(204,204,204,0.6);
		}
		
		#cerrarModal:hover {
		  background-color: #b3b3b3;
		  box-shadow: 0 6px 12px rgba(179,179,179,0.7);
		}
		#formEditar select {
		  flex: 1;
		  padding: 6px 8px;
		  font-size: 0.9em;
		  border: 1px solid #ccc;
		  border-radius: 6px;
		  margin-left: 8px;
		  background-color: #f9f9f9;
		}
		  .info-row {
	    margin-bottom: 10px;
	    font-size: 0.95em;
	    display: flex;
	    justify-content: space-between;
	    border-bottom: 1px solid #eee;
	    padding-bottom: 4px;
	  }
    </style>
</head>
<body>
  <div class="container">
    <aside class="sidebar">
      <h2>MENU</h2>
      <nav>
        <a href="registerFinca.jsp">&#x2696; Crear Finca</a>
        <a href="../../Views/principalFrames/reportFinca.jsp">📄 Reporte</a>
        <a href="../../Controllers/logoutController.jsp">&#x1F6AA; Salir</a>
      </nav>
    </aside>

    <main class="main">
      <div class="top-bar">
        <form action="../../Controllers/searchFincaController.jsp" method="POST" class="search-form">
          <input type="text" placeholder="Buscar finca..." class="search-input" name="search_input"/>
          <button type="submit" class="search-button">&#128269;</button>
        </form>
      </div>

      <div class="table-container">
        <table>
          <thead>
            <tr>
              <th>CODIGO</th>
              <th>NOMBRE</th>
              <th>HECTAREAS</th>
              <th>METROS</th>
              <th>PAIS</th>
              <th>DEPARTAMENTO</th>
              <th>CIUDAD</th>
              <th><span class="gear-icon">&#9881;</span></th>
            </tr>
          </thead>
          <tbody>
        <%
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String URL = "jdbc:mysql://localhost:3306/aplicativo_web_bd?serverTimezone=UTC";
    String USER = "root";
    String PASSWORD = "";

    try {
        // Cargar driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Crear conexión
        conn = DriverManager.getConnection(URL, USER, PASSWORD);

        String query = "SELECT f.*, " +
                       "u1.codigo_usuario AS codigo_propietario, " +
                       "u2.codigo_usuario AS codigo_capataz, " +
                       "u3.codigo_usuario AS codigo_vendedor " +
                       "FROM fincas f " +
                       "LEFT JOIN usuarios u1 ON f.propietario_id = u1.id_usuario " +
                       "LEFT JOIN usuarios u2 ON f.capataz_id = u2.id_usuario " +
                       "LEFT JOIN usuarios u3 ON f.vendedor_id = u3.id_usuario";

        stmt = conn.prepareStatement(query);
        rs = stmt.executeQuery();

        while(rs.next()) {
%>
          <tr>
            <td><%= rs.getString("codigo_finca") %></td>
            <td><%= rs.getString("nombre") %></td>
            <td><%= rs.getString("numHectareas") %></td>
            <td><%= rs.getString("metrosCuadrados") %></td>
            <td><%= rs.getString("pais") %></td>
            <td><%= rs.getString("departamento") %></td>
            <td><%= rs.getString("ciudad") %></td>
            <td>
              <button type="button" class="edit-btn"
                data-codigo="<%= rs.getString("codigo_finca") %>"
                data-nombre="<%= rs.getString("nombre") %>"
                data-propietario="<%= rs.getString("codigo_propietario") %>"
                data-capataz="<%= rs.getString("codigo_capataz") %>"
                data-vendedor="<%= rs.getString("codigo_vendedor") %>"
                data-leche="<%= rs.getInt("siProduceLeche") %>"
                data-cereales="<%= rs.getInt("siProduceCereales") %>"
                data-frutas="<%= rs.getInt("siProduceFrutas") %>"
                data-verduras="<%= rs.getInt("siProduceVerduras") %>">
                Editar
              </button>
              <button type="button" class="view-btn"
                data-codigo="<%= rs.getString("codigo_finca") %>"
                data-nombre="<%= rs.getString("nombre") %>"
                data-propietario="<%= rs.getString("codigo_propietario") %>"
                data-capataz="<%= rs.getString("codigo_capataz") %>"
                data-vendedor="<%= rs.getString("codigo_vendedor") %>"
                data-pais="<%= rs.getString("pais") %>"
                data-departamento="<%= rs.getString("departamento") %>"
                data-ciudad="<%= rs.getString("ciudad") %>"
                data-metros="<%= rs.getString("metrosCuadrados") %>"
                data-hectareas="<%= rs.getString("numHectareas") %>"
                data-leche="<%= rs.getInt("siProduceLeche") %>"
                data-cereales="<%= rs.getInt("siProduceCereales") %>"
                data-frutas="<%= rs.getInt("siProduceFrutas") %>"
                data-verduras="<%= rs.getInt("siProduceVerduras") %>">
                Ver
              </button>
              <form action="../../Controllers/deleteFincaController.jsp" method="POST" style="display:inline;">
                <input type="hidden" name="codigo_finca" value="<%= rs.getString("codigo_finca") %>">
                <button type="submit">Eliminar</button>
              </form>
            </td>
          </tr>
<%
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
          </tbody>
        </table>
      </div>
    </main>
  </div>

<!-- Modal oculto inicialmente -->
<!-- Modal Editar -->
<div id="modalEditar" style="
  display: none;
  position: fixed;
  top: 50%; left: 50%;
  transform: translate(-50%, -50%);
  background-color: #fff;
  padding: 24px;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.3);
  width: 400px;
  z-index: 1000;
  max-height: 90vh;
  overflow-y: auto;
  font-family: Arial, sans-serif;
">
  <h3 style="margin-bottom: 20px; color: #333;">Editar Detalles de la Finca</h3>

  <form id="formEditar">
    <div class="form-group">
      <label for="codigo">Código:</label>
      <input type="text" id="codigo" name="codigo" readonly>
    </div>

    <div class="form-group">
      <label for="nombre">Nombre:</label>
      <input type="text" id="nombre" name="nombre">
    </div>

    <div class="form-group">
      <label for="propietario">Propietario:</label>
      <input type="text" id="propietario" name="propietario">
    </div>

    <div class="form-group">
      <label for="capataz">Capataz:</label>
      <input type="text" id="capataz" name="capataz">
    </div>

    <div class="form-group">
      <label for="vendedor">Vendedor:</label>
      <input type="text" id="vendedor" name="vendedor">
    </div>

	<div class="form-group">
	  <label for="leche">Leche:</label>
	  <select id="leche" name="leche">
	    <option value="1">Sí</option>
	    <option value="0">No</option>
	  </select>
	</div>
	
	<div class="form-group">
	  <label for="cereales">Cereales:</label>
	  <select id="cereales" name="cereales">
	    <option value="1">Sí</option>
	    <option value="0">No</option>
	  </select>
	</div>
	
	<div class="form-group">
	  <label for="frutas">Frutas:</label>
	  <select id="frutas" name="frutas">
	    <option value="1">Sí</option>
	    <option value="0">No</option>
	  </select>
	</div>
	
	<div class="form-group">
	  <label for="verduras">Verduras:</label>
	  <select id="verduras" name="verduras">
	    <option value="1">Sí</option>
	    <option value="0">No</option>
	  </select>
	</div>

    <div style="text-align: right; margin-top: 20px;">
      <button type="submit" style="padding: 8px 15px; background: #4caf50; color: white; border: none; border-radius: 6px; cursor: pointer;">Guardar</button>
      <button type="button" id="cerrarModal" style="padding: 8px 15px; background: #ccc; border: none; border-radius: 6px; cursor: pointer; margin-left: 10px;">Cancelar</button>
    </div>
  </form>
</div>

<!-- Fondo oscuro -->
<div id="fondoModal" style="
  display: none;
  position: fixed;
  top: 0; left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0,0,0,0.5);
  z-index: 999;
"></div>

<div id="modalVer" style="display:none; position:fixed; top:50%; left:50%; 
    transform: translate(-50%, -50%);
    background-color: white; padding: 20px; border-radius: 8px; 
    box-shadow: 0 2px 10px rgba(0,0,0,0.3); width: 400px; z-index: 1000; 
    max-height: 90vh; overflow-y: auto;">
  <h3>Detalles de la Finca</h3>
  <div class="info-row"><strong>Código:</strong> <span id="verCodigo"></span></div>
  <div class="info-row"><strong>Nombre:</strong> <span id="verNombre"></span></div>
  <div class="info-row"><strong>Propietario:</strong> <span id="verPropietario"></span></div>
  <div class="info-row"><strong>Capataz:</strong> <span id="verCapataz"></span></div>
  <div class="info-row"><strong>Vendedor:</strong> <span id="verVendedor"></span></div>
  <div class="info-row"><strong>País:</strong> <span id="verPais"></span></div>
  <div class="info-row"><strong>Departamento:</strong> <span id="verDepartamento"></span></div>
  <div class="info-row"><strong>Ciudad:</strong> <span id="verCiudad"></span></div>
  <div class="info-row"><strong>Metros Cuadrados:</strong> <span id="verMetros"></span></div>
  <div class="info-row"><strong>Hectáreas:</strong> <span id="verHectareas"></span></div>
  <div class="info-row"><strong>Produce Leche:</strong> <span id="verLeche"></span></div>
  <div class="info-row"><strong>Produce Cereales:</strong> <span id="verCereales"></span></div>
  <div class="info-row"><strong>Produce Frutas:</strong> <span id="verFrutas"></span></div>
  <div class="info-row"><strong>Produce Verduras:</strong> <span id="verVerduras"></span></div>

  <button type="button" id="cerrarVerModal" style="margin-top: 15px; padding: 8px 15px; cursor:pointer;">Cerrar</button>
</div>

<!-- Fondo oscuro compartido -->
<div id="fondoModal" style="display:none; position:fixed; top:0; left:0; 
    width:100%; height:100%; background-color: rgba(0,0,0,0.5); z-index:999;"></div>

</body>

<script>
  document.addEventListener("DOMContentLoaded", function() {
    const modal = document.getElementById("modalEditar");
    const fondo = document.getElementById("fondoModal");
    const form = document.getElementById("formEditar");

    function mostrarModal(datos) {
      // Rellenar inputs con los datos del botón
      form.codigo.value = datos.codigo;
      form.nombre.value = datos.nombre;
      form.propietario.value = datos.propietario;
      form.capataz.value = datos.capataz;
      form.vendedor.value = datos.vendedor;
      form.leche.value = datos.leche;
      form.cereales.value = datos.cereales;
      form.frutas.value = datos.frutas;
      form.verduras.value = datos.verduras;

      modal.style.display = "block";
      fondo.style.display = "block";
    }

    document.querySelectorAll(".edit-btn").forEach(function(btn) {
      btn.addEventListener("click", function() {
        const datos = {
          codigo: this.getAttribute("data-codigo"),
          nombre: this.getAttribute("data-nombre"),
          propietario: this.getAttribute("data-propietario"),
          capataz: this.getAttribute("data-capataz"),
          vendedor: this.getAttribute("data-vendedor"),
          leche: this.getAttribute("data-leche"),
          cereales: this.getAttribute("data-cereales"),
          frutas: this.getAttribute("data-frutas"),
          verduras: this.getAttribute("data-verduras")
        };
        mostrarModal(datos);
      });
    });

    // Botón cerrar (Cancelar)
    document.getElementById("cerrarModal").addEventListener("click", function() {
      modal.style.display = "none";
      fondo.style.display = "none";
    });

    fondo.addEventListener("click", function() {
      modal.style.display = "none";
      fondo.style.display = "none";
    });

    // Aquí podrías manejar el submit para guardar cambios
    form.addEventListener("submit", function(e) {
      e.preventDefault(); // Evita recargar la página

      // Obtener los valores editados
      const datosEditados = {
        codigo: form.codigo.value,
        nombre: form.nombre.value,
        propietario: form.propietario.value,
        capataz: form.capataz.value,
        vendedor: form.vendedor.value,
        leche: form.leche.value,
        cereales: form.cereales.value,
        frutas: form.frutas.value,
        verduras: form.verduras.value
      };

      console.log("Datos para enviar al servidor:", datosEditados);

      // Aquí llamas a tu función para enviar datos con AJAX o form.submit() si usas otro método

      // Por ahora cerramos modal:
      modal.style.display = "none";
      fondo.style.display = "none";
    });
  });
</script>

<script>
  document.querySelectorAll('.view-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      document.getElementById('verCodigo').textContent = btn.dataset.codigo;
      document.getElementById('verNombre').textContent = btn.dataset.nombre;
      document.getElementById('verPropietario').textContent = btn.dataset.propietario;
      document.getElementById('verCapataz').textContent = btn.dataset.capataz;
      document.getElementById('verVendedor').textContent = btn.dataset.vendedor;
      document.getElementById('verPais').textContent = btn.dataset.pais;
      document.getElementById('verDepartamento').textContent = btn.dataset.departamento;
      document.getElementById('verCiudad').textContent = btn.dataset.ciudad;
      document.getElementById('verMetros').textContent = btn.dataset.metros;
      document.getElementById('verHectareas').textContent = btn.dataset.hectareas;
      document.getElementById('verLeche').textContent = btn.dataset.leche == "1" ? "Sí" : "No";
      document.getElementById('verCereales').textContent = btn.dataset.cereales == "1" ? "Sí" : "No";
      document.getElementById('verFrutas').textContent = btn.dataset.frutas == "1" ? "Sí" : "No";
      document.getElementById('verVerduras').textContent = btn.dataset.verduras == "1" ? "Sí" : "No";

      document.getElementById('modalVer').style.display = 'block';
      document.getElementById('fondoModal').style.display = 'block';
    });
  });

  document.getElementById('cerrarVerModal').addEventListener('click', () => {
    document.getElementById('modalVer').style.display = 'none';
    document.getElementById('fondoModal').style.display = 'none';
  });
</script>

</html>
