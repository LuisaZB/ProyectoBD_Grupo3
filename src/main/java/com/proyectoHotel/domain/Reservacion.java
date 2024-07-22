
package com.proyectoHotel.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.util.Date;
import nonapi.io.github.classgraph.json.Id;


@Entity
@Table(name = "Reservaciones")
public class Reservacion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "ID_Hotel", nullable = false)
    private Hotel hotel;

    @ManyToOne
    @JoinColumn(name = "ID_Cliente", nullable = false)
    private Cliente cliente;

    @Column(name = "Fecha_inicio")
    private Date fechaInicio;

    @Column(name = "Fecha_fin")
    private Date fechaFin;

    @Column(name = "Habitacion_asignada")
    private String habitacionAsignada;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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