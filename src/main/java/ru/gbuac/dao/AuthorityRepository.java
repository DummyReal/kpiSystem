package ru.gbuac.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import ru.gbuac.model.Authority;
import ru.gbuac.model.Goal;
import ru.gbuac.to.AuthorityTo;

import java.util.List;
import java.util.Optional;

public interface AuthorityRepository extends JpaRepository<Authority, Integer> {
    @Transactional
    @Modifying
    @Query("DELETE FROM Authority a WHERE a.id=:id")
    int delete(@Param("id") int id);

    @Query("SELECT a FROM Authority a WHERE a.topLevel=true")
    List<Authority> getAllTopLevel();

    @Query("SELECT a FROM Authority a JOIN a.divisions d WHERE d.id=:id")
    List<Authority> getAuthoritiesByDivisionId(@Param("id") int id);

    @Query("SELECT a FROM Authority a WHERE LOWER(a.name) LIKE CONCAT('%', LOWER(:name), '%')")
    List<Authority> searchAuthorities(@Param("name") String name);

    @Query("SELECT a FROM Authority a JOIN a.employees e WHERE e.id=:id AND a.topLevel=true")
    List<Authority> getAllTopLevelAuthoritiesByEmployeeId(@Param("id") int id);

    @Query(value = "SELECT * FROM authority a WHERE a.id IN (SELECT * FROM getrootauthoritybychildid(:childId))", nativeQuery = true)
    List<Authority> getAllTopLevelAuthoritiesByChildAuthorityId(@Param("childId") int childId);

    @Query("SELECT a FROM Authority a JOIN a.childAuthorities c WHERE c.id=:id")
    List<Authority> getAllParents(@Param("id") int id);

    @Query("SELECT a FROM Authority a WHERE a.id=:id")
    List<Authority> getAllChilds(@Param("id") int id);

    @Query("SELECT a FROM Authority a JOIN a.goals g WHERE g.id=:id")
    List<Authority> getAuthoritiesByGoalId(@Param("id") int id);

    @Query("SELECT a FROM Authority a JOIN a.employees e WHERE e.id =:id")
    List<Authority> getAuthoritiesByEmployeeId(@Param("id") int id);
}
