
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
    //listar por criterio
    public List<Pregunta> buscarPreguntasPorCriterio(String criterio) {
    EntityManager em = emf.createEntityManager();
      try {
        String jpql = "SELECT p FROM Pregunta p WHERE LOWER(p.titulo) LIKE :criterio OR LOWER(p.etiquetas) "
                + "LIKE :criterio ORDER BY p.fechaCreacion DESC";
        return em.createQuery(jpql, Pregunta.class)
                 .setParameter("criterio", "%" + criterio.toLowerCase() + "%")
                 .getResultList();
      }finally {
        em.close();
      }
    }
    //busqueda para facilitar la respuesta
    public Pregunta buscarPreguntaPorId(int id) {
    EntityManager em = emf.createEntityManager();
    try {
        Pregunta p = em.find(Pregunta.class, id);
        if (p != null) {
            em.refresh(p); 
        }
        return p;
    }finally {
        em.close();
    }
    }
    //editar pregunta
    public boolean editarPregunta(Pregunta pregunta) {
    EntityManager em = emf.createEntityManager();
    try {
        em.getTransaction().begin();
        em.merge(pregunta); // merge actualiza el registro mapeado por su ID
        em.getTransaction().commit();
        return true;
    } catch (Exception e) {
        if (em.getTransaction().isActive()) em.getTransaction().rollback();
        return false;
    } finally {
        em.close();
    }
    }
    //eliminar pregunta
    public boolean eliminarPregunta(int idPregunta) {
    EntityManager em = emf.createEntityManager();
    try {
        em.getTransaction().begin();
        // En JPA, primero debemos buscar el objeto en el contexto actual para poder borrarlo
        Pregunta p = em.find(Pregunta.class, idPregunta);
        if (p != null) {
            em.remove(p);
            em.getTransaction().commit();
            return true;
        }
        return false;
    } catch (Exception e) {
        if (em.getTransaction().isActive()) em.getTransaction().rollback();
        return false;
    } finally {
        em.close();
    }
    }
    
    public long contarPreguntasPorUsuario(int idUsuario) {
    EntityManager em = emf.createEntityManager();
    try {
        return em.createQuery("SELECT COUNT(p) FROM Pregunta p WHERE p.usuario.idUsuario = :id", Long.class)
                 .setParameter("id", idUsuario)
                 .getSingleResult();
    } finally {
        em.close();
    }
}
}