package ru.gbuac.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import ru.gbuac.model.Authority;
import ru.gbuac.model.Division;
import ru.gbuac.model.Role;

import java.util.List;
import java.util.Optional;

public interface DivisionRepository extends JpaRepository<Division, Integer> {
    @Transactional
    @Modifying
    @Query("DELETE FROM Division d WHERE d.id=:id")
    int delete(@Param("id") int id);

    @Query("SELECT d FROM Division d WHERE d.topLevel=TRUE")
    List<Division> getAllTopLevel();

    @Query("SELECT c FROM Division d JOIN d.childDivision c WHERE d.id=:id")
    List<Division> getChildDivisionByDivisionId(@Param("id") int id);

    @Query("SELECT d FROM Division d JOIN d.authorities a WHERE a.id=:id")
    List<Division> getDivisionByAuthorityId(@Param("id") int id);

    @Query("SELECT d FROM Division d JOIN d.roles r WHERE r.id=:id")
    List<Role> getRolesByDivisionId(@Param("id") int id);
}
