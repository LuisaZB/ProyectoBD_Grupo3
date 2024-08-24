package com.proyectoHotel.dao;

import com.proyectoHotel.domain.ReservacionRestaurante;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservacionRestauranteDao extends JpaRepository<ReservacionRestaurante, Long> {

    List<ReservacionRestaurante> findByIdReservacionRestaurante(Long id);

}
