package com.proyectoHotel.dao;

import com.proyectoHotel.domain.TipoHabitacion;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface TipoHabitacionDao extends JpaRepository<TipoHabitacion, Long> {
    List<TipoHabitacion> findByNombreContainingIgnoreCase(String nombre);
}
