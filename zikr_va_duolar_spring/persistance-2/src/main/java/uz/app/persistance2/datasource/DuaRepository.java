package uz.app.persistance2.datasource;

import uz.app.persistance2.entity.Dua;
import uz.app.persistance2.entity.User;
import uz.app.persistance2.db.Datasource;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

public class DuaRepository {
    private static final Logger logger = Logger.getLogger(DuaRepository.class.getName());

    public void save(Dua dua) {
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

    public Optional<Dua> findById(Long id) {
        EntityManager em = Datasource.createEntityManager();
        try {
            return Optional.ofNullable(em.find(Dua.class, id));
        } catch (Exception e) {
            logger.severe("Error finding dua by id: " + e.getMessage());
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    public void update(Dua dua) {
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
            Dua dua = em.find(Dua.class, id);
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

    public List<Dua> findAll() {
        EntityManager em = Datasource.createEntityManager();
        try {
            TypedQuery<Dua> query = em.createQuery("SELECT d FROM Dua d", Dua.class);
            return query.getResultList();
        } catch (Exception e) {
            logger.severe("Error retrieving all duas from the database: " + e.getMessage());
            return List.of();
        } finally {
            em.close();
        }
    }

    public void saveUserDua(Long userId, Long duaId) throws Exception {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            User user = em.find(User.class, userId);
            Dua dua = em.find(Dua.class, duaId);

            if (user == null || dua == null) {
                em.getTransaction().rollback();
                throw new Exception("User or Dua not found");
            }

            if (!user.getSavedDuas().contains(dua)) {
                user.getSavedDuas().add(dua);
                em.merge(user);
                em.getTransaction().commit();
                logger.info("Dua successfully saved for user: " + userId);
            } else {
                em.getTransaction().rollback();
                logger.warning("Dua already saved for user: " + userId);
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error saving dua for user: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public void removeUserDua(Long userId, Long duaId) throws Exception {
        EntityManager em = Datasource.createEntityManager();
        try {
            em.getTransaction().begin();
            User user = em.find(User.class, userId);
            if (user != null) {
                Dua dua = em.find(Dua.class, duaId);
                if (dua != null) {
                    user.getSavedDuas().remove(dua);
                    em.merge(user);
                    em.getTransaction().commit();
                    logger.info("Dua successfully removed for user: " + userId);
                } else {
                    em.getTransaction().rollback();
                    logger.warning("Dua not found with id: " + duaId);
                }
            } else {
                em.getTransaction().rollback();
                logger.warning("User not found with id: " + userId);
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("Error removing dua for user: " + e.getMessage());
        } finally {
            em.close();
        }
    }
    public List<Dua> findUserDuas(Long userId) throws Exception {
        EntityManager em = Datasource.createEntityManager();
        try {
            User user = em.find(User.class, userId);
            if (user != null) {
                List<Dua> savedDuas = new ArrayList<>(user.getSavedDuas());
                logger.info("Foydalanuvchining saqlangan duolari: " + savedDuas);
                return savedDuas;
            }
            logger.warning("Foydalanuvchi topilmadi, ID: " + userId);
            return List.of();
        } catch (Exception e) {
            logger.severe("Foydalanuvchi uchun saqlangan duolarni topishda xatolik: " + e.getMessage());
            return List.of();
        } finally {
            em.close();
        }
    }




}