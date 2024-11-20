package uz.app.persistance2.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String gmail;

    @Column(nullable = false)
    private String name;

    private String password;

    @Column(nullable = false)
    private String role;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "saved_duas",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "dua_id")
    )
    private Set<Dua> savedDuas = new HashSet<>();
}
