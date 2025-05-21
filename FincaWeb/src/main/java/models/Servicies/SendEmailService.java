package models.Servicies;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Properties;
import java.util.Random;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import libs.Connect;
import models.Entities.Usuario;
import models.Repositories.UsuarioRepository;

public class SendEmailService {

	    public boolean sendEmail(String email) {
	        Usuario usuario = UsuarioRepository.buscarPorUsernameOEmail(email);

	        if (usuario == null) {
	            return false;
	        }

	        int codigo = new Random().nextInt(900000) + 100000;
	        usuario.setCodRecuperacion(codigo);
	        usuario.setTimeLimit(LocalDateTime.now().plusMinutes(15));

	        String sql = "UPDATE usuarios SET cod_recuperacion = ?, time_limit = ? WHERE email = ?";

	        try (Connection conn = Connect.getInstance().getConexion();
	             PreparedStatement stmt = conn.prepareStatement(sql)) {

	            stmt.setInt(1, usuario.getCodRecuperacion());
	            stmt.setTimestamp(2, Timestamp.valueOf(usuario.getTimeLimit()));
	            stmt.setString(3, usuario.getEmail());

	            int filasActualizadas = stmt.executeUpdate();

	            if (filasActualizadas == 0) {
	                System.out.println("No se actualizó ningún usuario.");
	                return false;
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }

	        final String remitente = "sasacm0610@gmail.com";
	        final String clave = "frvg ztew lkfd spkq";

	        Properties props = new Properties();
	        props.put("mail.smtp.host", "smtp.gmail.com");
	        props.put("mail.smtp.port", "587");
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.starttls.enable", "true");

	        Session sesion = Session.getInstance(props, new Authenticator() {
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(remitente, clave);
	            }
	        });

	        try {
	            Message mensaje = new MimeMessage(sesion);
	            mensaje.setFrom(new InternetAddress(remitente));
	            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(usuario.getEmail()));
	            mensaje.setSubject("Código de recuperación");
	            mensaje.setText("Tu código de recuperación es: " + codigo + ". Tiene validez de 15 minutos.");

	            Transport.send(mensaje);
	            return true;

	        } catch (MessagingException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	}