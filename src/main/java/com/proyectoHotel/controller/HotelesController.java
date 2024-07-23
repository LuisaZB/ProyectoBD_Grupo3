package com.proyectoHotel.controller;

import com.proyectoHotel.dao.HotelDao;
import com.proyectoHotel.domain.Hotel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/hoteles")
public class HotelesController {

    @Autowired
    private HotelDao hoteldao;

    @GetMapping
    public String listarHoteles(Model model) {
        model.addAttribute("hoteles", hoteldao.findAll());
        return "hoteles";
    }

    @PostMapping("/guardar")
    public String guardarHotel(Hotel hotel) {
        hoteldao.save(hotel);
        return "redirect:/hoteles";
    }
}
