
import com.proyectoHotel.domain.Reservacion;
import jakarta.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "Historial_Reservaciones")
public class HistorialReservaciones {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "historial_seq")
    @SequenceGenerator(name = "historial_seq", sequenceName = "seq_Historial_Reservaciones", allocationSize = 1)
    @Column(name = "ID_Historial")
    private Long idHistorial;

    @ManyToOne
    @JoinColumn(name = "ID_Reservacion", nullable = false)
    private Reservacion reservacion;

    @Column(name = "Fecha_modificacion")
    private Timestamp fechaModificacion;

    @Column(name = "Comentario")
    private String comentario;

    // Getters and setters
    public Long getIdHistorial() {
        return idHistorial;
    }

    public void setIdHistorial(Long idHistorial) {
        this.idHistorial = idHistorial;
    }

    public Reservacion getReservacion() {
        return reservacion;
    }

    public void setReservacion(Reservacion reservacion) {
        this.reservacion = reservacion;
    }

    public Timestamp getFechaModificacion() {
        return fechaModificacion;
    }

    public void setFechaModificacion(Timestamp fechaModificacion) {
        this.fechaModificacion = fechaModificacion;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }
}

