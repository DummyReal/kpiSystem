package ru.gbuac.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.validator.constraints.SafeHtml;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@NoArgsConstructor
@Getter
@Setter
@Table(name = "goal")
public class Goal extends NamedEntity {

    @SafeHtml
    @Column(name = "description")
    private String description;

    @Column(name = "create_date")
    private LocalDate createDate;

    @Column(name = "execution_date")
    private LocalDate executiveDate;

    @Column(name = "control_date")
    private LocalDate controlDate;

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Division> divisions;
}
