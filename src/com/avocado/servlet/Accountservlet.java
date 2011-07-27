package com.avocado.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.Text;

public class Accountservlet extends HttpServlet {
	private static final Logger log = Logger.getLogger(Accountservlet.class.getName());
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss Z z");

		InputStream is = req.getInputStream();
		String ID = req.getHeader("UID");
		String[] UID = ID.split("@");
		String IMEI =req.getHeader("IMEI");
		String Model =req.getHeader("Model");
		String Permission = "1";
		StringBuffer put = new StringBuffer();
		byte[] B = new byte[5069];
		for(int N; (N = is.read(B)) != -1;){
			put.append(new String(B, 0, N));
		}

	        Text myText = new Text(put.toString());
		Userstore store = new Userstore();
			
	int count =0;
			 PersistenceManager pm = PMF.get().getPersistenceManager();
			    String query = "select from " + Userstore.class.getName();
			    List<Userstore> User = (List<Userstore>) pm.newQuery(query).execute();
			    if (User.isEmpty()) {
			    	store = new Userstore(UID[0],IMEI,Model,Permission);
			    	pm.makePersistent(store); 
			    } else{
			    	for(Userstore g : User){
			    		if(IMEI.equals(g.getIMEI())){
			    			count++;
			    		}
			    	}
			    	if(count==0){
			    		store = new Userstore(UID[0],IMEI,Model,Permission);
				    	pm.makePersistent(store); 
			    	}
			    }
			    pm.close();
	        

		

    
	}

    
}