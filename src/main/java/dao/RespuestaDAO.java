
package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import jhonnydev.codesolve.modelo.Respuesta;

public class RespuestaDAO {

    private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("CodeSolvePU");

    public boolean registrarRespuesta(Respuesta respuesta) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(respuesta);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            System.out.println("Error al registrar respuesta: " + e.getMessage());
            return false;
        } finally {
            em.close();
        }
    }

    //respuestas asociadas a una pregunta especifica
    public List<Respuesta> obtenerRespuestasPorPregunta(int idPregunta) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT r FROM Respuesta r WHERE r.pregunta.idPregunta = :idPregunta ORDER BY r.idRespuesta ASC";
            return em.createQuery(jpql, Respuesta.class)
                    .setParameter("idPregunta", idPregunta)
                    .getResultList();
        } finally {
            em.close();
        }
    }
    
    public long contarRespuestasTotales() {
    EntityManager em = emf.createEntityManager();
        try {
          String jpql = "SELECT COUNT(r) FROM Respuesta r";
          return em.createQuery(jpql, Long.class).getSingleResult();
        } catch (Exception e) {
          return 0;
        } finally {
        em.close();
        }
    }
}
