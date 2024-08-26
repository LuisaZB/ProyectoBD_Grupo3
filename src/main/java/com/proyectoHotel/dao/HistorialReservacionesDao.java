
package com.proyectoHotel.dao;

import com.proyectoHotel.domain.HistorialReservaciones;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface HistorialReservacionesDao extends JpaRepository<HistorialReservaciones, Long> {
    Optional<HistorialReservaciones> findByIdHistorial(Long idHistorial);
}

