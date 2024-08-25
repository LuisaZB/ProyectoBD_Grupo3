package com.proyectoHotel.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

@Data
@Entity
@Table(name = "Reservaciones_Habitaciones")
public class ReservacionHabitacion implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_Reservacion_Habitacion")
    private Long idReservacionHabitacion;

    @ManyToOne
    @JoinColumn(name = "ID_Reservacion", nullable = false)
    private Reservacion reservacion;

    @ManyToOne
    @JoinColumn(name = "ID_Tipo_Habitacion", nullable = false)
    private TipoHabitacion tipoHabitacion;

    @Column(name = "Fecha_Reservacion", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date fechaReservacion;

   
    public Long getIdReservacionHabitacion() {
        return idReservacionHabitacion;
    }

    public void setIdReservacionHabitacion(Long idReservacionHabitacion) {
        this.idReservacionHabitacion = idReservacionHabitacion;
    }

    public Reservacion getReservacion() {
        return reservacion;
    }

    public void setReservacion(Reservacion reservacion) {
        this.reservacion = reservacion;
    }

    public TipoHabitacion getTipoHabitacion() {
        return tipoHabitacion;
    }

    public void setTipoHabitacion(TipoHabitacion tipoHabitacion) {
        this.tipoHabitacion = tipoHabitacion;
    }

    public Date getFechaReservacion() {
        return fechaReservacion;
    }

    public void setFechaReservacion(Date fechaReservacion) {
        this.fechaReservacion = fechaReservacion;
    }
}
