package com.avocado.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Permissionservlet extends HttpServlet {
	private static final Logger log = Logger.getLogger(Permissionservlet.class.getName());
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		String pIDs = req.getParameter("q");
		String[] pID = pIDs.split(",");

		String Permission = req.getParameter("Permission");
		if(Permission == null){
			Permission = "1";
		}
        updateAccountFromWeb(pID,Permission);
        resp.sendRedirect("/permission.jsp");
        
	}
	
	public void updateAccountFromWeb(String[] pID,String Permission){
		for(int i=0;i<pID.length;i++){
			PersistenceManager pm = PMF.get().getPersistenceManager();
		    String query = "select from " + Userstore.class.getName() + " where UID == '"+pID[i]+"'";
		    List<Userstore> User = (List<Userstore>) pm.newQuery(query).execute();
		    for(int j=0;j<User.size();j++){
			    if (!User.isEmpty()) {
			    	updatePermission(User.get(j), Permission);
			    }
		    }
		    pm.close();
        }
	}
	public void updatePermission(Userstore userstore, String permission) {
	    PersistenceManager pm = PMF.get().getPersistenceManager();
	    try {
            pm.currentTransaction().begin();
            // We don't have a reference to the selected Product.
            // So we have to look it up first,
            userstore = pm.getObjectById(Userstore.class, userstore.getKey());
            userstore.setPermission(permission);
            pm.makePersistent(userstore);
            pm.currentTransaction().commit();
        } catch (Exception ex) {
            pm.currentTransaction().rollback();
            throw new RuntimeException(ex);
        } finally {
            pm.close();
        }

	}
}