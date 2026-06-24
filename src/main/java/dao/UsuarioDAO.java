
package dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import jhonnydev.codesolve.modelo.Usuario;

public class UsuarioDAO {

    // nombre de Unidad de Persistencia en el xml
    private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("CodeSolvePU");

    // REGISTRO
    public boolean registrarUsuario(Usuario usuario) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(usuario); 
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback(); 
            }
            System.out.println("Error al registrar usuario: " + e.getMessage());
            return false;
        } finally {
            em.close(); 
        }
    }

    // LOGIN
    public Usuario validarLogin(String email, String password) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT u FROM Usuario u WHERE u.email = :email AND u.password = :password";
            
            Usuario usuario = em.createQuery(jpql, Usuario.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getSingleResult(); // Retorna el usuario si coincide
            
            return usuario; 
        } catch (NoResultException e) {
            return null; 
        } finally {
            em.close();
        }
    }
}