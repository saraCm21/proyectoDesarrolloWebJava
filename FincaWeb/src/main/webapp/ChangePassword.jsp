<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Cambiar Contraseña</title>
  <style>
    * {
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }
    
    body {
      background-color: #0f121f;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      position: relative;
      overflow: hidden;
    }
    
    .container {
      background: white;
      padding: 2rem;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
      width: 100%;
      max-width: 400px;
      position: relative;
      z-index: 2;
    }
  
    .left-shape {
      position: absolute;
      top: 50%;
      left: -100px;
      transform: translateY(-50%);
      width: 600px;
      height: 600px;
      background: #249cf2;
      border-radius: 50%;
      box-shadow: inset 0 0 30px rgba(255, 255, 255, 0.2);
      z-index: 1;
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
    
    h2 {
      margin-bottom: 30px;
      font-size: 24px;
      font-weight: 600;
      color: #000;
    }
    
    label {
      display: block;
      margin-bottom: 0.5rem;
      font-size: 14px;
      color: #0303038e;
    }
    
    input {
      width: 100%;
      padding: 0.6rem;
      margin-bottom: 1.2rem;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 14px;
    }
    
    button {
      width: 100%;
      padding: 0.7rem;
      background: #007BFF;
      border: none;
      color: white;
      font-size: 1rem;
      border-radius: 5px;
      cursor: pointer;
      transition: background 0.3s ease;
    }
    
    button:hover:not(:disabled) {
      background: #0056b3;
    }
    
    button:disabled {
      background: #a0a0a0;
      cursor: not-allowed;
    }
    
    .message {
      text-align: center;
      margin-top: 1rem;
      color: red;
    }
  </style>
</head>
<body>

  <div class="left-shape"></div>
  <div class="right-shape"></div>

  <div class="container">
    <h2>Cambiar Contraseña</h2>
    <form action="changePassword" method="POST">
      <input type="hidden" name="action" value="changePassword">

      <label for="email">Email</label>
      <input type="text" id="email" name="email" required />

      <label for="codigo">Código de verificación</label>
      <input type="text" id="codigo" name="code" required />

      <label for="nueva">Nueva Contraseña</label>
      <input type="password" id="password" name="password" required />

      <label for="verificacion">Confirmar Contraseña</label>
      <input type="password" id="verificacion" name="verificacion" required />

      <button type="submit" disabled>Aceptar</button>
    </form>
  </div>

  <script>
    const urlParams = new URLSearchParams(window.location.search);

    if (urlParams.has('error')) {
      const error = urlParams.get('error');
      if (error === 'email_not_found') {
        alert('El correo electrónico no se encontró. Por favor, verifica e inténtalo de nuevo.');
      } else if (error === 'invalid_code') {
        alert('El código de recuperación es inválido.');
      } else if (error === 'missing_fields') {
        alert('Por favor, completa todos los campos.');
      } else if (error === 'password_mismatch') {
        alert('Las contraseñas no coinciden. Por favor, inténtalo de nuevo.');
      }
    }
  </script>

  <script>
    const passwordInput = document.getElementById('password');
    const verificationInput = document.getElementById('verificacion');
    const acceptButton = document.querySelector('button[type="submit"]');

    function validatePasswords() {
      if (passwordInput.value === verificationInput.value && passwordInput.value !== '') {
        acceptButton.disabled = false;
      } else {
        acceptButton.disabled = true;
      }
    }

    passwordInput.addEventListener('input', validatePasswords);
    verificationInput.addEventListener('input', validatePasswords);
  </script>

</body>
</html>
