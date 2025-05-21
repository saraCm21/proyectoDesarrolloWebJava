package libs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connect {

    private static Connect instancia;

    private static final String URL = "jdbc:mysql://localhost:3306/aplicativo_web_bd";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Constructor privado para evitar instanciación externa
    private Connect() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("Error al cargar el driver");
            e.printStackTrace();
        }
    }

    // Método estático para obtener la única instancia
    public static Connect getInstance() {
        if (instancia == null) {
            instancia = new Connect();
        }
        return instancia;
    }

    // Método para obtener una nueva conexión cada vez que se llame
    public Connection getConexion() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
