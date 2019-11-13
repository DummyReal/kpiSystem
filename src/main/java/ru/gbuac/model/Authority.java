package ru.gbuac.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity
@NoArgsConstructor
@Getter
@Setter
@Table(name = "authority")
public class Authority extends NamedEntity {

    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Division> divisions;

}
