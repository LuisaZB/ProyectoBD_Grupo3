package com.proyectoHotel.domain;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Facturas")
public class Factura {

@Id
@Column(name = "ID_Factura")
private Long idFactura;

@ManyToOne
@JoinColumn(name = "ID_Reservacion", nullable = false)
private Reservacion reservacion;

@Column(name = "Fecha_emision")
private Date fechaEmision;

@Column(name = "Total")
private Double total;

public Long getIdFactura() {
    return idFactura;
}

public void setIdFactura(Long idFactura) {
    this.idFactura = idFactura;
}

public Reservacion getReservacion() {
    return reservacion;
}

public void setReservacion(Reservacion reservacion) {
    this.reservacion = reservacion;
}

public Date getFechaEmision() {
    return fechaEmision;
}

public void setFechaEmision(Date fechaEmision) {
    this.fechaEmision = fechaEmision;
}

public Double getTotal() {
    return total;
}

public void setTotal(Double total) {
    this.total = total;
}
}

