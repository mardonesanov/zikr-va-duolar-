package uz.app.persistance2.datasource;

import uz.app.persistance2.entity.Hadis;
import uz.app.persistance2.db.Datasource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

public class HadisRepository {
    private static final Logger logger = Logger.getLogger(HadisRepository.class.getName());

    public void save(Hadis hadis) {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(hadis);
            em.getTransaction().commit();
            logger.info("Hadis successfully saved to the database: " + hadis);
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error saving hadis to the database: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public Optional<Hadis> findById(Long id) {
        EntityManager em = Datasource.createEntityManager();
        try {
            return Optional.ofNullable(em.find(Hadis.class, id));
        } catch (Exception e) {
            logger.severe("Error finding hadis by id: " + e.getMessage());
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    public void update(Hadis hadis) {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(hadis);
            em.getTransaction().commit();
            logger.info("Hadis successfully updated in the database: " + hadis);
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error updating hadis in the database: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            Hadis hadis = em.find(Hadis.class, id);
            if (hadis != null) {
                em.remove(hadis);
                em.getTransaction().commit();
                logger.info("Hadis successfully deleted from the database: " + hadis);
            } else {
                em.getTransaction().rollback();
                logger.warning("Hadis not found for deletion with id: " + id);
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error deleting hadis from the database: " + e.getMessage());
        } finally {
            em.close();
        }
    }
    public List<Hadis> findAll() {
        EntityManager em = Datasource.createEntityManager();
        try {
            TypedQuery<Hadis> query = em.createQuery("SELECT h FROM Hadis h", Hadis.class);
            return query.getResultList();
        } catch (Exception e) {
            logger.severe("Error retrieving all hadis from the database: " + e.getMessage());
            return List.of();
        } finally {
            em.close();
        }
    }


    public List<Hadis> findByImam(String imam) {
        EntityManager em = Datasource.createEntityManager();
        try {
            TypedQuery<Hadis> query = em.createQuery("SELECT h FROM Hadis h WHERE h.imam = :imam", Hadis.class);
            query.setParameter("imam", imam);
            return query.getResultList();
        } catch (Exception e) {
            logger.severe("Error retrieving hadis by imam from the database: " + e.getMessage());
            return List.of();
        } finally {
            em.close();
        }
    }
}
