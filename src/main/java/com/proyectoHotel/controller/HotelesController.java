package com.proyectoHotel.controller;

import com.proyectoHotel.dao.HotelDao;
import com.proyectoHotel.domain.Hotel;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Optional;

@Controller
@RequestMapping("/hoteles")
public class HotelesController {

    @Autowired
    private HotelDao hotelDao;

    @GetMapping
    public String listarHoteles(Model model) {
        model.addAttribute("hoteles", hotelDao.findAll());
        return "hoteles";
    }

    @GetMapping("/editar/{idHotel}")
    public String editarHotel(@PathVariable("idHotel") Long idHotel, Model model) {
        Optional<Hotel> hotel = hotelDao.findById(idHotel);
        if (hotel.isPresent()) {
            model.addAttribute("hotel", hotel.get());
        }
        model.addAttribute("hoteles", hotelDao.findAll());
        return "hoteles";
    }

    @PostMapping("/guardar")
    public String guardarHotel(Hotel hotel) {
        hotelDao.save(hotel);
        return "redirect:/hoteles";
    }

    @GetMapping("/eliminar/{idHotel}")
    public String eliminarHotel(@PathVariable("idHotel") Long idHotel) {
        hotelDao.deleteById(idHotel);
        return "redirect:/hoteles";
    }

    @GetMapping("/buscar")
    public String buscarHoteles(Long query, Model model) {
        if (query != null) {
            Optional<Hotel> hotel = hotelDao.findById(query);
            if (hotel.isPresent()) {
                model.addAttribute("hoteles", List.of(hotel.get()));
            } else {
                model.addAttribute("hoteles", List.of());
            }
        } else {
            model.addAttribute("hoteles", hotelDao.findAll());
        }
        return "hoteles";
    }
}
