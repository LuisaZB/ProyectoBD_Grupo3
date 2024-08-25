package com.proyectoHotel.controller;

import com.proyectoHotel.dao.ServicioAdicionalDao;
import com.proyectoHotel.domain.ServicioAdicional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ServicioAdicionalController {

    @Autowired
    private ServicioAdicionalDao servicioAdicionalDao;

    @GetMapping("/serviciosAdicionales/buscar")
    public String buscar(@RequestParam("query") String query, Model model) {
        List<ServicioAdicional> serviciosAdicionales = servicioAdicionalDao.findByNombreContainingIgnoreCase(query);
        model.addAttribute("serviciosAdicionales", serviciosAdicionales);
        return "serviciosAdicionales/lista";
    }
}
