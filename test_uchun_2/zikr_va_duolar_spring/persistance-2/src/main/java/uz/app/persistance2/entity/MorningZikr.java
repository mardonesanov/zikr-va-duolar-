package uz.app.persistance2.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import uz.app.persistance2.entity.User;

import java.util.Set;
import java.util.HashSet;

@Entity
@Table(name = "morning_zikrs")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MorningZikr implements Invocation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String arabic;

    @Column(nullable = false)
    private String transliteration;

    @Column(nullable = false)
    private String translation;

    @ManyToMany(mappedBy = "savedDuas")
    private Set<User> users = new HashSet<>();
}
