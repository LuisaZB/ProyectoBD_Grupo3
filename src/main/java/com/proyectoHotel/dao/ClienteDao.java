package com.proyectoHotel.dao;

import com.proyectoHotel.domain.Cliente;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClienteDao extends JpaRepository<Cliente, Long> {

    Optional<Cliente> findByCorreoElectronico(String correoElectronico);

    List<Cliente> findByCorreoElectronicoContainingIgnoreCase(String correoElectronico);
}
