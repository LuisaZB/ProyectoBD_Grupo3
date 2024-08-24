package com.proyectoHotel.domain;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "Reservaciones_Restaurantes")
public class ReservacionRestaurante implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_reservaciones_restaurantes")
    @SequenceGenerator(name = "seq_reservaciones_restaurantes", sequenceName = "seq_Reservaciones_Restaurantes", allocationSize = 1)
    @Column(name = "ID_Reservacion_Restaurante")
    private Long idReservacionRestaurante;

    @ManyToOne
    @JoinColumn(name = "ID_Reservacion", nullable = false)
    private Reservacion reservacion;

    @Column(name = "Fecha")
    private java.sql.Date fecha;

    @Column(name = "Hora")
    private String hora;

    @Column(name = "Numero_de_personas")
    private Integer numeroDePersonas;

    public Long getIdReservacionRestaurante() {
        return idReservacionRestaurante;
    }

    public void setIdReservacionRestaurante(Long idReservacionRestaurante) {
        this.idReservacionRestaurante = idReservacionRestaurante;
    }

    public Reservacion getReservacion() {
        return reservacion;
    }

    public void setReservacion(Reservacion reservacion) {
        this.reservacion = reservacion;
    }

    public java.sql.Date getFecha() {
        return fecha;
    }

    public void setFecha(java.sql.Date fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public Integer getNumeroDePersonas() {
        return numeroDePersonas;
    }

    public void setNumeroDePersonas(Integer numeroDePersonas) {
        this.numeroDePersonas = numeroDePersonas;
    }
}
