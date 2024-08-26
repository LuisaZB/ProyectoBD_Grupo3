package com.proyectoHotel.controller;

import com.proyectoHotel.dao.FacturaDao;
import com.proyectoHotel.dao.ReservacionDao;
import com.proyectoHotel.domain.Factura;
import com.proyectoHotel.domain.Reservacion;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class FacturasController {

    @Autowired
    private FacturaDao facturadao;

    @Autowired
    private ReservacionDao reservaciondao;

    @RequestMapping("/facturas")
    public String page(Model model) {
        model.addAttribute("facturas", facturadao.findAll());
        model.addAttribute("reservaciones", reservaciondao.findAll());
        return "facturas";
    }

    @PostMapping("/facturas/guardar")
    public String guardarFactura(@ModelAttribute Factura factura) {
        System.out.println("Factura recibida: " + factura);
        if (factura.getReservacion() == null || factura.getReservacion().getIdReservacion() == null) {
            System.out.println("Reservación es nula o ID de reservación es nulo");
            return "redirect:/facturas?error=missingReservacion";
        }
        Reservacion reservacion = reservaciondao.findById(factura.getReservacion().getIdReservacion()).orElse(null);
        if (reservacion == null) {
            System.out.println("Reservación no encontrada");
            return "redirect:/facturas?error=reservacionNotFound";
        }
        factura.setReservacion(reservacion);
        facturadao.save(factura);
        return "redirect:/facturas";
    }

    @GetMapping("/facturas/modificar/{id}")
    public String mostrarFormularioEdicion(@PathVariable("id") Long id, Model model) {
        Factura factura = facturadao.findById(id).orElse(null);
        if (factura == null) {
            return "redirect:/facturas?error=facturaNotFound";
        }
        model.addAttribute("factura", factura);
        model.addAttribute("reservaciones", reservaciondao.findAll());
        return "fragments/editar_factura :: editarFactura";
    }

    @PostMapping("/facturas/actualizar")
    public String actualizarFactura(@ModelAttribute("factura") Factura factura, RedirectAttributes redirectAttributes) {
        try {
            facturadao.save(factura);  // Guarda los cambios en la base de datos
            redirectAttributes.addFlashAttribute("mensaje", "Factura actualizada correctamente");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error al actualizar la factura");
        }
        return "redirect:/facturas";  // Redirige a la página de listado de facturas
    }

    @PostMapping("/facturas/modificar")
    public String editarFactura(Factura factura) {
        if (factura.getReservacion() == null || factura.getReservacion().getIdReservacion() == null) {
            return "redirect:/facturas?error=reservacionNotFound";
        }
        Reservacion reservacion = reservaciondao.findById(factura.getReservacion().getIdReservacion()).orElse(null);
        if (reservacion == null) {
            return "redirect:/facturas?error=reservacionNotFound";
        }
        factura.setReservacion(reservacion);
        facturadao.save(factura);
        return "redirect:/facturas";
    }

    @GetMapping("/facturas/eliminar/{id}")
    public String eliminarFactura(@PathVariable("id") Long id) {
        Factura factura = facturadao.findById(id).orElse(null);
        if (factura != null) {
            facturadao.delete(factura);
        }
        return "redirect:/facturas";
    }

    @GetMapping("/facturas/buscar")
    public String buscarFactura(@RequestParam("query") Long idFactura, Model model) {
        Factura factura = facturadao.findById(idFactura).orElse(null);
        if (factura == null) {
            model.addAttribute("facturas", new ArrayList<>());
        } else {
            model.addAttribute("facturas", Arrays.asList(factura));
        }
        model.addAttribute("reservaciones", reservaciondao.findAll());
        return "facturas";
    }
}
