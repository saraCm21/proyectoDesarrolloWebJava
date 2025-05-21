<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login Page</title>
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background-color: #0f121f;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .container {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 100%;
      height: 100%;
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
    }

    .login-box {
      width: 300px;
      color: white;
      text-align: center;
      z-index: 10;
    }

    .login-box h2 {
      margin-bottom: 30px;
      font-size: 36px;
    }

    .login-box input {
      width: 100%;
      padding: 10px;
      margin: 10px 0;
      border: none;
      border-bottom: 2px solid #ccc;
      background: transparent;
      color: white;
      font-size: 16px;
    }

    .login-box input::placeholder {
      color: #aaa;
    }

    .forgot {
      display: block;
      margin: 10px 0;
      color: #aaa;
      font-size: 12px;
      text-decoration: none;
    }

    button {
      width: 100%;
      padding: 10px;
      margin-top: 10px;
      background-color: #3366ff;
      color: white;
      font-weight: bold;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .signup {
      background-color: #4d6dff;
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

    #forgot-password-dialog {
      display: none;
      position: fixed;
      top: 5%;
      left: 50%;
      transform: translate(-50%, 0);
      background: white;
      padding: 20px;
      border: 1px solid rgb(172, 172, 172);
      box-shadow: rgba(0, 0, 0, 0.2) 0px 4px 8px;
      z-index: 1000;
      width: 300px;
      border-radius: 8px;
    }
  </style>
</head>
<body>
  <div class="left-shape"></div>
  <div class="container">
    <div class="login-box">
      <h2>login</h2>
      <form action="login" method="POST">
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <a href="#" class="forgot" id="forgot-password">Forgot your password?</a>
        <button type="submit">Login</button>
        <button type="button" class="signup" onclick="window.location.href='signUpFrame.html';">SignUp</button>
      </form>

      <%-- Mostrar mensaje de error si viene con ?error=login_failed --%>
      <%
        String error = request.getParameter("error");
        if ("login_failed".equals(error)) {
      %>
        <p style="color: red;">Invalid username or password. Please try again.</p>
      <%
        }
      %>
    </div>
    <div class="right-shape"></div>
  </div>

  <div id="forgot-password-dialog">
    <h3>Recover Password</h3>
    <input type="email" id="email-input" placeholder="Enter Email" required
           style="display: block; margin-bottom: 10px; width: 95%; padding: 5px; border: 1px solid #ccccccec;" />
    <button id="submit-email" style="padding: 5px 10px; margin-right: 10px; background-color: #3366ff">Accept</button>
    <button id="cancel-dialog" style="padding: 5px 10px; background-color: #3366ff">Cancel</button>
  </div>

  <script>
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('error')) {
      const error = urlParams.get('error');
      if (error === 'login_failed') {
        alert('Credenciales incorrectas. Por favor, inténtalo de nuevo.');
      }
    }

    if (urlParams.has('success')) {
      alert('Registro exitoso. Ahora puedes iniciar sesión.');
    }

    document.getElementById('forgot-password').addEventListener('click', function (e) {
      e.preventDefault();
      document.getElementById('forgot-password-dialog').style.display = 'block';
    });

    document.getElementById('submit-email').addEventListener('click', function () {
      const email = document.getElementById('email-input').value.trim();
      if (!email) {
        alert('Por favor, ingresa tu correo electrónico.');
        return;
      }

      const form = document.createElement('form');
      form.method = 'POST';
      form.action = "../../Views/loginFrames/changePasswordFrame.html";

      const actionField = document.createElement('input');
      actionField.type = 'hidden';
      actionField.name = 'action';
      actionField.value = 'sendEmail';
      form.appendChild(actionField);

      const emailField = document.createElement('input');
      emailField.type = 'hidden';
      emailField.name = 'email';
      emailField.value = email;
      form.appendChild(emailField);

      document.body.appendChild(form);
      form.submit();
    });

    document.getElementById('cancel-dialog').addEventListener('click', function () {
      document.getElementById('forgot-password-dialog').style.display = 'none';
    });
  </script>
</body>
</html>
