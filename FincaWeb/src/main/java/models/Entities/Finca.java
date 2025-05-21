package models.Entities;

import java.util.Random;

public class Finca {
    private int idFinca;
    private String codigoFinca;
    private String nombre;
    private float numHectareas;
    private float metrosCuadrados;
    private int propietarioId;
    private int capatazId;
    private int vendedorId;
    private String codigo_propietario;
    private String codigo_capataz;
    private String codigo_vendedor;
    private String pais;
    private String departamento;
    private String ciudad;
    private boolean siProduceLeche;
    private boolean siProduceCereales;
    private boolean siProduceFrutas;
    private boolean siProduceVerduras;

    public Finca() {}
    
    // CONSTRUCTOR PARA EXTREAR Y MANEJAR UNA FINCA
    public Finca(String codigoFinca, String nombre, float numHectareas, float metrosCuadrados,
            String codigo_propietario, String codigo_capataz, String codigo_vendedor, String pais, String departamento,
            String ciudad, boolean siProduceLeche, boolean siProduceCereales,
            boolean siProduceFrutas, boolean siProduceVerduras) {
	   this.codigoFinca = codigoFinca;
	   this.nombre = nombre;
	   this.numHectareas = numHectareas;
	   this.metrosCuadrados = metrosCuadrados;
	   this.codigo_propietario = codigo_propietario;
	   this.codigo_capataz = codigo_capataz;
	   this.codigo_vendedor = codigo_vendedor;
	   this.pais = pais;
	   this.departamento = departamento;
	   this.ciudad = ciudad;
	   this.siProduceLeche = siProduceLeche;
	   this.siProduceCereales = siProduceCereales;
	   this.siProduceFrutas = siProduceFrutas;
	   this.siProduceVerduras = siProduceVerduras;
	}

    public Finca(String nombre, float numHectareas, float metrosCuadrados,
            String codigo_propietario, String codigo_capataz, String codigo_vendedor, String pais, String departamento,
            String ciudad, boolean siProduceLeche, boolean siProduceCereales,
            boolean siProduceFrutas, boolean siProduceVerduras) {
    	Random random = new Random();
    	int number = 100000 + random.nextInt(900000);
        this.codigoFinca = String.valueOf(number);
	   this.nombre = nombre;
	   this.numHectareas = numHectareas;
	   this.metrosCuadrados = metrosCuadrados;
	   this.codigo_propietario = codigo_propietario;
	   this.codigo_capataz = codigo_capataz;
	   this.codigo_vendedor = codigo_vendedor;
	   this.pais = pais;
	   this.departamento = departamento;
	   this.ciudad = ciudad;
	   this.siProduceLeche = siProduceLeche;
	   this.siProduceCereales = siProduceCereales;
	   this.siProduceFrutas = siProduceFrutas;
	   this.siProduceVerduras = siProduceVerduras;
	}

    // ANTES DE PONER EL ID TOCA HACER LA BUSQUEDA DE ID DE CADA UNO Y PODER ASI CREAR EL OBJETO
    // CONTRUCTOR PARA CREAR UNA NUEVA FINCA
    public Finca(String nombre, float numHectareas, float metrosCuadrados,
                 int propietarioId, int capatazId, int vendedorId, String pais, String departamento,
                 String ciudad, boolean siProduceLeche, boolean siProduceCereales,
                 boolean siProduceFrutas, boolean siProduceVerduras) {
    	Random random = new Random();
    	int number = 100000 + random.nextInt(900000);
        this.codigoFinca = String.valueOf(number);
        this.nombre = nombre;
        this.numHectareas = numHectareas;
        this.metrosCuadrados = metrosCuadrados;
        this.propietarioId = propietarioId;
        this.capatazId = capatazId;
        this.vendedorId = vendedorId;
        this.pais = pais;
        this.departamento = departamento;
        this.ciudad = ciudad;
        this.siProduceLeche = siProduceLeche;
        this.siProduceCereales = siProduceCereales;
        this.siProduceFrutas = siProduceFrutas;
        this.siProduceVerduras = siProduceVerduras;
    }

    public int getIdFinca() {
        return idFinca;
    }


    public String getCodigoFinca() {
        return codigoFinca;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public float getNumHectareas() {
        return numHectareas;
    }

    public void setNumHectareas(int numHectareas) {
        this.numHectareas = numHectareas;
    }

    public float getMetrosCuadrados() {
        return metrosCuadrados;
    }

    public void setMetrosCuadrados(float metrosCuadrados) {
        this.metrosCuadrados = metrosCuadrados;
    }

    public int getPropietarioId() {
        return propietarioId;
    }

    public void setPropietarioId(int propietarioId) {
        this.propietarioId = propietarioId;
    }

    public int getCapatazId() {
        return capatazId;
    }

    public void setCapatazId(int capatazId) {
        this.capatazId = capatazId;
    }

    public int getVendedorId() {
        return vendedorId;
    }

    public void setVendedorId(int vendedorId) {
        this.vendedorId = vendedorId;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public boolean isSiProduceLeche() {
        return siProduceLeche;
    }

    public void setSiProduceLeche(boolean siProduceLeche) {
        this.siProduceLeche = siProduceLeche;
    }

    public boolean isSiProduceCereales() {
        return siProduceCereales;
    }

    public void setSiProduceCereales(boolean siProduceCereales) {
        this.siProduceCereales = siProduceCereales;
    }

    public boolean isSiProduceFrutas() {
        return siProduceFrutas;
    }

    public void setSiProduceFrutas(boolean siProduceFrutas) {
        this.siProduceFrutas = siProduceFrutas;
    }

    public boolean isSiProduceVerduras() {
        return siProduceVerduras;
    }

    public void setSiProduceVerduras(boolean siProduceVerduras) {
        this.siProduceVerduras = siProduceVerduras;
    }
    
    public String getCodigo_propietario() {
		return codigo_propietario;
	}

	public void setCodigo_propietario(String codigo_propietario) {
		this.codigo_propietario = codigo_propietario;
	}

	public String getCodigo_capataz() {
		return codigo_capataz;
	}

	public void setCodigo_capataz(String codigo_capataz) {
		this.codigo_capataz = codigo_capataz;
	}

	public String getCodigo_vendedor() {
		return codigo_vendedor;
	}

	public void setCodigo_vendedor(String codigo_vendedor) {
		this.codigo_vendedor = codigo_vendedor;
	}

	@Override
    public String toString() {
        return "Finca{" +
                ", codigoFinca='" + codigoFinca + '\'' +
                ", nombre='" + nombre + '\'' +
                ", numHectareas=" + numHectareas +
                ", metrosCuadrados=" + metrosCuadrados +
                ", propietarioId=" + propietarioId +
                ", capatazId=" + capatazId +
                ", vendedorId=" + vendedorId +
                ", pais='" + pais + '\'' +
                ", departamento='" + departamento + '\'' +
                ", ciudad='" + ciudad + '\'' +
                ", siProduceLeche=" + siProduceLeche +
                ", siProduceCereales=" + siProduceCereales +
                ", siProduceFrutas=" + siProduceFrutas +
                ", siProduceVerduras=" + siProduceVerduras +
                '}';
    }
	
	

}


