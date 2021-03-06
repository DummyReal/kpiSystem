DROP TABLE IF EXISTS kpi.legal_document CASCADE;
DROP TABLE IF EXISTS kpi.division CASCADE;
DROP TABLE IF EXISTS kpi.employee CASCADE;
DROP TABLE IF EXISTS kpi.authority CASCADE;
DROP TABLE IF EXISTS kpi.goal CASCADE;
DROP TABLE IF EXISTS kpi.division_employees CASCADE;
DROP TABLE IF EXISTS kpi.division_child_division CASCADE;
DROP TABLE IF EXISTS kpi.employee_child_employees CASCADE;
DROP TABLE IF EXISTS kpi.authority_divisions CASCADE;
DROP TABLE IF EXISTS kpi.division_goals CASCADE;
DROP TABLE IF EXISTS kpi.authority_child_authorities CASCADE;
DROP TABLE IF EXISTS kpi.role CASCADE;
DROP TABLE IF EXISTS kpi.role_employees CASCADE;
DROP TABLE IF EXISTS kpi.role_child_roles CASCADE;
DROP TABLE IF EXISTS kpi.role_divisions CASCADE;
DROP TABLE IF EXISTS kpi.authority_employees CASCADE;
DROP TABLE IF EXISTS kpi.goal_child_goals CASCADE;
DROP TABLE IF EXISTS kpi.authority_goals CASCADE;
DROP TABLE IF EXISTS kpi.variance CASCADE;
DROP TABLE IF EXISTS kpi.goal_variances CASCADE;
DROP TABLE IF EXISTS kpi.employee_goals CASCADE;
DROP TABLE IF EXISTS kpi.employee_variances CASCADE;
DROP TABLE IF EXISTS kpi.division_variances CASCADE;
DROP TABLE IF EXISTS kpi.process CASCADE;
DROP TABLE IF EXISTS kpi.task CASCADE;
DROP TABLE IF EXISTS kpi.employee_tasks CASCADE;
DROP TABLE IF EXISTS kpi.process_template CASCADE;
DROP TABLE IF EXISTS kpi.process_process_templates CASCADE;
DROP TABLE IF EXISTS kpi.task_template CASCADE;
DROP TABLE IF EXISTS kpi.task_task_templates CASCADE;
DROP TABLE IF EXISTS kpi.authority_process_templates CASCADE;
DROP TABLE IF EXISTS kpi.goal_task_templates CASCADE;
DROP SEQUENCE IF EXISTS kpi.global_seq CASCADE;

CREATE SEQUENCE kpi.global_seq START 100000;

CREATE TABLE kpi.division
(
    id                      INTEGER PRIMARY KEY DEFAULT nextval('kpi.global_seq'),
    name                    VARCHAR                              ,
    top_level               BOOLEAN                              ,
    chief_employee_id       INTEGER
);

CREATE TABLE kpi.legal_document
(
    id                      INTEGER PRIMARY KEY DEFAULT nextval('kpi.global_seq'),
    name                    VARCHAR                         ,
    filename                VARCHAR                         ,
    division_id             INTEGER                 NOT NULL,
    UNIQUE(division_id)                                     ,
    FOREIGN KEY (division_id) REFERENCES kpi.division (id) ON DELETE CASCADE
);

CREATE TABLE kpi.division_child_division
(
    division_id              INTEGER                      ,
    child_division_id        INTEGER                      ,
    FOREIGN KEY (division_id) REFERENCES kpi.division (id) ON DELETE CASCADE,
    FOREIGN KEY (child_division_id) REFERENCES kpi.division (id) ON DELETE CASCADE
);

CREATE TABLE kpi.employee
(
    id                      INTEGER PRIMARY KEY DEFAULT nextval('kpi.global_seq'),
    name                    VARCHAR                               ,
    firstname               VARCHAR                               ,
    lastname                VARCHAR                               ,
    patronym                VARCHAR                               ,
    position                VARCHAR                               ,
    email                   VARCHAR                               ,
    phone                   VARCHAR                               ,
    photo                   VARCHAR
);

CREATE TABLE kpi.division_employees
(
    division_id              INTEGER                    ,
    employee_id             INTEGER                     ,
    FOREIGN KEY (division_id) REFERENCES kpi.division (id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES kpi.employee (id) ON DELETE CASCADE
);

CREATE TABLE kpi.employee_child_employees
(
    employee_id                  INTEGER                   ,
    child_employee_id            INTEGER                 ,
    FOREIGN KEY (employee_id) REFERENCES kpi.employee (id) ON DELETE CASCADE,
    FOREIGN KEY (child_employee_id) REFERENCES kpi.employee (id) ON DELETE CASCADE
);

CREATE TABLE kpi.goal
(
    id                      INTEGER PRIMARY KEY DEFAULT nextval('kpi.global_seq'),
    name                    VARCHAR                              ,
    description             VARCHAR                              ,
    create_date             DATE                                  ,
    execution_date          DATE                                  ,
    control_date            DATE
);

CREATE TABLE kpi.division_goals
(
    goal_id                 INTEGER                           ,
    division_id             INTEGER                           ,
    FOREIGN KEY (goal_id) REFERENCES kpi.goal (id) ON DELETE CASCADE,
    FOREIGN KEY (division_id) REFERENCES kpi.division (id) ON DELETE CASCADE
);

CREATE TABLE kpi.authority
(
    id                      INTEGER PRIMARY KEY DEFAULT nextval('kpi.global_seq'),
    name                    VARCHAR                                     ,
    top_level               BOOLEAN DEFAULT FALSE NOT NULL
);

CREATE TABLE kpi.authority_child_authorities
(
    authority_id                  INTEGER                    ,
    child_authority_id            INTEGER                    ,
    FOREIGN KEY (authority_id) REFERENCES kpi.authority (id) ON DELETE CASCADE,
    FOREIGN KEY (child_authority_id) REFERENCES kpi.authority (id) ON DELETE CASCADE
);

CREATE TABLE kpi.authority_divisions
(
    authority_id               INTEGER                           ,
    division_id                INTEGER                           ,
    FOREIGN KEY (authority_id) REFERENCES kpi.authority (id) ON DELETE CASCADE,
    FOREIGN KEY (division_id) REFERENCES kpi.division (id) ON DELETE CASCADE
);

CREATE TABLE kpi.authority_employees
(
    authority_id               INTEGER                           ,
    employee_id                INTEGER                           ,
    FOREIGN KEY (authority_id) REFERENCES kpi.authority (id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES kpi.employee (id) ON DELETE CASCADE
);

CREATE TABLE kpi.role
(
    id               INTEGER PRIMARY KEY DEFAULT nextval('kpi.global_seq'),
    name             VARCHAR
);
CREATE TABLE kpi.role_employees
(
    role_id                     INTEGER,
    employee_id                 INTEGER,
    FOREIGN KEY (role_id) REFERENCES kpi.role (id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES kpi.employee (id) ON DELETE CASCADE
);

CREATE TABLE kpi.role_child_roles
(   role_id                     INTEGER,
    child_role_id               INTEGER,
    FOREIGN KEY (role_id) REFERENCES kpi.role (id) ON DELETE CASCADE,
    FOREIGN KEY (child_role_id) REFERENCES kpi.role (id) ON DELETE CASCADE
);

CREATE TABLE kpi.role_divisions
(   role_id                   INTEGER,
    division_id               INTEGER,
    FOREIGN KEY (role_id) REFERENCES kpi.role (id) ON DELETE CASCADE,
    FOREIGN KEY (division_id) REFERENCES kpi.division (id) ON DELETE CASCADE
);

CREATE TABLE kpi.goal_child_goals
(   goal_id                   INTEGER,
    child_goal_id               INTEGER,
    FOREIGN KEY (goal_id) REFERENCES kpi.goal(id) ON DELETE CASCADE,
    FOREIGN KEY (child_goal_id) REFERENCES kpi.goal (id) ON DELETE CASCADE
);

CREATE TABLE kpi.authority_goals
(   authority_id                   INTEGER,
    goal_id                        INTEGER,
    FOREIGN KEY (authority_id) REFERENCES kpi.authority(id) ON DELETE CASCADE,
    FOREIGN KEY (goal_id) REFERENCES kpi.goal (id) ON DELETE CASCADE
);

CREATE TABLE kpi.variance
(   id                   INTEGER PRIMARY KEY DEFAULT nextval('kpi.global_seq'),
    name                 VARCHAR,
    value                VARCHAR
);

CREATE TABLE kpi.goal_variances
(   goal_id                   INTEGER,
    variance_id               INTEGER,
    FOREIGN KEY (goal_id) REFERENCES kpi.goal(id) ON DELETE CASCADE,
    FOREIGN KEY (variance_id) REFERENCES kpi.variance (id) ON DELETE CASCADE
);

CREATE TABLE kpi.employee_goals
(   employee_id                   INTEGER,
    goal_id                    INTEGER,
    FOREIGN KEY (goal_id) REFERENCES kpi.goal(id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES kpi.employee (id) ON DELETE CASCADE
);

CREATE TABLE kpi.employee_variances
(   employee_id                   INTEGER,
    variance_id                    INTEGER,
    FOREIGN KEY (employee_id) REFERENCES kpi.employee(id) ON DELETE CASCADE,
    FOREIGN KEY (variance_id) REFERENCES kpi.variance (id) ON DELETE CASCADE
);

CREATE TABLE kpi.division_variances
(   division_id                   INTEGER,
    variance_id                    INTEGER,
    FOREIGN KEY (division_id) REFERENCES kpi.division(id) ON DELETE CASCADE,
    FOREIGN KEY (variance_id) REFERENCES kpi.variance (id) ON DELETE CASCADE
);

CREATE TABLE kpi.process
(
    id                      INTEGER PRIMARY KEY DEFAULT nextval('kpi.global_seq'),
    name                    VARCHAR                              ,
    description             VARCHAR                              ,
    create_date             DATE                                  ,
    execution_date          DATE                                  ,
    control_date            DATE
);

CREATE TABLE kpi.task
(
    id                      INTEGER PRIMARY KEY DEFAULT nextval('kpi.global_seq'),
    name                    VARCHAR                              ,
    description             VARCHAR                              ,
    create_date             DATE                                  ,
    execution_date          DATE                                  ,
    control_date            DATE                                  ,
    process_id              INTEGER                                ,
    FOREIGN KEY (process_id) REFERENCES kpi.process (id) ON DELETE CASCADE
);

CREATE TABLE kpi.employee_tasks
(   employee_id                   INTEGER,
    task_id                    INTEGER,
    FOREIGN KEY (employee_id) REFERENCES kpi.employee(id) ON DELETE CASCADE,
    FOREIGN KEY (task_id) REFERENCES kpi.task(id) ON DELETE CASCADE
);

CREATE TABLE kpi.process_template
(
    id                      INTEGER PRIMARY KEY DEFAULT nextval('kpi.global_seq'),
    name                    VARCHAR                              ,
    description             VARCHAR                              ,
    duration                INTEGER                              ,
    authority_id            INTEGER                              ,
    FOREIGN KEY (authority_id) REFERENCES kpi.authority(id) ON DELETE CASCADE
);

CREATE TABLE kpi.task_template
(
    id                      INTEGER PRIMARY KEY DEFAULT nextval('kpi.global_seq'),
    name                    VARCHAR                              ,
    description             VARCHAR                              ,
    duration                INTEGER                              ,
    process_template_id     INTEGER                              ,
    goal_id                 INTEGER                              ,
    FOREIGN KEY (goal_id) REFERENCES kpi.goal(id) ON DELETE CASCADE,
    FOREIGN KEY (process_template_id) REFERENCES kpi.process_template (id) ON DELETE CASCADE
);

CREATE TABLE kpi.task_task_templates
(   task_template_id                   INTEGER,
    task_id                    INTEGER,
    FOREIGN KEY (task_template_id) REFERENCES kpi.task_template(id) ON DELETE CASCADE,
    FOREIGN KEY (task_id) REFERENCES kpi.task(id) ON DELETE CASCADE
);

CREATE TABLE kpi.process_process_templates
(   process_id                   INTEGER,
    process_template_id          INTEGER,
    FOREIGN KEY (process_id) REFERENCES kpi.process(id) ON DELETE CASCADE,
    FOREIGN KEY (process_template_id) REFERENCES kpi.process_template(id) ON DELETE CASCADE
);



-- CREATE OR REPLACE FUNCTION kpi.getRootAuthorityByChildId (childId INTEGER)
--     RETURNS INTEGER AS $$
-- DECLARE Result INTEGER;
-- BEGIN
--     WITH RECURSIVE RCTE AS
--                        (
--                            SELECT *, 1 AS Lvl FROM kpi.authority_child_authorities
--                            WHERE child_authority_id = childId
--
--                            UNION ALL
--
--                            SELECT rh.*, Lvl+1 AS Lvl FROM kpi.authority_child_authorities rh
--                                                               INNER JOIN RCTE rc ON rh.child_authority_id = rc.authority_id
--                        )
--     SELECT id, Name INTO Result
--     FROM RCTE r
--              inner JOIN kpi.authority p ON p.id = r.authority_id
--     ORDER BY lvl DESC;
--     RETURN Result;
-- END; $$ LANGUAGE plpgsql;