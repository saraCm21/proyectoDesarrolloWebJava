package utils;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


public class HashUtil {
	private static final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
    public static  String hashPassword(String password) {
    	return encoder.encode(password);
    }

    public static boolean verificarPassword(String passwordPlano, String hashGuardado) {
        return encoder.matches(passwordPlano, hashGuardado);
    }
   
}