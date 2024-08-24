package com.proyectoHotel.dao;

import com.proyectoHotel.domain.Reservacion;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservacionDao extends JpaRepository<Reservacion, Long> {

    List<Reservacion> findByHabitacionAsignadaContainingIgnoreCase(String habitacionAsignada);
}
