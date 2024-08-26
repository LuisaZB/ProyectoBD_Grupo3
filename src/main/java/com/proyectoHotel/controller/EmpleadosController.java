package com.proyectoHotel.controller;

import com.proyectoHotel.dao.EmpleadoDao;
import com.proyectoHotel.dao.HotelDao;
import com.proyectoHotel.domain.Empleado;
import com.proyectoHotel.domain.Hotel;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/empleados")
public class EmpleadosController {

    @Autowired
    private EmpleadoDao empleadoDao;

    @Autowired
    private HotelDao hotelDao;

    @GetMapping
    public String page(Model model) {
        model.addAttribute("empleados", empleadoDao.findAll());
        model.addAttribute("hoteles", hotelDao.findAll());
        return "empleados";
    }

    @PostMapping("/guardar")
    public String guardarEmpleado(@RequestParam("idHotel") Long idHotel, @ModelAttribute Empleado empleado) {
        Hotel hotel = hotelDao.findById(idHotel).orElse(null);
        if (hotel != null) {
            empleado.setHotel(hotel);
        } else {
            // Manejar el caso en que el hotel no exista
            return "redirect:/empleados?error=hotelNotFound";
        }
        empleadoDao.save(empleado);
        return "redirect:/empleados";
    }

    @GetMapping("/modificar/{id}")
    public String mostrarFormularioModificacion(@PathVariable("id") Long id, Model model) {
        Empleado empleado = empleadoDao.findById(id).orElse(null);
        if (empleado == null) {
            return "redirect:/empleados";
        }
        model.addAttribute("empleado", empleado);
        model.addAttribute("hoteles", hotelDao.findAll());
        return "empleados";
    }

    @PostMapping("/actualizar")
    public String actualizarEmpleado(@ModelAttribute Empleado empleado, @RequestParam("idHotel") Long idHotel) {
        Hotel hotel = hotelDao.findById(idHotel).orElse(null);
        if (hotel != null) {
            empleado.setHotel(hotel);
            empleadoDao.save(empleado);
            return "redirect:/empleados";
        } else {
            return "redirect:/empleados?error=hotelNotFound";
        }
    }

    
    @GetMapping("/eliminar/{id}")
    public String eliminarEmpleado(@PathVariable("id") Long id) {
        empleadoDao.deleteById(id);
        return "redirect:/empleados";
    }

    @GetMapping("/buscar")
    public String buscarEmpleado(@RequestParam("query") Long idEmpleado, Model model) {
        Empleado empleado = empleadoDao.findById(idEmpleado).orElse(null);
        model.addAttribute("empleados", empleado != null ? List.of(empleado) : List.of());
        model.addAttribute("hoteles", hotelDao.findAll());
        return "empleados";
    }
}
