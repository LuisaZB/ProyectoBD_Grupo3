package com.proyectoHotel.controller;

import com.proyectoHotel.dao.ServicioAdicionalDao;
import com.proyectoHotel.domain.ServicioAdicional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/serviciosAdicionales")
public class ServicioAdicionalController {

    @Autowired
    private ServicioAdicionalDao servicioAdicionalDao;

    @GetMapping
    public String listarServiciosAdicionales(Model model) {
        model.addAttribute("serviciosAdicionales", servicioAdicionalDao.findAll());
        return "serviciosAdicionales";
    }

    @GetMapping("/editar/{idServicioAdicional}")
    public String editarServicioAdicional(@PathVariable("idServicioAdicional") Long idServicioAdicional, Model model) {
        Optional<ServicioAdicional> servicioAdicional = servicioAdicionalDao.findById(idServicioAdicional);
        servicioAdicional.ifPresent(value -> model.addAttribute("servicioAdicional", value));
        return "editarServicioAdicional";
    }

    @PostMapping("/guardar")
    public String guardarServicioAdicional(ServicioAdicional servicioAdicional) {
        servicioAdicionalDao.save(servicioAdicional);
        return "redirect:/serviciosAdicionales";
    }

    @GetMapping("/eliminar/{idServicioAdicional}")
    public String eliminarServicioAdicional(@PathVariable("idServicioAdicional") Long idServicioAdicional) {
        servicioAdicionalDao.deleteById(idServicioAdicional);
        return "redirect:/serviciosAdicionales";
    }

    @GetMapping("/buscar")
    public String buscarServiciosAdicionales(@RequestParam("query") String query, Model model) {
        List<ServicioAdicional> resultados = servicioAdicionalDao.findByNombreContainingIgnoreCase(query);
        model.addAttribute("serviciosAdicionales", resultados);
        return "serviciosAdicionales";
    }
}
