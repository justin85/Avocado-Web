package com.avocado.modify.datastore;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.avocado.servlet.PMF;
import com.avocado.servlet.Userstore;

public class UserstoreModify extends HttpServlet {


	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PersistenceManager pm = PMF.get().getPersistenceManager();
	    String query = "select from " + Userstore.class.getName();
	    List<Userstore> User = (List<Userstore>) pm.newQuery(query).execute();
	    String permission = "1";
	    for(int i=0;i<User.size();i++){
	    	PersistenceManager pm1 = PMF.get().getPersistenceManager();
	    	tempUserstore move = new tempUserstore(User.get(i).getUID(),User.get(i).getIMEI(),User.get(i).getModel(),permission);
	    	pm1.makePersistent(move);
	    }
	    deleteUsersotre();
	    generateUserstore();
	    deleteTempUsersotre();
	    
	    response.sendRedirect("/index.jsp");
	}
	public void generateUserstore(){
		PersistenceManager pm = PMF.get().getPersistenceManager();
	    String query = "select from " + tempUserstore.class.getName();
	    List<tempUserstore> User = (List<tempUserstore>) pm.newQuery(query).execute();
	    String permission = "1";
	    for(int i=0;i<User.size();i++){
	    	PersistenceManager pm1 = PMF.get().getPersistenceManager();
	    	Userstore move = new Userstore(User.get(i).getUID(),User.get(i).getIMEI(),User.get(i).getModel(),permission);
	    	pm1.makePersistent(move);
	    }
	}
	public void deleteUsersotre(){
		PersistenceManager pm = PMF.get().getPersistenceManager();
		String query = "select from " + Userstore.class.getName();
		List<Userstore> datastores = (List<Userstore>) pm.newQuery(query).execute();

		pm.deletePersistentAll(datastores);
	}
	public void deleteTempUsersotre(){
		PersistenceManager pm = PMF.get().getPersistenceManager();
		String query = "select from " + tempUserstore.class.getName();
		List<tempUserstore> datastores = (List<tempUserstore>) pm.newQuery(query).execute();

		pm.deletePersistentAll(datastores);
	}

}
