package com.proyectoHotel.controller;

import com.proyectoHotel.dao.ClienteDao;
import com.proyectoHotel.dao.HotelDao;
import com.proyectoHotel.dao.ReservacionDao;
import com.proyectoHotel.domain.Reservacion;
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
@RequestMapping("/reservaciones")
public class ReservacionesController {

    @Autowired
    private ReservacionDao reservacionDao;

    @Autowired
    private HotelDao hotelDao;

    @Autowired
    private ClienteDao clienteDao;

    @GetMapping
    public String listarReservaciones(Model model) {
        model.addAttribute("reservaciones", reservacionDao.findAll());
        model.addAttribute("hoteles", hotelDao.findAll());
        model.addAttribute("clientes", clienteDao.findAll());
        return "reservaciones";
    }

    @GetMapping("/editar/{idReservacion}")
    public String editarReservacion(@PathVariable("idReservacion") Long idReservacion, Model model) {
        Optional<Reservacion> reservacion = reservacionDao.findById(idReservacion);
        if (reservacion.isPresent()) {
            model.addAttribute("reservacion", reservacion.get());
        }
        model.addAttribute("hoteles", hotelDao.findAll());
        model.addAttribute("clientes", clienteDao.findAll());
        return "reservaciones";
    }

    @PostMapping("/guardar")
    public String guardarReservacion(Reservacion reservacion) {
        reservacionDao.save(reservacion);
        return "redirect:/reservaciones";
    }

    @GetMapping("/eliminar/{idReservacion}")
    public String eliminarReservacion(@PathVariable("idReservacion") Long idReservacion) {
        reservacionDao.deleteById(idReservacion);
        return "redirect:/reservaciones";
    }

    @GetMapping("/buscar")
    public String buscarReservacion(@RequestParam("query") String query, Model model) {
        try {
            Long id = Long.valueOf(query);
            Optional<Reservacion> reservacion = reservacionDao.findById(id);
            if (reservacion.isPresent()) {
                model.addAttribute("reservaciones", List.of(reservacion.get()));
            } else {
                model.addAttribute("reservaciones", List.of());
            }
        } catch (NumberFormatException e) {
            List<Reservacion> reservaciones = reservacionDao.findByHabitacionAsignadaContainingIgnoreCase(query);
            model.addAttribute("reservaciones", reservaciones);
        }

        model.addAttribute("hoteles", hotelDao.findAll());
        model.addAttribute("clientes", clienteDao.findAll());
        return "reservaciones";
    }
}
