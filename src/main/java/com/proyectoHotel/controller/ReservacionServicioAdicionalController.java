package com.proyectoHotel.controller;

import com.proyectoHotel.dao.ReservacionServicioAdicionalDao;
import com.proyectoHotel.dao.ServicioAdicionalDao;
import com.proyectoHotel.dao.ReservacionDao;
import com.proyectoHotel.domain.ReservacionServicioAdicional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/reservacionesServiciosAdicionales")
public class ReservacionServicioAdicionalController {

    @Autowired
    private ReservacionServicioAdicionalDao reservacionServicioAdicionalDao;

    @Autowired
    private ServicioAdicionalDao servicioAdicionalDao;

    @Autowired
    private ReservacionDao reservacionDao;

    @GetMapping
    public String listarReservacionesServiciosAdicionales(Model model) {
        model.addAttribute("reservacionesServiciosAdicionales", reservacionServicioAdicionalDao.findAll());
        model.addAttribute("serviciosAdicionales", servicioAdicionalDao.findAll());
        model.addAttribute("reservaciones", reservacionDao.findAll());
        return "reservacionesServiciosAdicionales";
    }

    @GetMapping("/editar/{idReservacionServicioAdicional}")
    public String editarReservacionServicioAdicional(@PathVariable("idReservacionServicioAdicional") Long idReservacionServicioAdicional, Model model) {
        Optional<ReservacionServicioAdicional> reservacionServicioAdicional = reservacionServicioAdicionalDao.findById(idReservacionServicioAdicional);
        reservacionServicioAdicional.ifPresent(value -> model.addAttribute("reservacionServicioAdicional", value));
        model.addAttribute("serviciosAdicionales", servicioAdicionalDao.findAll());
        model.addAttribute("reservaciones", reservacionDao.findAll());
        return "editarReservacionServicioAdicional";
    }

    @PostMapping("/guardar")
    public String guardarReservacionServicioAdicional(ReservacionServicioAdicional reservacionServicioAdicional) {
        reservacionServicioAdicionalDao.save(reservacionServicioAdicional);
        return "redirect:/reservacionesServiciosAdicionales";
    }

    @GetMapping("/eliminar/{idReservacionServicioAdicional}")
    public String eliminarReservacionServicioAdicional(@PathVariable("idReservacionServicioAdicional") Long idReservacionServicioAdicional) {
        reservacionServicioAdicionalDao.deleteById(idReservacionServicioAdicional);
        return "redirect:/reservacionesServiciosAdicionales";
    }

    @GetMapping("/buscar")
    public String buscarReservacionServiciosAdicionales(@RequestParam("query") String query, Model model) {
        List<ReservacionServicioAdicional> resultados = reservacionServicioAdicionalDao.findByDescripcionContainingIgnoreCase(query);
        model.addAttribute("reservacionesServiciosAdicionales", resultados);
        model.addAttribute("serviciosAdicionales", servicioAdicionalDao.findAll());
        model.addAttribute("reservaciones", reservacionDao.findAll());
        return "reservacionesServiciosAdicionales";
    }
}
