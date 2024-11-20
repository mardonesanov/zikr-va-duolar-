package uz.app.persistance2.datasource;

import uz.app.persistance2.entity.User;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

public class UserRepository {
    private static final Logger logger = Logger.getLogger(UserRepository.class.getName());
    private static final EntityManagerFactory ENTITY_MANAGER_FACTORY = Persistence.createEntityManagerFactory("unit");

    public EntityManager getEntityManager() {
        return ENTITY_MANAGER_FACTORY.createEntityManager();
    }

    public Optional<User> findByGmail(String gmail) {
        EntityManager em = getEntityManager();
        try {
            User user = em.createQuery("SELECT u FROM User u WHERE u.gmail = :gmail", User.class)
                    .setParameter("gmail", gmail)
                    .getSingleResult();
            return Optional.of(user);
        } catch (Exception e) {
            logger.severe("Error finding user by Gmail: " + e.getMessage());
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    public void save(User user) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
        } finally {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            em.close();
        }
    }

    public List<User> getAllUsers() {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT u FROM User u", User.class).getResultList();
        } catch (Exception e) {
            logger.severe("Error retrieving all users: " + e.getMessage());
            return List.of();
        } finally {
            em.close();
        }
    }

    public void delete(Long userId) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            User user = em.find(User.class, userId);
            if (user != null) {
                em.remove(user);
            }
            em.getTransaction().commit();
        } finally {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            em.close();
        }
    }

    public void update(User user) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(user);
            em.getTransaction().commit();
            logger.info("User successfully updated in the database: " + user);
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error updating user in the database: " + e.getMessage());
        } finally {
            em.close();
        }
    }
}
