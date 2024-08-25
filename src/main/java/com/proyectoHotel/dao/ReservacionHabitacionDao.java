package com.proyectoHotel.dao;

import com.proyectoHotel.domain.ReservacionHabitacion;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservacionHabitacionDao extends JpaRepository<ReservacionHabitacion, Long> {
    List<ReservacionHabitacion> findByHabitacionAsignadaContainingIgnoreCase(String habitacionAsignada);
}
