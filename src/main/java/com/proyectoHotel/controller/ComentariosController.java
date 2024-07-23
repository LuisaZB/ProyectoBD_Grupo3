package com.proyectoHotel.controller;

import com.proyectoHotel.dao.ComentarioHotelDao;
import com.proyectoHotel.dao.HotelDao;
import com.proyectoHotel.dao.ClienteDao;
import com.proyectoHotel.domain.ComentarioHotel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ComentariosController {

    @Autowired
    private ComentarioHotelDao comentarioHotelDao;

    @Autowired
    private HotelDao hotelDao;

    @Autowired
    private ClienteDao clienteDao;

    @RequestMapping("/comentarios")
    public String page(Model model) {
        model.addAttribute("comentarios", comentarioHotelDao.findAll());
        model.addAttribute("hoteles", hotelDao.findAll());
        model.addAttribute("clientes", clienteDao.findAll());
        return "comentarios";
    }

    @PostMapping("/comentarios/guardar")
    public String guardarComentario(ComentarioHotel comentarioHotel) {
        comentarioHotelDao.save(comentarioHotel);
        return "redirect:/comentarios";
    }
}
