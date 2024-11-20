package uz.app.persistance2.db;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class Datasource {
    private static EntityManagerFactory factory = Persistence.createEntityManagerFactory("unit");

    public static EntityManager createEntityManager() {
        return factory.createEntityManager();
    }
}