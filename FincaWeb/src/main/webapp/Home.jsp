<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Fincas</title>
  <style>
    /* Aquí va todo tu CSS igual que en tu código original, lo omito para no repetir */
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
                  Class.forName("com.mysql.cj.jdbc.Driver");
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
                <!-- Botón Editar -->
                <button type="button" class="edit-btn"
                  data-codigo="<%= rs.getString("codigo_finca") %>"
                  data-nombre="<%= rs.getString("nombre") %>"
                  data-hectareas="<%= rs.getString("numHectareas") %>"
                  data-metros="<%= rs.getString("metrosCuadrados") %>"
                  data-pais="<%= rs.getString("pais") %>"
                  data-departamento="<%= rs.getString("departamento") %>"
                  data-ciudad="<%= rs.getString("ciudad") %>">
                  Editar
                </button>

                <!-- Botón Ver -->
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

                <!-- Botón Eliminar -->
                <form action="../../Controllers/deleteFincaController.jsp" method="POST" style="display:inline;">
                  <input type="hidden" name="codigo_finca" value="<%= rs.getString("codigo_finca") %>"/>
                  <button type="submit" class="delete-btn" onclick="return confirm('¿Seguro que deseas eliminar esta finca?');">Eliminar</button>
                </form>
              </td>
            </tr>
            <%
                  }
              } catch(Exception e) {
                  out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
              } finally {
                  if(rs != null) try { rs.close(); } catch(SQLException e) {}
                  if(stmt != null) try { stmt.close(); } catch(SQLException e) {}
                  if(conn != null) try { conn.close(); } catch(SQLException e) {}
              }
            %>
          </tbody>
        </table>
      </div>
    </main>
  </div>
  
 <!-- Modal Editar -->
  <div id="fondoModal"></div>
  <div id="modalEditar">
    <h3>Editar Finca</h3>
    <form id="formEditar" method="POST" action="updateFincaController.jsp">
      <div class="form-group">
        <label for="codigo_finca">Código</label>
        <input type="text" id="codigo_finca" name="codigo_finca" readonly />
      </div>
      <div class="form-group">
        <label for="nombre">Nombre</label>
        <input type="text" id="nombre" name="nombre" required />
      </div>
      <div class="form-group">
        <label for="numHectareas">Hectáreas</label>
        <input type="number" id="numHectareas" name="numHectareas" required />
      </div>
      <div class="form-group">
        <label for="metrosCuadrados">Metros Cuadrados</label>
        <input type="number" id="metrosCuadrados" name="metrosCuadrados" required />
      </div>
      <div class="form-group">
        <label for="pais">País</label>
        <input type="text" id="pais" name="pais" required />
      </div>
      <div class="form-group">
        <label for="departamento">Departamento</label>
        <input type="text" id="departamento" name="departamento" required />
      </div>
      <div class="form-group">
        <label for="ciudad">Ciudad</label>
        <input type="text" id="ciudad" name="ciudad" required />
      </div>
      <button type="submit">Guardar</button>
      <button type="button" id="cerrarModal">Cancelar</button>
    </form>
  </div>
  
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
  
</body>

  <script>
    const fondoModal = document.getElementById('fondoModal');
    const modalEditar = document.getElementById('modalEditar');
    const cerrarModalBtn = document.getElementById('cerrarModal');
    const formEditar = document.getElementById('formEditar');

    document.querySelectorAll('.edit-btn').forEach(button => {
      button.addEventListener('click', () => {
        // Abrir modal
        fondoModal.style.display = 'block';
        modalEditar.style.display = 'block';

        // Llenar campos con los datos del botón
        formEditar.codigo_finca.value = button.getAttribute('data-codigo');
        formEditar.nombre.value = button.getAttribute('data-nombre');
        formEditar.numHectareas.value = button.getAttribute('data-hectareas');
        formEditar.metrosCuadrados.value = button.getAttribute('data-metros');
        formEditar.pais.value = button.getAttribute('data-pais');
        formEditar.departamento.value = button.getAttribute('data-departamento');
        formEditar.ciudad.value = button.getAttribute('data-ciudad');
      });
    });

    cerrarModalBtn.addEventListener('click', () => {
      fondoModal.style.display = 'none';
      modalEditar.style.display = 'none';
    });

    // Opcional: cerrar modal si clic fuera del modal
    fondoModal.addEventListener('click', () => {
      fondoModal.style.display = 'none';
      modalEditar.style.display = 'none';
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
