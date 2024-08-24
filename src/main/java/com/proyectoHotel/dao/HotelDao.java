package com.proyectoHotel.dao;

import com.proyectoHotel.domain.Hotel;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HotelDao extends JpaRepository<Hotel, Long> {

    List<Hotel> findByNombreContainingIgnoreCase(String nombre);
}
