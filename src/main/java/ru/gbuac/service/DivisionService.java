package ru.gbuac.service;

import javassist.NotFoundException;
import ru.gbuac.model.Division;

import java.util.List;

public interface DivisionService {

    Division get(int id) throws NotFoundException;

    List<Division> getAll();

    Division save(Division division);

    void delete(int id);

    Division update(Division division, int id);

    List<Division> getAllTopLevel();

    List<Division> getChildDivisionByDivisionId(int id);

    List<Division> getDivisionByAuthorityId(int id);
}
