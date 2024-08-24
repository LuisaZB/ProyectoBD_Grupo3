package com.proyectoHotel.controller;

import com.proyectoHotel.dao.ReservacionRestauranteDao;
import com.proyectoHotel.dao.ReservacionDao;
import com.proyectoHotel.domain.ReservacionRestaurante;
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
@RequestMapping("/reservacionesRestaurantes")
public class ReservacionesRestaurantesController {

    @Autowired
    private ReservacionRestauranteDao reservacionRestauranteDao;

    @Autowired
    private ReservacionDao reservacionDao;

    @GetMapping
    public String listarReservacionesRestaurantes(Model model) {
        model.addAttribute("reservacionesRestaurantes", reservacionRestauranteDao.findAll());
        model.addAttribute("reservaciones", reservacionDao.findAll());
        return "reservacionesRestaurantes";
    }

    @GetMapping("/editar/{idReservacionRestaurante}")
    public String editarReservacionRestaurante(@PathVariable Long idReservacionRestaurante, Model model) {
        Optional<ReservacionRestaurante> reservacionRestaurante = reservacionRestauranteDao.findById(idReservacionRestaurante);
        if (reservacionRestaurante.isPresent()) {
            model.addAttribute("reservacionRestaurante", reservacionRestaurante.get());
            model.addAttribute("reservaciones", reservacionDao.findAll());
            return "reservacionesRestaurantes";
        } else {
            return "redirect:/reservacionesRestaurantes";
        }
    }

    @PostMapping("/guardar")
    public String guardarReservacionRestaurante(ReservacionRestaurante reservacionRestaurante) {
        reservacionRestauranteDao.save(reservacionRestaurante);
        return "redirect:/reservacionesRestaurantes";
    }

    @GetMapping("/eliminar/{idReservacionRestaurante}")
    public String eliminarReservacionRestaurante(@PathVariable Long idReservacionRestaurante) {
        reservacionRestauranteDao.deleteById(idReservacionRestaurante);
        return "redirect:/reservacionesRestaurantes";
    }

    @GetMapping("/buscar")
    public String buscarReservacionesRestaurantes(@RequestParam("query") String query, Model model) {
        List<ReservacionRestaurante> reservacionesRestaurantes = new ArrayList<>();
        try {
            Long id = Long.valueOf(query);
            reservacionesRestaurantes = reservacionRestauranteDao.findByIdReservacionRestaurante(id);
        } catch (NumberFormatException e) {
            model.addAttribute("error", "ID inválido.");
        }
        model.addAttribute("reservacionesRestaurantes", reservacionesRestaurantes);
        model.addAttribute("reservaciones", reservacionDao.findAll());
        return "reservacionesRestaurantes";
    }

}
