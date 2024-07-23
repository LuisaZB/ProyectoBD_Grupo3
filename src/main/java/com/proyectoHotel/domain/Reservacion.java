
package com.proyectoHotel.domain;

import jakarta.persistence.*;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "Reservaciones")
public class Reservacion {
    @Id
    @Column(name = "ID_Reservacion")
    private Long idReservacion;

    @ManyToOne
    @JoinColumn(name = "ID_Hotel", nullable = false)
    private Hotel hotel;

    @ManyToOne
    @JoinColumn(name = "ID_Cliente", nullable = false)
    private Cliente cliente;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "Fecha_inicio")
    private Date fechaInicio;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "Fecha_fin")
    private Date fechaFin;

    @Column(name = "Habitacion_asignada")
    private String habitacionAsignada;

    
    
    public Long getIdReservacion() {
        return idReservacion;
    }

    public void setIdReservacion(Long idReservacion) {
        this.idReservacion = idReservacion;
    }

    public Hotel getHotel() {
        return hotel;
    }

    public void setHotel(Hotel hotel) {
        this.hotel = hotel;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    public String getHabitacionAsignada() {
        return habitacionAsignada;
    }

    public void setHabitacionAsignada(String habitacionAsignada) {
        this.habitacionAsignada = habitacionAsignada;
    }
}