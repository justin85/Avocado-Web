package com.avocado.modify.datastore;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.avocado.servlet.Datastore;
import com.avocado.servlet.PMF;

public class generateDatastore extends HttpServlet {


	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PersistenceManager pm = PMF.get().getPersistenceManager();
	    String query = "select from " + tempDatastore.class.getName();
	    List<tempDatastore> datastore = (List<tempDatastore>) pm.newQuery(query).execute();
	    
	    for(int i=0;i<datastore.size();i++){
	    	PersistenceManager pm1 = PMF.get().getPersistenceManager();
	    	Datastore move = new Datastore(datastore.get(i).getDate(),datastore.get(i).getCorrect(),datastore.get(i).getActi(),datastore.get(i).getIMEI(),datastore.get(i).getFNS(),datastore.get(i).getMyText(),datastore.get(i).getPhoneLocation(),datastore.get(i).getComment());
	    	pm1.makePersistent(move);
	    }
	    
//	    response.sendRedirect("/deleteTempDatastore");
	}


}
