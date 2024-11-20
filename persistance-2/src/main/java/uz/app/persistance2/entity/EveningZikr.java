package uz.app.persistance2.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import jakarta.persistence.*;

@Entity
@Table(name = "evening_zikrs")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class EveningZikr {
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
}