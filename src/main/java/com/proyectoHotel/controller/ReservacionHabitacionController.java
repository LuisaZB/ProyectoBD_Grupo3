package com.proyectoHotel.controller;

import com.proyectoHotel.dao.ReservacionHabitacionDao;
import com.proyectoHotel.dao.ClienteDao;
import com.proyectoHotel.dao.HotelDao;
import com.proyectoHotel.domain.ReservacionHabitacion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
@RequestMapping("/reservacionesHabitacion")
public class ReservacionHabitacionController {

    @Autowired
    private ReservacionHabitacionDao reservacionHabitacionDao;

    @Autowired
    private ClienteDao clienteDao;

    @Autowired
    private HotelDao hotelDao;

    @GetMapping
    public String listarReservacionesHabitacion(Model model) {
        model.addAttribute("reservacionesHabitacion", reservacionHabitacionDao.findAll());
        model.addAttribute("clientes", clienteDao.findAll());
        model.addAttribute("hoteles", hotelDao.findAll());
        return "reservacionesHabitacion";
    }

    @GetMapping("/editar/{idReservacionHabitacion}")
    public String editarReservacionHabitacion(@PathVariable("idReservacionHabitacion") Long idReservacionHabitacion, Model model) {
        Optional<ReservacionHabitacion> reservacionHabitacion = reservacionHabitacionDao.findById(idReservacionHabitacion);
        reservacionHabitacion.ifPresent(value -> model.addAttribute("reservacionHabitacion", value));
        model.addAttribute("clientes", clienteDao.findAll());
        model.addAttribute("hoteles", hotelDao.findAll());
        return "editarReservacionHabitacion";
    }

    @PostMapping("/guardar")
    public String guardarReservacionHabitacion(ReservacionHabitacion reservacionHabitacion) {
        reservacionHabitacionDao.save(reservacionHabitacion);
        return "redirect:/reservacionesHabitacion";
    }

    @GetMapping("/eliminar/{idReservacionHabitacion}")
    public String eliminarReservacionHabitacion(@PathVariable("idReservacionHabitacion") Long idReservacionHabitacion) {
        reservacionHabitacionDao.deleteById(idReservacionHabitacion);
        return "redirect:/reservacionesHabitacion";
    }

    
    @GetMapping("/buscar")
    public String buscarReservacionHabitacion(@RequestParam("query") String query, Model model) {
        model.addAttribute("reservacionesHabitacion", reservacionHabitacionDao.findAll());
        return "reservacionesHabitacion";
    }
}
