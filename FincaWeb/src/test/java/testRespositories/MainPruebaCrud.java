package testRespositories;

import java.util.HashMap;
import java.util.Map;

import models.Entities.Finca;
import models.Entities.Usuario;
import models.Repositories.FincaRepository;
import models.Repositories.UsuarioRepository;
import models.Servicies.ChangePasswordService;
import models.Servicies.CreateFincaService;
import models.Servicies.LoginService;
import models.Servicies.SendEmailService;
import models.Servicies.SignUpService;

public class MainPruebaCrud {
	
	public static void main(String[] args) {
		UsuarioRepository usuarioRespository = new UsuarioRepository();
		FincaRepository fincaRepository = new FincaRepository();
		LoginService loginService = new LoginService(); 
		SignUpService signUpService = new SignUpService();
		CreateFincaService createFincaService = new CreateFincaService();
		SendEmailService sendEmailService = new SendEmailService();
		ChangePasswordService passwordService = new ChangePasswordService();
		
/*
	Usuario user = new Usuario("Miri", "sara1234", "Mirian", "saracastellano2108@gmail.com", "vendedor");
	
	boolean create = usuarioRespository.createUser(user);
	
	if (create) {
		System.out.println("usuario creado");
	}else {
		System.out.println("Error al crear el usuario");
	}
 


	boolean deleteUser = usuarioRespository.deleteUserCod(853187);
	if (deleteUser) {
		System.out.println("Usuario eliminado");
	}else {
		System.out.println("El usuario no puedo ser eliminado");
	}

	boolean deleteUser = usuarioRespository.deleteUserUsername("linda");
	if (deleteUser) {
		System.out.println("Usuario eliminado");
	}else {
		System.out.println("El usuario no puedo ser eliminado");
	}
	
		
	usuarioRespository.updateUser("960117", "karinl", "kari", "sasacm0610@gmil.com", "kari123");

		
	System.out.println(usuarioRespository.findUserByCode("889180").toString());

		
	        String nombre = "Las Palmeras";
	        int numHectareas = 30;
	        float metrosCuadrados = 15000.0f;
	        String codigoPropietario = "960117"; 
	        String codigoCapataz = "889180"; 
	        String codigoVendedor = "889180";
	        String pais = "Colombia";
	        String departamento = "Bolívar";
	        String ciudad = "Cartagena";
	        boolean siProduceLeche = true;
	        boolean siProduceCereales = false;
	        boolean siProduceFrutas = true;
	        boolean siProduceVerduras = true;

	        boolean creada = FincaRepository.createFinca(nombre, numHectareas, metrosCuadrados,
	                                     codigoPropietario, codigoCapataz, codigoVendedor,
	                                     pais, departamento, ciudad, siProduceLeche, 
	                                     siProduceCereales, siProduceFrutas, siProduceVerduras);
	        
	        if (creada) {
	            System.out.println("✅ Finca creada con éxito.");
	        } else {
	            System.out.println("❌ Error al crear la finca.");
	        }
  

		   Map<String, Object> datosActualizar = new HashMap<>();
	        datosActualizar.put("nombre", "Nueva Finca Los Andes");
	        datosActualizar.put("siProduceLeche", false);
	        datosActualizar.put("siProduceFrutas", true);

	        String codigoFinca = "948832";

	        // Llamamos al método updateFinca y mostramos el resultado
	        boolean actualizada = fincaRepository.updateFinca(codigoFinca, datosActualizar);

	        if (actualizada) {
	            System.out.println("✅ La finca fue actualizada correctamente.");
	        } else {
	            System.out.println("❌ No se pudo actualizar la finca.");
	        }
	        
		
		
		System.out.println(fincaRepository.findFincaByCod("948832"));
		
		
		System.out.println(usuarioRespository.buscarPorUsernameOEmail("saraTri"));
		
		System.out.println(loginService.login("saraTri", "sara2108"));
		
		Usuario user = new Usuario("Miri", "sara1234", "Mirian", "saracastellano2108@gmail.com", "vendedor");
		
		System.out.println(signUpService.validateAndRegisterUser(user));
	

        String nombre = "Las Palmeras";
        int numHectareas = 30;
        float metrosCuadrados = 15000.0f;
        String codigoPropietario = "960117"; 
        String codigoCapataz = "889180"; 
        String codigoVendedor = "691240";
        String pais = "Colombia";
        String departamento = "Bolívar";
        String ciudad = "Cartagena";
        boolean siProduceLeche = true;
        boolean siProduceCereales = false;
        boolean siProduceFrutas = true;
        boolean siProduceVerduras = true;
        
        Finca finca = new Finca(nombre, numHectareas, metrosCuadrados, codigoPropietario, codigoCapataz, codigoVendedor, pais, departamento, ciudad, siProduceLeche, siProduceCereales, siProduceFrutas, siProduceVerduras);
        System.out.println(createFincaService.create(finca));
 
		sendEmailService.sendEmail("saracastellano2108@gmail.com");*/
		
//		sendEmailService.sendEmail("saracastellano2108@gmail.com"); 
		
//		passwordService.changePassword(602913, "sara1234", "saracastellano2108@gmail.com");
		
	    }
}
