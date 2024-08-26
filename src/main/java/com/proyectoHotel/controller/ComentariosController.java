package com.proyectoHotel.controller;

import com.proyectoHotel.dao.ComentarioHotelDao;
import com.proyectoHotel.dao.HotelDao;
import com.proyectoHotel.dao.ClienteDao;
import com.proyectoHotel.domain.Cliente;
import com.proyectoHotel.domain.ComentarioHotel;
import com.proyectoHotel.domain.Hotel;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ComentariosController {

    @Autowired
    private ComentarioHotelDao comentarioHotelDao;

    @Autowired
    private HotelDao hotelDao;

    @Autowired
    private ClienteDao clienteDao;

    @RequestMapping("/comentarios")
    public String page(Model model) {
        model.addAttribute("comentarios", comentarioHotelDao.findAll());
        model.addAttribute("hoteles", hotelDao.findAll());
        model.addAttribute("clientes", clienteDao.findAll());
        return "comentarios";
    }

    @PostMapping("/comentarios/guardar")
public String guardarComentario(@RequestParam Long idComentario,
                                 @RequestParam Long idHotel,
                                 @RequestParam Long idCliente,
                                 @RequestParam String comentario,
                                 @RequestParam Integer puntuacion,
                                 @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date fecha) {
     ComentarioHotel comentarioHotel = new ComentarioHotel();
     comentarioHotel.setIdComentario(idComentario);
     comentarioHotel.setComentario(comentario);
     comentarioHotel.setPuntuacion(puntuacion);
     comentarioHotel.setFecha(fecha);
     
     Hotel hotel = hotelDao.findById(idHotel).orElseThrow(() -> new IllegalArgumentException("Hotel no encontrado: " + idHotel));
     Cliente cliente = clienteDao.findById(idCliente).orElseThrow(() -> new IllegalArgumentException("Cliente no encontrado: " + idCliente));
     
     comentarioHotel.setHotel(hotel);
     comentarioHotel.setCliente(cliente);
     
     comentarioHotelDao.save(comentarioHotel);
     return "redirect:/comentarios";
}


    @GetMapping("/comentarios/modificar/{id}")
    public String modificarComentario(@PathVariable("id") Long id, Model model) {
        ComentarioHotel comentario = comentarioHotelDao.findById(id).orElseThrow(() -> new IllegalArgumentException("Comentario no encontrado: " + id));
        model.addAttribute("comentario", comentario);
        model.addAttribute("hoteles", hotelDao.findAll());
        model.addAttribute("clientes", clienteDao.findAll());
        return "comentarios";
    }

    @GetMapping("/comentarios/eliminar/{id}")
    public String eliminarComentario(@PathVariable("id") Long id) {
        comentarioHotelDao.deleteById(id);
        return "redirect:/comentarios";
    }
    
    @GetMapping("/comentarios/buscar")
    public String buscarComentario(@RequestParam("query") String query, Model model) {
        model.addAttribute("comentarios", comentarioHotelDao.findByHotel_NombreContaining(query));
        model.addAttribute("hoteles", hotelDao.findAll());
        model.addAttribute("clientes", clienteDao.findAll());
        return "comentarios";
    }
}
