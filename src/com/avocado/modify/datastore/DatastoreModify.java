package com.avocado.modify.datastore;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.avocado.servlet.Datastore;
import com.avocado.servlet.PMF;

public class DatastoreModify extends HttpServlet {


	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PersistenceManager pm = PMF.get().getPersistenceManager();
	    String query = "select from " + Datastore.class.getName();
	    List<Datastore> datastore = (List<Datastore>) pm.newQuery(query).execute();
		String comment = "No comment.";
		String location = "Not specified.";
	    for(int i=0;i<datastore.size();i++){
	    	PersistenceManager pm1 = PMF.get().getPersistenceManager();
	    	tempDatastore move = new tempDatastore(datastore.get(i).getDate(),datastore.get(i).getCorrect(),datastore.get(i).getActi(),datastore.get(i).getIMEI(),datastore.get(i).getFNS(),datastore.get(i).getMyText(),location,comment);
	    	pm1.makePersistent(move);
	    }
//	    deleteDatastore();
//	    generateDatastore();
//	    deleteTempDatastore();
	    
//	    response.sendRedirect("/deleteDatastore");
	}
	public void generateDatastore(){
		PersistenceManager pm = PMF.get().getPersistenceManager();
	    String query = "select from " + tempDatastore.class.getName();
	    List<tempDatastore> datastore = (List<tempDatastore>) pm.newQuery(query).execute();
	    
	    for(int i=0;i<datastore.size();i++){
	    	PersistenceManager pm1 = PMF.get().getPersistenceManager();
	    	Datastore move = new Datastore(datastore.get(i).getDate(),datastore.get(i).getCorrect(),datastore.get(i).getActi(),datastore.get(i).getIMEI(),datastore.get(i).getFNS(),datastore.get(i).getMyText(),datastore.get(i).getPhoneLocation(),datastore.get(i).getComment());
	    	pm1.makePersistent(move);
	    }
	}
	public void deleteDatastore(){
		PersistenceManager pm = PMF.get().getPersistenceManager();
		String query = "select from " + Datastore.class.getName();
		List<Datastore> datastores = (List<Datastore>) pm.newQuery(query).execute();

		pm.deletePersistentAll(datastores);
	}
	public void deleteTempDatastore(){
		PersistenceManager pm = PMF.get().getPersistenceManager();
		String query = "select from " + tempDatastore.class.getName();
		List<tempDatastore> datastores = (List<tempDatastore>) pm.newQuery(query).execute();

		pm.deletePersistentAll(datastores);
	}

}
