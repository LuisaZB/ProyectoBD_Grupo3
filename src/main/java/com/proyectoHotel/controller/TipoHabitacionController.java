package com.proyectoHotel.controller;

import com.proyectoHotel.dao.TipoHabitacionDao;
import com.proyectoHotel.domain.TipoHabitacion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/tiposHabitacion")
public class TipoHabitacionController {

    @Autowired
    private TipoHabitacionDao tipoHabitacionDao;

    @GetMapping
    public String listarTiposHabitacion(Model model) {
        model.addAttribute("tiposHabitacion", tipoHabitacionDao.findAll());
        return "tiposHabitacion";
    }

    @GetMapping("/editar/{idTipoHabitacion}")
    public String editarTipoHabitacion(@PathVariable("idTipoHabitacion") Long idTipoHabitacion, Model model) {
        Optional<TipoHabitacion> tipoHabitacion = tipoHabitacionDao.findById(idTipoHabitacion);
        tipoHabitacion.ifPresent(value -> model.addAttribute("tipoHabitacion", value));
        return "editarTipoHabitacion";
    }

    @PostMapping("/guardar")
    public String guardarTipoHabitacion(TipoHabitacion tipoHabitacion) {
        tipoHabitacionDao.save(tipoHabitacion);
        return "redirect:/tiposHabitacion";
    }

    @GetMapping("/eliminar/{idTipoHabitacion}")
    public String eliminarTipoHabitacion(@PathVariable("idTipoHabitacion") Long idTipoHabitacion) {
        tipoHabitacionDao.deleteById(idTipoHabitacion);
        return "redirect:/tiposHabitacion";
    }

    @GetMapping("/buscar")
    public String buscarTiposHabitacion(@RequestParam("query") String query, Model model) {
        List<TipoHabitacion> resultados = tipoHabitacionDao.findByNombreContainingIgnoreCase(query);
        model.addAttribute("tiposHabitacion", resultados);
        return "tiposHabitacion";
    }
}
