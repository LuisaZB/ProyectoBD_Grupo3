package com.proyectoHotel.controller;

import com.proyectoHotel.dao.HistorialReservacionesDao;
import com.proyectoHotel.dao.ReservacionDao;
import com.proyectoHotel.domain.HistorialReservaciones;
import com.proyectoHotel.domain.Reservacion;
import java.sql.Timestamp;
import java.util.Collections;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.Optional;

@Controller
@RequestMapping("/historialReservaciones")
public class HistorialReservacionesController {

    @Autowired
    private HistorialReservacionesDao historialDao;

    @Autowired
    private ReservacionDao reservacionDao;

    // Método para mostrar la lista de historiales
    @GetMapping
    public String listarHistoriales(Model model) {
        List<HistorialReservaciones> historiales = historialDao.findAll();
        model.addAttribute("historiales", historiales);
        return "historialReservaciones";
    }

    // Método para mostrar el formulario de agregar
    @GetMapping("/agregar")
    public String mostrarFormularioAgregar(Model model) {
        model.addAttribute("historial", new HistorialReservaciones());
        model.addAttribute("reservaciones", reservacionDao.findAll());
        return "historialReservaciones";
    }

    // Método para agregar un historial
    @PostMapping("/agregar")
    public String agregarHistorial(@ModelAttribute HistorialReservaciones historial) {
        historialDao.save(historial);
        return "redirect:/historialReservaciones";
    }

    // Método para mostrar el formulario de editar
    @GetMapping("/modificar/{id}")
    public String mostrarFormularioEditar(@PathVariable Long id, Model model) {
        Optional<HistorialReservaciones> historial = historialDao.findById(id);
        if (historial.isPresent()) {
            model.addAttribute("historial", historial.get());
            model.addAttribute("reservaciones", reservacionDao.findAll());
            return "historialReservaciones";
        } else {
            return "redirect:/historialReservaciones";
        }
    }

    // Método para editar un historial
    @PostMapping("/modificar")
    public String editarHistorial(@ModelAttribute HistorialReservaciones historial) {
        historialDao.save(historial);
        return "redirect:/historialReservaciones";
    }

    // Método para eliminar un historial
    @GetMapping("/eliminar/{id}")
    public String eliminarHistorial(@PathVariable Long id) {
        historialDao.deleteById(id);
        return "redirect:/historialReservaciones";
    }


    // Método para buscar o filtrar por ID
    @GetMapping("/buscar")
    public String buscarHistorial(@RequestParam("query") Long idHistorial, Model model) {
        Optional<HistorialReservaciones> historial = historialDao.findByIdHistorial(idHistorial);
        if (historial.isPresent()) {
            model.addAttribute("historiales", List.of(historial.get()));
        } else {
            model.addAttribute("historiales", Collections.emptyList());
        }
        return "historialReservaciones";
    }
}
