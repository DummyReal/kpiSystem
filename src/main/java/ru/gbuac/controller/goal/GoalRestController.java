package ru.gbuac.controller.goal;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = GoalRestController.REST_URL, produces = MediaType.APPLICATION_JSON_VALUE)
public class GoalRestController extends AbstractGoalRestController {
    public static final String REST_URL = "/rest/profile/goals";
}