
package dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import jhonnydev.codesolve.modelo.Usuario;

public class UsuarioDAO {

    private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("CodeSolvePU");

    public boolean registrarUsuario(Usuario usuario) {

    EntityManager em = emf.createEntityManager(); 
    try {
        em.getTransaction().begin();
        em.persist(usuario);
        em.getTransaction().commit();
        System.out.println("Usuario insertado con éxito!");
        return true;
    }catch (Exception e) {
        System.out.println("----ERROR EN JPA REGISTRO----");
        e.printStackTrace(); 
        if (em.getTransaction().isActive()) {
            em.getTransaction().rollback();
        }
        return false;
    } finally {
        em.close();
    }
    }

    public Usuario validarLogin(String email, String password) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT u FROM Usuario u WHERE u.email = :email AND u.password = :password";
            
            Usuario usuario = em.createQuery(jpql, Usuario.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getSingleResult(); 
            
            return usuario; 
        } catch (NoResultException e) {
            return null; 
        } finally {
            em.close();
        }
    }
}