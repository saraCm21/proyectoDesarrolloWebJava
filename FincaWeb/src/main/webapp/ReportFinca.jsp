<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Gráfica Fincas</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    body {
      margin: 0;
      padding: 0;
      height: 100%;
      background-color: #0b0c1a;
      font-family: Arial, sans-serif;
    }

    .container {
      display: flex;
      min-height: 100vh;
    }

    .sidebar {
      width: 220px;
      background-color: #2196f3;
      color: white;
      padding: 20px;
      display: flex;
      flex-direction: column;
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
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      padding: 40px 20px;
    }

    .charts-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 40px;
      flex-wrap: wrap;
      padding: 20px;
    }

    .chart-box {
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 8px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      padding: 20px;
      width: 400px;
      text-align: center;
    }

    .chart-box h3 {
      margin-bottom: 20px;
      font-size: 18px;
      color: #333;
    }

    canvas {
      max-width: 100%;
      height: auto;
    }
  </style>
</head>
<body>
  <div class="container">
    <aside class="sidebar">
      <h2>MENÚ</h2>
      <nav>
        <a href="../../Views/principalFrames/homeFrame.php">🏡 Inicio</a>
      </nav>
    </aside>
    <main class="main-content">
      <div class="charts-container">
        <div class="chart-box">
          <h3>Relación de Fincas Según su Producción</h3>
          <canvas id="fincaChart"></canvas>
        </div>
        <div class="chart-box">
          <h3>Fincas por Ciudad</h3>
          <canvas id="ciudadesChart"></canvas>
        </div>
      </div>
    </main>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', () => {
      fetch('../../Controllers/reportFincaController.php')
        .then(response => response.json())
        .then(data => {
          const produccionConfig = {
            type: 'pie',
            data: {
              labels: data.produccion.labels,
              datasets: [{
                label: 'Producción en Fincas',
                data: data.produccion.data,
                backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0'],
                hoverOffset: 4
              }]
            },
            options: {
              responsive: true,
              plugins: {
                legend: { position: 'top' },
                title: {
                  display: true,
                  text: 'Producción en las Fincas'
                }
              }
            }
          };

          const ciudadesConfig = {
            type: 'pie',
            data: {
              labels: data.ciudades.labels,
              datasets: [{
                label: 'Fincas por Ciudad',
                data: data.ciudades.data,
                backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0'],
                hoverOffset: 4
              }]
            },
            options: {
              responsive: true,
              plugins: {
                legend: { position: 'top' },
                title: {
                  display: true,
                  text: 'Fincas por Ciudad'
                }
              }
            }
          };

          const ctxProduccion = document.getElementById('fincaChart').getContext('2d');
          new Chart(ctxProduccion, produccionConfig);

          const ctxCiudades = document.getElementById('ciudadesChart').getContext('2d');
          new Chart(ctxCiudades, ciudadesConfig);
        })
        .catch(error => {
          console.error('Error al obtener los datos:', error);
        });
    });
  </script>
</body>
</html>
