package com.proyectoHotel.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

@Data
@Entity
@Table(name = "Reservaciones_Servicios_Adicionales")
public class ReservacionServicioAdicional implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_Reservacion_Servicio_Adicional")
    private Long idReservacionServicioAdicional;

    @ManyToOne
    @JoinColumn(name = "ID_Reservacion", nullable = false)
    private Reservacion reservacion;

    @ManyToOne
    @JoinColumn(name = "ID_Servicio_Adicional", nullable = false)
    private ServicioAdicional servicioAdicional;

    @Column(name = "Fecha_Servicio", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date fechaServicio;

    
    public Long getIdReservacionServicioAdicional() {
        return idReservacionServicioAdicional;
    }

    public void setIdReservacionServicioAdicional(Long idReservacionServicioAdicional) {
        this.idReservacionServicioAdicional = idReservacionServicioAdicional;
    }

    public Reservacion getReservacion() {
        return reservacion;
    }

    public void setReservacion(Reservacion reservacion) {
        this.reservacion = reservacion;
    }

    public ServicioAdicional getServicioAdicional() {
        return servicioAdicional;
    }

    public void setServicioAdicional(ServicioAdicional servicioAdicional) {
        this.servicioAdicional = servicioAdicional;
    }

    public Date getFechaServicio() {
        return fechaServicio;
    }

    public void setFechaServicio(Date fechaServicio) {
        this.fechaServicio = fechaServicio;
    }
}
