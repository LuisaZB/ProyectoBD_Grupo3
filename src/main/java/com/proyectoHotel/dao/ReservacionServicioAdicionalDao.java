package com.proyectoHotel.dao;

import com.proyectoHotel.domain.ReservacionServicioAdicional;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservacionServicioAdicionalDao extends JpaRepository<ReservacionServicioAdicional, Long> {
    List<ReservacionServicioAdicional> findByDescripcionContainingIgnoreCase(String descripcion);
}
