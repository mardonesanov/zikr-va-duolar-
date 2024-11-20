package uz.app.persistance2.datasource;

import uz.app.persistance2.entity.NamazDua;
import uz.app.persistance2.db.Datasource;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

public class NamazDuaRepository {
    private static final Logger logger = Logger.getLogger(NamazDuaRepository.class.getName());

    public void save(NamazDua dua) {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(dua);
            em.getTransaction().commit();
            logger.info("Dua successfully saved to the database: " + dua);
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error saving dua to the database: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public Optional<NamazDua> findById(Long id) {
        EntityManager em = Datasource.createEntityManager();
        try {
            return Optional.ofNullable(em.find(NamazDua.class, id));
        } catch (Exception e) {
            logger.severe("Error finding dua by id: " + e.getMessage());
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    public void update(NamazDua dua) {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(dua);
            em.getTransaction().commit();
            logger.info("Dua successfully updated in the database: " + dua);
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error updating dua in the database: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            NamazDua dua = em.find(NamazDua.class, id);
            if (dua != null) {
                em.remove(dua);
                em.getTransaction().commit();
                logger.info("Dua successfully deleted from the database: " + dua);
            } else {
                em.getTransaction().rollback();
                logger.warning("Dua not found for deletion with id: " + id);
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error deleting dua from the database: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public List<NamazDua> findAll() {
        EntityManager em = Datasource.createEntityManager();
        try {
            TypedQuery<NamazDua> query = em.createQuery("SELECT d FROM NamazDua d", NamazDua.class);
            return query.getResultList();
        } catch (Exception e) {
            logger.severe("Error retrieving all duas from the database: " + e.getMessage());
            return List.of();
        } finally {
            em.close();
        }
    }
}
