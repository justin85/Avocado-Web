package com.avocado.servlet;


import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class Signgreetingservlet extends HttpServlet {
    private static final Logger log = Logger.getLogger(Signgreetingservlet.class.getName());


    public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        String content = req.getParameter("content");
        Date date = new Date();
        Greetingstore greeting = new Greetingstore(user, content, date);

        PersistenceManager pm = PMF.get().getPersistenceManager();
        try {
            pm.makePersistent(greeting);
        } finally {
            pm.close();
        }

        resp.sendRedirect("/guestbook.jsp");
    }
    public void removeActivity(Activitystore activity) {
    	PersistenceManager pm = PMF.get().getPersistenceManager();

    	Query query = pm.newQuery("select from " + Activitystore.class);

    	List<Activitystore> objs = (List<Activitystore>) query.execute();

    	pm.deletePersistentAll(objs);

    }

}