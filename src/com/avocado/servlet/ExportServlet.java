package com.avocado.servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.write.WriteException;

/**
 * 
 * @author <a href="mailto:jeremy.wallez@z80.fr>Jeremy Wallez</a>
 * @version 1.0
 */
public class ExportServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			/* Get Excel Data */
			String date = request.getParameter("date");
			String filename = request.getParameter("filename");
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			PersistenceManager pm1 = PMF.get().getPersistenceManager();
			ArrayList<String> str = new ArrayList<String>();
			Date d= df.parse(date);
		    ArrayList<String> text = new ArrayList<String>(); 
			Query query1 = pm1.newQuery("select from " + Datastore.class.getName() + " where date == d order by FNS asc");
			query1.declareImports("import java.util.Date");
			query1.declareParameters("Date d");
			
			
			List<Datastore> datastores1 = (List<Datastore>) query1.execute(d);
			for(Datastore g : datastores1){
				str.add(g.getMyText().getValue());
			}
			pm1.close();
//			for(int k=0; k<str.size(); k++)  
//				
//		    {  
//		  		    String line = str.get(k);
//		  			//out.print(line);
//		  			String[] lines = line.split("&");
//		  			String merge ="";
//		  			for(int a=0;a<lines.length;a++){
//		  				merge+=lines[a]+"$";
//		      			
//		      			 }
//		      			 text.add(merge);
//		    }

			
			ByteArrayOutputStream bytes = new ExportService().generateExcelReport(str);
			/* Initialize Http Response Headers */
			response.setHeader("Content-disposition", "attachment; filename="+filename+".xls");
			response.setContentType("application/vnd.ms-excel");
			
			/* Write data on response output stream */
			if (bytes != null) {
				response.getOutputStream().write(bytes.toByteArray());
			}
		} catch (WriteException e) {
			response.setContentType("text/plain");
			response.getWriter().print("An error as occured");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}