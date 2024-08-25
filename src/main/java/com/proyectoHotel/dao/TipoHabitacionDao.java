package com.proyectoHotel.dao;

import com.proyectoHotel.domain.TipoHabitacion;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TipoHabitacionDao extends JpaRepository<TipoHabitacion, Long> {
    List<TipoHabitacion> findByNombreContainingIgnoreCase(String nombre);
}
