package com.proyectoHotel.controller;

import com.proyectoHotel.dao.FacturaDao;
import com.proyectoHotel.dao.ReservacionDao;
import com.proyectoHotel.domain.Factura;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
    public String guardarFactura(Factura factura) {
        facturadao.save(factura);
        return "redirect:/facturas";
    }
}
