package com.proyectoHotel.controller;

import com.proyectoHotel.dao.ClienteDao;
import com.proyectoHotel.dao.HotelDao;
import com.proyectoHotel.dao.ReservacionDao;
import com.proyectoHotel.domain.Reservacion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reservaciones")
public class ReservacionesController {

    @Autowired
    private ReservacionDao reservaciondao;

    @Autowired
    private HotelDao hoteldao;

    @Autowired
    private ClienteDao clientedao;

    @GetMapping
    public String listarReservaciones(Model model) {
        model.addAttribute("reservaciones", reservaciondao.findAll());
        model.addAttribute("hoteles", hoteldao.findAll());
        model.addAttribute("clientes", clientedao.findAll());
        return "reservaciones";
    }

    @PostMapping("/guardar")
    public String guardarReservacion(Reservacion reservacion) {
        reservaciondao.save(reservacion);
        return "redirect:/reservaciones";
    }
}
