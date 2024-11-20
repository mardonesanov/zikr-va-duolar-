package uz.app.persistance2.datasource;

import uz.app.persistance2.entity.ZikrMasjid;
import uz.app.persistance2.db.Datasource;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

public class ZikrMasjidRepository {
    private static final Logger logger = Logger.getLogger(ZikrMasjidRepository.class.getName());

    public void save(ZikrMasjid zikr) {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(zikr);
            em.getTransaction().commit();
            logger.info("Zikr successfully saved to the database: " + zikr);
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error saving zikr to the database: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public Optional<ZikrMasjid> findById(Long id) {
        EntityManager em = Datasource.createEntityManager();
        try {
            return Optional.ofNullable(em.find(ZikrMasjid.class, id));
        } catch (Exception e) {
            logger.severe("Error finding zikr by id: " + e.getMessage());
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    public void update(ZikrMasjid zikr) {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(zikr);
            em.getTransaction().commit();
            logger.info("Zikr successfully updated in the database: " + zikr);
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error updating zikr in the database: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            ZikrMasjid zikr = em.find(ZikrMasjid.class, id);
            if (zikr != null) {
                em.remove(zikr);
                em.getTransaction().commit();
                logger.info("Zikr successfully deleted from the database: " + zikr);
            } else {
                em.getTransaction().rollback();
                logger.warning("Zikr not found for deletion with id: " + id);
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error deleting zikr from the database: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public List<ZikrMasjid> findAll() {
        EntityManager em = Datasource.createEntityManager();
        try {
            TypedQuery<ZikrMasjid> query = em.createQuery("SELECT z FROM ZikrMasjid z", ZikrMasjid.class);
            return query.getResultList();
        } catch (Exception e) {
            logger.severe("Error retrieving all zikrs from the database: " + e.getMessage());
            return List.of();
        } finally {
            em.close();
        }
    }
}
