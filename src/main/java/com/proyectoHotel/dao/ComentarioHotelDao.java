package com.proyectoHotel.dao;

import com.proyectoHotel.domain.ComentarioHotel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ComentarioHotelDao extends JpaRepository<ComentarioHotel, Long> {
}
