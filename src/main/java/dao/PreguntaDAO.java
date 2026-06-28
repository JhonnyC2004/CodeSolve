
package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import jhonnydev.codesolve.modelo.Pregunta;

public class PreguntaDAO {

    private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("CodeSolvePU");

    public boolean registrarPregunta(Pregunta pregunta) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(pregunta);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            System.out.println("Error al registrar pregunta: " + e.getMessage());
            return false;
        } finally {
            em.close();
        }
    }

    //listar todas las preguntas para el Home
    public List<Pregunta> obtenerTodasLasPreguntas() {
        EntityManager em = emf.createEntityManager(); 
        try {
        return em.createQuery("SELECT p FROM Pregunta p ORDER BY p.fechaCreacion DESC", Pregunta.class)
                 .getResultList();
        }finally {
           em.close();
    }
}
}