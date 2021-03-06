package ru.gbuac.controller.authority;

import javassist.NotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import ru.gbuac.model.Authority;
import ru.gbuac.service.AuthorityService;
import ru.gbuac.to.AuthorityTo;

import java.util.List;

import static ru.gbuac.util.ValidationUtil.assureIdConsistent;
import static ru.gbuac.util.ValidationUtil.checkNew;

public abstract class AbstractAuthorityRestController {
    protected final Logger LOG = LoggerFactory.getLogger(getClass());

    @Autowired
    AuthorityService authorityService;

    public Authority get(int id) throws NotFoundException {
        LOG.info("get " + id);
        return authorityService.get(id);
    }

    public List<Authority> getAll() {
        LOG.info("getAll");
        return authorityService.getAll();
    }

    public Authority create(Authority authority) {
        LOG.info("create " + authority);
        checkNew(authority);
        return authorityService.save(authority);
    }

    public Authority update(Authority authority, int id) {
        LOG.info("update " + authority);
        assureIdConsistent(authority, id);
        return authorityService.update(authority, id);
    }

    public void delete(int id) {
        LOG.info("delete " + id);
        authorityService.delete(id);
    }

    public List<Authority> getAllTopLevel() {
        LOG.info("getAllTopLevel");
        return authorityService.getAllTopLevel();
    }

    public List<Authority> getAuthoritiesByDivisionId(int id) {
        LOG.info("getEmployeesByDivisionId" + id);
        return authorityService.getAuthoritiesByDivisionId(id);
    }

    public List<Authority> searchAuthorities(String word) {
        LOG.info("searchAuthorities");
        return authorityService.searchAuthorities(word);
    }

    public List<Authority> getAllTopLevelAuthoritiesByEmployeeId(int id) {
        LOG.info("getAuthoritiesByEmployeeId");
        return authorityService.getAllTopLevelAuthoritiesByEmployeeId(id);
    }

    public List<Authority> getAllTopLevelAuthoritiesByChildAuthorityId(int childId) {
        LOG.info("getAllTopLevelAuthoritiesByChildAuthorityId");
        return authorityService.getAllTopLevelAuthoritiesByChildAuthorityId(childId);
    }

    public List<Authority> getAllParents(int id) {
        LOG.info("getAllParents");
        return authorityService.getAllParents(id);
    }

    public List<Authority> getAllChilds(int id) {
        LOG.info("getAllChilds");
        return authorityService.getAllChilds(id);
    }

    public List<Authority> getAuthoritiesByGoalId(int id) {
        LOG.info("getAuthoritiesByGoalId");
        return authorityService.getAuthoritiesByGoalId(id);
    }

    public List<Authority> getAuthoritiesByEmployeeId(int id) {
        LOG.info("getAuthoritiesByEmployeeId");
        return authorityService.getAuthoritiesByEmployeeId(id);
    }
}
