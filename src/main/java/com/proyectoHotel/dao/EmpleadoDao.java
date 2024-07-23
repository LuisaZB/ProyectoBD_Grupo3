package com.proyectoHotel.dao;

import com.proyectoHotel.domain.Empleado;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmpleadoDao extends JpaRepository<Empleado, Long>  {
    
}
