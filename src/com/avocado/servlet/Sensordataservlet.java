package com.avocado.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.Text;

public class Sensordataservlet extends HttpServlet {
	private static final Logger log = Logger.getLogger(Sensordataservlet.class.getName());
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
//		DateFormat df = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss");
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		InputStream is = req.getInputStream();
		String FNS = req.getHeader("FN");
		String tempdate =req.getHeader("date");
//		Date date = ;
		Date date;
		try {
			date = df.parse(tempdate);
		     

		String header = req.getHeader("x-correction");
		String header2 = req.getHeader("x-activity");
		String header1 = req.getHeader("x-imei");
		
		String comment = req.getHeader("comment");
		if(comment==null){
			comment = "No comment.";
		}
		String location = req.getHeader("location");
		if(location==null){
			location = "Not specified.";
		}
//		long FNS_L=Long.parseLong(FNS);
//		long FN;
//		Datastore store = new Datastore();
//		FN=store.getFN();
//		FN++;
//		store.setFN(FN);
//		BufferedReader BR = new BufferedReader(new InputStreamReader(is));
//		StringBuilder SB = new StringBuilder();
//		String line1 = null;
//
//		while ((line1 = BR.readLine()) != null) {
//		SB.append(line1 + "\n");
//		}
//
//		BR.close();

		StringBuffer put = new StringBuffer();
		byte[] B = new byte[5069];
		for(int N; (N = is.read(B)) != -1;){
			put.append(new String(B, 0, N));
		}
//		while(FNS_L>0){
//			FNS_L--;
			
			
	        Text myText = new Text(put.toString());
	        Datastore store = new Datastore(date,header,header2,header1,FNS,myText,location,comment);
	        PersistenceManager pm = PMF.get().getPersistenceManager();
	        try {
	            pm.makePersistent(store);
	        } finally {
	            pm.close();
	        }
	        
//		}
        resp.sendRedirect("/read.jsp");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}       
	}

    
}