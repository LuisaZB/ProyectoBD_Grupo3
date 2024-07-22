
package com.proyectoHotel.dao;

import com.proyectoHotel.domain.Reservacion;
import org.springframework.data.jpa.repository.JpaRepository;


public interface ReservacionDao extends JpaRepository<Reservacion, Long> {
}
