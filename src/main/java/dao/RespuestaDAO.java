
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
    //editar respuesta
    public boolean editarRespuesta(Respuesta respuesta) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(respuesta);
            em.getTransaction().commit();
            return true;
        }catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        }finally {
            em.close();
        }
    }
    //eliminar respuesta
    public boolean eliminarRespuesta(int idRespuesta) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Respuesta r = em.find(Respuesta.class, idRespuesta);
            if(r != null) {
                em.remove(r);
                em.getTransaction().commit();
                return true;
            }
            return false;
        }catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        }finally {
        em.close();
        }
    }
    //buscar por id
    public Respuesta buscarRespuestaPorId(int idRespuesta) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Respuesta.class, idRespuesta);
        }catch (Exception e) {
            System.out.println("Error al buscar respuesta por ID: " + e.getMessage());
        return null;
        }finally {
        em.close();
        }
    }
    
    public long contarRespuestasPorUsuario(int idUsuario) {
    EntityManager em = emf.createEntityManager();
    try {
        return em.createQuery("SELECT COUNT(r) FROM Respuesta r WHERE r.usuario.idUsuario = :id", Long.class)
                 .setParameter("id", idUsuario)
                 .getSingleResult();
    } finally {
        em.close();
    }
}
}
