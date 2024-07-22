package com.proyectoHotel.controller;

import com.proyectoHotel.dao.ClienteDao;
import com.proyectoHotel.domain.Cliente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/clientes")
public class ClientesController {
    
    @RequestMapping("/clientes")
    public String page(Model model) {
        model.addAttribute("attribute", "value");
        return "clientes";
    }
    
     @Autowired
    private ClienteDao clientedao;

    @GetMapping
    public String listarClientes(Model model) {
        model.addAttribute("clientes", clientedao.findAll());
        return "clientes";
    }

    @PostMapping("/guardar")
    public String guardarCliente(Cliente cliente) {
        clientedao.save(cliente);
        return "redirect:/clientes";
    }
    
}
