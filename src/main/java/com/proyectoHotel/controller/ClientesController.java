package com.proyectoHotel.controller;

import com.proyectoHotel.dao.ClienteDao;
import com.proyectoHotel.domain.Cliente;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Optional;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/clientes")
public class ClientesController {

    @Autowired
    private ClienteDao clienteDao;

    @GetMapping
    public String listarClientes(Model model) {
        model.addAttribute("clientes", clienteDao.findAll());
        return "clientes";
    }

    @GetMapping("/editar/{idCliente}")
    public String editarCliente(@PathVariable("idCliente") Long idCliente, Model model) {
        Optional<Cliente> cliente = clienteDao.findById(idCliente);
        cliente.ifPresent(value -> model.addAttribute("cliente", value));
        model.addAttribute("clientes", clienteDao.findAll());
        return "clientes";
    }

    @PostMapping("/guardar")
    public String guardarCliente(Cliente cliente) {
        clienteDao.save(cliente);
        return "redirect:/clientes";
    }

    @GetMapping("/eliminar/{idCliente}")
    public String eliminarCliente(@PathVariable("idCliente") Long idCliente) {
        clienteDao.deleteById(idCliente);
        return "redirect:/clientes";
    }

    @GetMapping("/buscar")
    public String buscarClientes(@RequestParam("query") String query, Model model) {
        List<Cliente> resultados = new ArrayList<>();
        try {
            Long id = Long.valueOf(query);
            clienteDao.findById(id).ifPresent(resultados::add);
        } catch (NumberFormatException e) {

            clienteDao.findByCorreoElectronico(query).ifPresent(resultados::add);
            if (resultados.isEmpty()) {
                resultados = clienteDao.findByCorreoElectronicoContainingIgnoreCase(query);
            }
        }

        model.addAttribute("clientes", resultados);
        return "clientes";
    }
}
