<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Create Account</title>
  <!-- Si prefieres archivo CSS externo, descomenta esta línea y pon el archivo en /css/signUpStyled.css -->
  <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signUpStyled.css" /> -->

  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', sans-serif;
    }

    body {
      background-color: #0d0e1a;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .container {
      position: relative; /* para que los shapes absolutos se posicionen bien */
      display: flex;
      width: 900px;
      height: 500px;
      border-radius: 20px;
      overflow: hidden;
      box-shadow: 0 10px 30px rgba(0,0,0,0.3);
      background-color: white; /* para que se vea bien el formulario */
    }


    .blue-panel {
      width: 40%;
      background-color: #249cf2;
      border-top-left-radius: 20px;
      border-bottom-left-radius: 20px;
      z-index: 1;
    }

    .form-box {
      width: 60%;
      padding: 40px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      border-top-right-radius: 20px;
      border-bottom-right-radius: 20px;
      z-index: 2;
    }

    h2 {
      margin-bottom: 30px;
      font-size: 24px;
      font-weight: 600;
      color: #000;
    }

    form {
      display: flex;
      flex-direction: column;
      gap: 20px;
    }

    .input-group {
      position: relative;
    }

    .input-group input,
    .input-group select {
      width: 100%;
      padding: 10px 40px 10px 10px;
      border: 1px solid #cccccc;
      border-radius: 5px;
      font-size: 14px;
      outline: none;
      color: #0303038e;
    }

    .input-group .icon {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
      pointer-events: none;
      font-size: 20px;
      opacity: 0.6;
    }

    button {
      margin-top: 20px;
      padding: 12px;
      border: none;
      border-radius: 6px;
      background-color: #3366ff;
      color: #fff;
      font-weight: bold;
      font-size: 16px;
      cursor: pointer;
      box-shadow: 0 4px 10px rgba(0,0,0,0.2);
      transition: all 0.3s ease;
    }

    button:hover {
      transform: scale(1.02);
      box-shadow: 0 6px 15px rgba(0,0,0,0.3);
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
      z-index: 0;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="blue-panel"></div>
    <div class="left-shape"></div>

    <div class="form-box">
      <h2>Create Account</h2>
      <form action="${pageContext.request.contextPath}/Controllers/signUpController" method="POST">
        <div class="input-group">
          <input type="email" name="email" placeholder="Email" required />
          <span class="icon">📧</span>
        </div>
        <div class="input-group">
          <input type="text" name="username" placeholder="Username" required />
          <span class="icon">🪪</span>
        </div>
        <div class="input-group">
          <input type="password" name="password" placeholder="Password" required />
          <span class="icon">🔒</span>
        </div>
        <div class="input-group">
          <input type="text" name="name" placeholder="Name" required />
          <span class="icon">👤</span>
        </div>
        <div class="input-group">
          <select name="role" required>
            <option value="" disabled selected>Select Role</option>
            <option value="vendedor">vendedor</option>
            <option value="propietario">propietario</option>
            <option value="capataz">capataz</option>
          </select>
          <span class="icon">⚙️</span>
        </div>
        <button type="submit">Create Account</button>
      </form>
    </div>

    <div class="right-shape"></div>
  </div>

  <script>
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('error')) {
      const errorMessage = urlParams.get('error');
      alert('Error: ' + decodeURIComponent(errorMessage));
    }
  </script>
</body>
</html>
