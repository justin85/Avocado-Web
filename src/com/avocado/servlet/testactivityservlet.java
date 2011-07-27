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

public class testactivityservlet extends HttpServlet {
	private static final Logger log = Logger.getLogger(testactivityservlet.class.getName());
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		InputStream is = req.getInputStream();
		String acti = req.getHeader("message");
		String tsize =req.getHeader("size");
		int size = Integer.parseInt(tsize);
		String sysdate =req.getHeader("sysdate");
//		String UID = req.getHeader("UID");
		String ID = req.getHeader("UID");
		String[] UID = ID.split("@");
//		Date date = ;
		StringBuffer put = new StringBuffer();
		byte[] B = new byte[5069];
		for(int N; (N = is.read(B)) != -1;){
			put.append(new String(B, 0, N));
		}

	        Text myText = new Text(put.toString());
	        
	        
		testactivitystore store = new testactivitystore();
		Date date;
		Date systemdate=new Date();
		
		String[] info;
		String[] chunk = acti.split("##");
		for(int i=0;i<size;i++){
			info=chunk[i].split("&&");
			try {
				date = df.parse(info[1]);
//				systemdate =df.parse(sysdate);
				store = new testactivitystore(UID[0],date,info[0],tsize,info[2]);
				PersistenceManager pm = PMF.get().getPersistenceManager();
		        
		            pm.makePersistent(store);
		        
		        
//	        resp.sendRedirect("/read.jsp");
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}   
	        
	        

		}

    
	}

    
}