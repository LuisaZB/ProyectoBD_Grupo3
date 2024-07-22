
package com.proyectoHotel.dao;

import com.proyectoHotel.domain.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;


public interface ClienteDao extends JpaRepository<Cliente, Long> {
}
