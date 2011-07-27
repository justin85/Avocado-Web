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
import javax.jdo.Query;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.Text;

public class Activityservlet extends HttpServlet {
	private static final Logger log = Logger.getLogger(Activityservlet.class.getName());

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


		Activitystore store = new Activitystore();

		Date tempStartDate;
		Date tempEndDate;
		Date systemdate=new Date();

		String[] info;
		String[] chunk = acti.split("##");
		for(int i=0;i<chunk.length;i++){
			info=chunk[i].split("&&");
			try {
				tempStartDate = df.parse(info[1]);
				tempEndDate = df.parse(info[2]);
				//				systemdate =df.parse(sysdate);
				Query q;
				PersistenceManager pm2 = PMF.get().getPersistenceManager();

				q = pm2.newQuery(Activitystore.class);
				q.setFilter("startDate==tempStartDate");
				q.setRange(0,500);
				q.declareParameters("Date tempStartDate");
				q.declareImports("import java.util.Date");
				List<Activitystore> datab = (List<Activitystore>) q.execute(tempStartDate);
				
				String[] tempNiceName = info[0].split("/");
				String niceName="";
				for(int j=0;j<tempNiceName.length;j++){
					if(!tempNiceName[j].contains("CLASSIFIED")){
						niceName += tempNiceName[j];
					}
				}
				if(datab.isEmpty()){
					store = new Activitystore(UID[0],tempStartDate,tempEndDate,info[0],niceName,chunk.length+"",info[3]);
					PersistenceManager pm = PMF.get().getPersistenceManager();
					pm.makePersistent(store);
				}else{
					updateEndDate(datab.get(0),tempEndDate);
				}
				pm2.close();

				//	        resp.sendRedirect("/read.jsp");
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}   



		}

	}
	public void updateEndDate(Activitystore activityStore, Date endDate) {
	    PersistenceManager pm = PMF.get().getPersistenceManager();
	    try {
            pm.currentTransaction().begin();
            // We don't have a reference to the selected Product.
            // So we have to look it up first,
            activityStore = pm.getObjectById(Activitystore.class, activityStore.getKey());
            activityStore.setEndDate(endDate);
            pm.makePersistent(activityStore);
            pm.currentTransaction().commit();
        } catch (Exception ex) {
            pm.currentTransaction().rollback();
            throw new RuntimeException(ex);
        } finally {
            pm.close();
        }

	}


}