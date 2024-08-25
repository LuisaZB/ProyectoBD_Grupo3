package com.proyectoHotel.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;

@Data
@Entity
@Table(name = "Servicios_Adicionales")
public class ServicioAdicional implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_Servicio_Adicional")
    private Long idServicioAdicional;

    @Column(name = "Nombre_Servicio", nullable = false)
    private String nombreServicio;

    @Column(name = "Descripcion")
    private String descripcion;

    @Column(name = "Precio", nullable = false)
    private Double precio;

    
    public Long getIdServicioAdicional() {
        return idServicioAdicional;
    }

    public void setIdServicioAdicional(Long idServicioAdicional) {
        this.idServicioAdicional = idServicioAdicional;
    }

    public String getNombreServicio() {
        return nombreServicio;
    }

    public void setNombreServicio(String nombreServicio) {
        this.nombreServicio = nombreServicio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Double getPrecio() {
        return precio;
    }

    public void setPrecio(Double precio) {
        this.precio = precio;
    }
}
