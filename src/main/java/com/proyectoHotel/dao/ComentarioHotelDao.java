package com.proyectoHotel.dao;

import com.proyectoHotel.domain.ComentarioHotel;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ComentarioHotelDao extends JpaRepository<ComentarioHotel, Long> {
    List<ComentarioHotel> findByHotel_NombreContaining(String query);
}
