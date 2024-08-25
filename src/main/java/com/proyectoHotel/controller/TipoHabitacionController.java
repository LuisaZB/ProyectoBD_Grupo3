package com.proyectoHotel.controller;

import com.proyectoHotel.dao.TipoHabitacionDao;
import com.proyectoHotel.domain.TipoHabitacion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class TipoHabitacionController {

    @Autowired
    private TipoHabitacionDao tipoHabitacionDao;

    @GetMapping("/tiposHabitacion")
    public String listarTiposHabitacion(Model model) {
        List<TipoHabitacion> tipos = tipoHabitacionDao.findAll();
        model.addAttribute("tipos", tipos);
        return "tiposHabitacion";
    }

    @GetMapping("/buscarTipoHabitacion")
    public String buscarTipoHabitacion(String nombre, Model model) {
        List<TipoHabitacion> tipos = tipoHabitacionDao.findByNombreContainingIgnoreCase(nombre);
        model.addAttribute("tipos", tipos);
        return "tiposHabitacion";
    }
}
