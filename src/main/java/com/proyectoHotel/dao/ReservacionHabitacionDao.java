package com.proyectoHotel.dao;

import com.proyectoHotel.domain.ReservacionHabitacion;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservacionHabitacionDao extends JpaRepository<ReservacionHabitacion, Long> {
    
}
