package uz.app.persistance2.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "hadislar")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Hadis {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false, length = 1000)
    private String text;

    @Column(nullable = false, length = 1000)
    private String arabic;

    @Column(nullable = false, length = 1000)
    private String transliteration;

    @Column(nullable = false, length = 1000)
    private String translation;

    @Column(nullable = false)
    private String imam;
    @ManyToMany(mappedBy = "savedDuas")
    private Set<User> users = new HashSet<>();

}
