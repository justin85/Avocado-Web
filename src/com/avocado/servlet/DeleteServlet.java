package com.avocado.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteServlet {
	private static final Logger log = Logger.getLogger(DeleteServlet.class.getName());
	
public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss Z z");

		InputStream is = req.getInputStream();
		String UID = req.getHeader("id");
		
		StringBuffer put = new StringBuffer();
		byte[] B = new byte[5069];
		for(int N; (N = is.read(B)) != -1;){
			put.append(new String(B, 0, N));
		}
		
		ArrayList<String> IMEInum=new ArrayList<String>();
	    PersistenceManager pm = PMF.get().getPersistenceManager();
		String query1 = "select from " + Userstore.class.getName() + " where UID=="+UID;
		 List<Userstore> userstores = (List<Userstore>) pm.newQuery(query1).execute();
		    if (userstores.isEmpty()) {
		    	
		    } else {
				for (Userstore g : userstores) {
	        	if(UID.equals(g.getUID())){
		        	IMEInum.add(g.getIMEI());
		        	
	        	}
	        	}
		    
			  
			    pm.close();
			    
			    removeActivity(IMEInum);
			    
		    }
		

    
	}
	public void removeActivity(ArrayList<String> IMEInum) {
    	PersistenceManager pm = PMF.get().getPersistenceManager();

    	PersistenceManager pm1 = PMF.get().getPersistenceManager();
    	String query = "select from " + Activitystore.class.getName()+" where IMEI=="+IMEInum.get(0);
    	List<Activitystore> datastores = (List<Activitystore>) pm1.newQuery(query).execute();
    	
	    pm1.close();

    	pm.deletePersistentAll(datastores);

    }
}
