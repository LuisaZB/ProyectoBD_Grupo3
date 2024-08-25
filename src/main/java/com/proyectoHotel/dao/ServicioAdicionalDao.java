package com.proyectoHotel.dao;

import com.proyectoHotel.domain.ServicioAdicional;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ServicioAdicionalDao extends JpaRepository<ServicioAdicional, Long> {
    List<ServicioAdicional> findByNombreContainingIgnoreCase(String nombre);
}
