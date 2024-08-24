package com.proyectoHotel.controller;

import com.proyectoHotel.dao.EmpleadoDao;
import com.proyectoHotel.dao.HotelDao;
import com.proyectoHotel.domain.Empleado;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/empleados")
public class EmpleadosController {

    @Autowired
    private EmpleadoDao empleadoDao;

    @Autowired
    private HotelDao hotelDao;

    @GetMapping
    public String page(Model model) {
        model.addAttribute("empleados", empleadoDao.findAll());
        model.addAttribute("hoteles", hotelDao.findAll());
        return "empleados";
    }

    @PostMapping("/guardar")
    public String guardarEmpleado(Empleado empleado) {
        empleadoDao.save(empleado);
        return "redirect:/empleados";
    }
}
