<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Crear Finca</title>
  <style>
    * {
      box-sizing: border-box;
    }
    
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f5f5f5;
      height: 100vh;
      display: flex;
    }
    
    .container {
      display: flex;
      width: 100%;
      height: 100vh;
      position: relative;
    }
    
    .sidebar {
      width: 220px;
      background-color: #2196f3;
      color: white;
      padding: 20px;
      display: flex;
      flex-direction: column;
      height: 100vh;
    }
    
    .sidebar h2 {
      margin-bottom: 20px;
      font-size: 22px;
      text-align: center;
    }
    
    .sidebar a {
      color: white;
      text-decoration: none;
      margin: 10px 0;
      padding: 10px;
      border-radius: 5px;
      display: block;
      transition: background-color 0.2s;
    }
    
    .sidebar a:hover {
      background-color: #1c82d6;
    }
    
    .main-content {
      flex-grow: 1;
      padding: 30px;
      background-color: #0b0d1b;
      display: flex;
      flex-direction: column;
      align-items: center;
      overflow-y: auto;
    }
    
    h1 {
      margin-bottom: 20px;
      font-size: 22px;
      color: #fafafa;
    }
    
    .form-box {
      background-color: #fafafa;
      border: 1px solid #ddd;
      border-radius: 12px;
      padding: 20px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      max-width: 600px;
      width: 100%;
    }
    
    .form {
      display: grid;
      grid-template-columns: 1fr;
      gap: 10px;
    }
    
    .form label {
      font-weight: bold;
      font-size: 14px;
      text-align: left;
      display: block;
      margin-bottom: 4px;
    }
    
    .form input,
    .form select {
      padding: 6px 8px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 4px;
      width: 100%;
    }
    
    button[type="submit"] {
      padding: 8px 12px;
      background-color: #2196f3;
      color: white;
      font-size: 14px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      margin-top: 10px;
      width: fit-content;
    }
    
    button[type="submit"]:hover {
      background-color: #1976d2;
    }
  
    .right-shape {
      width: 400px;
      height: 400px;
      background: linear-gradient(135deg, #2196f3, #00bcd4);
      transform: rotate(45deg);
      position: absolute;
      right: -150px;
      top: 100px;
      box-shadow: 0 0 0 100px #fcecd6;
      z-index: 1;
    }
  </style>
</head>
<body>
  <div class="container">
    <aside class="sidebar">
      <h2>MENÚ</h2>
      <nav>
        <a href="../../Views/principalFrames/homeFrame.jsp">🏡 Inicio</a>
        <a href="../../Views/principalFrames/reportFinca.jsp">📄 Reporte</a>
      </nav>
    </aside>

    <div class="main-content">
      <h1>Crear Finca</h1>
      <div class="form-box">
        <form class="form" action="../../Controllers/createFincaController" method="POST">
          <label for="nombre">Nombre</label>
          <input type="text" id="nombre" name="nombre" placeholder="Nombre" />
          
          <label for="numHectaras">Número de Hectáreas</label>
          <input type="number" id="numHectaras" name="numHectaras" placeholder="Número de Hectáreas" />
          
          <label for="metrosCuadrados">Metros Cuadrados</label>
          <input type="number" id="metrosCuadrados" name="metrosCuadrados" placeholder="Metros Cuadrados" />
          
          <label for="codigo_propietario">Código del Propietario</label>
          <input type="text" id="codigo_propietario" name="codigo_propietario" placeholder="Código del Propietario" />
          
          <label for="codigo_capataz">Código del Capataz</label>
          <input type="text" id="codigo_capataz" name="codigo_capataz" placeholder="Código del Capataz" />
          
          <label for="codigo_vendedor">Código del Vendedor</label>
          <input type="text" id="codigo_vendedor" name="codigo_vendedor" placeholder="Código del Vendedor" />
          
          <label for="pais">País</label>
          <input type="text" id="pais" name="pais" placeholder="País" />
          
          <label for="departamento">Departamento</label>
          <input type="text" id="departamento" name="departamento" placeholder="Departamento" />
          
          <label for="ciudad">Ciudad</label>
          <input type="text" id="ciudad" name="ciudad" placeholder="Ciudad" />
          
          <label for="siProduceLeche">¿Produce Leche?</label>
          <select id="siProduceLeche" name="siProduceLeche">
            <option value="">Seleccione</option>
            <option value="1">Sí</option>
            <option value="0">No</option>
          </select>
          
          <label for="siProduceCereales">¿Produce Cereales?</label>
          <select id="siProduceCereales" name="siProduceCereales">
            <option value="">Seleccione</option>
            <option value="1">Sí</option>
            <option value="0">No</option>
          </select>
          
          <label for="siProduceFrutas">¿Produce Frutas?</label>
          <select id="siProduceFrutas" name="siProduceFrutas">
            <option value="">Seleccione</option>
            <option value="1">Sí</option>
            <option value="0">No</option>
          </select>
          
          <label for="siProduceVerduras">¿Produce Verduras?</label>
          <select id="siProduceVerduras" name="siProduceVerduras">
            <option value="">Seleccione</option>
            <option value="1">Sí</option>
            <option value="0">No</option>
          </select>
  
          <button type="submit">Guardar Finca</button>
        </form>
      </div>
    </div>

    <div class="right-shape"></div>
  </div>

  <script>
    // Para mostrar alertas según parámetros en la URL
    const urlPara = new URLSearchParams(window.location.search);

    if (urlPara.has('error')) {
      const error = urlPara.get('error');
      if (error === 'empty_fields') {
        alert('Hay campos vacíos.');
      } else if (error === 'error_crear_finca') {
        alert('Hubo un error al crear la finca. Por favor, inténtalo de nuevo.');
      }
    }

    if (urlPara.has('success')) {
      alert('Finca registrada exitosamente.');
    }
  </script>
</body>
</html>
