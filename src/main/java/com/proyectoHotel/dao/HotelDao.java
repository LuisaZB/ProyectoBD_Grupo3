
package com.proyectoHotel.dao;

import com.proyectoHotel.domain.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;



public interface HotelDao extends JpaRepository<Hotel, Long> {
}
