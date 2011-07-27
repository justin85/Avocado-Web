package com.avocado.modify.datastore;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.avocado.servlet.Datastore;
import com.avocado.servlet.PMF;

public class deleteDatastore extends HttpServlet {


	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		String query = "select from " + Datastore.class.getName();
		List<Datastore> datastores = (List<Datastore>) pm.newQuery(query).execute();

		pm.deletePersistentAll(datastores);
	    
//	    response.sendRedirect("/generateDatastore");
	}

}
