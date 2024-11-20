package uz.app.persistance2.datasource;

import uz.app.persistance2.entity.EveningZikr;
import uz.app.persistance2.db.Datasource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

public class EveningZikrRepository {
    private static final Logger logger = Logger.getLogger(EveningZikrRepository.class.getName());

    public void save(EveningZikr zikr) {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(zikr);
            em.getTransaction().commit();
            logger.info("Evening Zikr successfully saved to the database: " + zikr);
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error saving evening zikr to the database: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public Optional<EveningZikr> findById(Long id) {
        EntityManager em = Datasource.createEntityManager();
        try {
            return Optional.ofNullable(em.find(EveningZikr.class, id));
        } catch (Exception e) {
            logger.severe("Error finding evening zikr by id: " + e.getMessage());
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    public void update(EveningZikr zikr) {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(zikr);
            em.getTransaction().commit();
            logger.info("Evening Zikr successfully updated in the database: " + zikr);
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error updating evening zikr in the database: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            EveningZikr zikr = em.find(EveningZikr.class, id);
            if (zikr != null) {
                em.remove(zikr);
                em.getTransaction().commit();
                logger.info("Evening Zikr successfully deleted from the database: " + zikr);
            } else {
                em.getTransaction().rollback();
                logger.warning("Evening Zikr not found for deletion with id: " + id);
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error deleting evening zikr from the database: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public List<EveningZikr> findAll() {
        EntityManager em = Datasource.createEntityManager();
        try {
            TypedQuery<EveningZikr> query = em.createQuery("SELECT z FROM EveningZikr z", EveningZikr.class);
            return query.getResultList();
        } catch (Exception e) {
            logger.severe("Error retrieving all evening zikrs from the database: " + e.getMessage());
            return List.of();
        } finally {
            em.close();
        }
    }
}
