<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--


-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.avocado.servlet.Datastore" %>
<%@ page import="com.avocado.servlet.testactivitystore" %>
<%@ page import="com.avocado.servlet.Userstore" %>
<%@ page import="com.avocado.servlet.PMF" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.jdo.Query" %>
<%@ page import="java.util.Arrays" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Avocado A.C</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="/css/loggerstyle.css" rel="stylesheet" type="text/css" media="screen" />


		<script language="JavaScript">

			function loadPage(list) {
				location.href=list.options[list.selectedIndex].value
			}
			function window(){
				alert("Select Item first to export data."); 
			}
		</script>
</head>
<body>

<!-- start header -->
<%

UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();

%>
<div id="header">
	<h1>Avocado</h1>
    <h2>Activity Classifier / Logger</h2>
<%
	if(user!=null){
%>
    <h3>Welcome, <%=user.getNickname() %>!</h3>
<%
	}
%>
</div>
<div id="menu">
    <ul>
        <li><a href="/index.jsp">Home</a></li>
        <li><a href="/aclog.jsp">Avocado A.C</a></li>
        <li class="current_page_item"><a href="/sensorlog.jsp">Avocado Logger</a></li>
        <li><a href="#">Download</a></li>
        <li><a href="https://github.com/kentaylor/ContextApi" target="_blank">GitHub</a></li>
        <li><a href="https://github.com/kentaylor/ContextApi/issues" target="_blank">Report</a></li>
<%
if (user == null) {
%>    	
        <li><a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Log-in</a></li>
<%
}else{
%>
		 <li><a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Log-out</a></li>
<%
}
%>
    </ul>
</div>
<!-- end header -->
<!-- start page -->
<div id="page">
				<!-- start sidebar -->
				<div id="sidebar">
					<ul>
						<li>
							<h2>Logger</h2>
							<ul>
								<li>　　<a href="/sensorlog.jsp">About Logger</a></li>
								<li>　　<a href="sensorlog.jsp">Logger Data</a></li>
								<li>　　<a href="#">Application Logs</a></li>
							</ul>
						</li>

					</ul>
				</div>
				<!-- end sidebar -->
           


                <!-- start content -->
				<div id="content">
					<div class="post">
<%
						PersistenceManager pm2 = PMF.get().getPersistenceManager();
						List<Userstore> userstore2 = new ArrayList<Userstore>();
						if (user != null) {
							String query2 = "select from " + Userstore.class.getName() + " where UID == '"+user.getNickname()+"'";
							userstore2 = (List<Userstore>) pm2.newQuery(query2).execute();
							if(!userstore2.isEmpty()){
							    if(userstore2.get(0).getPermission().equals("0")){
							    	String DefaultFrom="";
							    	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							    	Date defaultFrom= new Date();
                                    DefaultFrom = df.format(defaultFrom);
                                    String tempDate = request.getParameter("tempDate");
                                    String order = request.getParameter("order");
                                    String order1 = "";
                                    String orderDate = "";
                                    
                                    Date from1;
							    	Date from2;
							    	
                                    if(tempDate==null){
                                    	from1=df.parse(DefaultFrom);
                                    	orderDate = DefaultFrom;
                                    	
                                    }else{
                                    	from1=df.parse(tempDate);
                                    	
                                    }
                                    if(order==null){
                                    	order = "next";
                                    }
	
                                   
                                    
                                    
                                    
                                    Query q;
									PersistenceManager pm = PMF.get().getPersistenceManager();
									
									q = pm.newQuery(Datastore.class);
									if(order.equals("next")){
										q.setFilter("date < from1");
										q.setOrdering("date desc");
									}else{
										q.setFilter("date > from1");
										q.setOrdering("date asc");
									}
									
									q.setRange(0,10);
									q.declareImports("import java.util.Date");
									q.declareParameters("Date from1");
									
									List<Datastore> datastores = (List<Datastore>) q.execute(from1);
									
									Query tempq1;
									PersistenceManager temppm1 = PMF.get().getPersistenceManager();
									tempq1 = temppm1.newQuery(Datastore.class);
									tempq1.setOrdering("date desc");
									tempq1.setRange(0,1);
									List<Datastore> latest = (List<Datastore>) tempq1.execute();
									
									Query tempq2;
									PersistenceManager temppm2 = PMF.get().getPersistenceManager();
									tempq2 = temppm2.newQuery(Datastore.class);
									tempq2.setOrdering("date asc");
									tempq2.setRange(0,1);
									List<Datastore> origin = (List<Datastore>) tempq2.execute();
									
									String latestDate = df.format(latest.get(latest.size()-1).getDate());
									String originDate = df.format(origin.get(origin.size()-1).getDate());
									
							    	String excelDate="";	
							    	
									String Date1 = request.getParameter("Date1");
									String title = request.getParameter("Title");
						    		//PersistenceManager pm = PMF.get().getPersistenceManager();
						    		//String query = "select from " + Datastore.class.getName() + " order by date desc";
						    
						    		//List<Datastore> datastores = (List<Datastore>) pm.newQuery(query).execute();
						    
								    ArrayList<String> Acti = new ArrayList<String>(); 
								    ArrayList<String> TempActi = new ArrayList<String>();
								    ArrayList<String> IMEI = new ArrayList<String>(); 
								    ArrayList<String> FNS = new ArrayList<String>(); 
								    ArrayList<String> TempFNS = new ArrayList<String>(); 
								    ArrayList<String> Date = new ArrayList<String>();
								    ArrayList<String> TempDate = new ArrayList<String>();
								    ArrayList<String> text = new ArrayList<String>(); 
								    ArrayList<String> phone_location = new ArrayList<String>(); 
								    ArrayList<String> comment = new ArrayList<String>(); 
%>
								<div class="entry">
									<h1 class="title">Sensor Data</h1>
<%
								    int i=0;
								    int count=0;
						    		if (datastores.isEmpty()) {
%>
										<p>The datastores has no messages.</p>
<%
									}else{
										for (Datastore g : datastores) {
						
											Acti.add(g.getActi());
											IMEI.add(g.getIMEI());
											FNS.add(g.getFNS());
											Date.add(g.getDate()+"");
									    	
											for(int j=0;j<Date.size();j++){
												if(Date.get(j).equals(g.getDate()+"")){
													count++;
												}
											}
											if(count==1){
												TempDate.add(df.format(g.getDate()));
												TempActi.add(g.getCorrect());
												
											}
											
											count=0;
											i++;
										}
										
%>
<%
										if(order.equals("next")){
											if(latestDate.equals(TempDate.get(0))){
												orderDate = DefaultFrom;
												order1 = "next";
											}else{
												orderDate = TempDate.get(0);
												order1 = "pre";
											}
										}else{
										
											if(latestDate.equals(TempDate.get(TempDate.size()-1))){
												orderDate = DefaultFrom;
												order1 = "next";
											}else{
												orderDate = TempDate.get(TempDate.size()-1);
												order1 = "pre";
											}
										}
										%>
									    <FORM>
										Select Item:
										
											<a href="/sensorlog.jsp?tempDate=<%=orderDate%>&order=<%=order1%>">Previous</a>
										
										
											<select name="file" size="1"
											  onchange="loadPage(this.form.elements[0])"
											  target="_parent._top"
											  onmouseclick="this.focus()"
											  style="background-color:#ffffff">
												<option value>Select item</option>
												<option value> </option>
<%
												if(order.equals("next")){
													for(int j=0;j<TempDate.size();j++){
%>
														<option VALUE="/sensorlog.jsp?tempDate=<%=orderDate%>&Date1=<%=TempDate.get(j)%>&Title=<%=TempActi.get(j)%>"><%=TempDate.get(j) %>::<%=TempActi.get(j) %></option>
<%
													}
												}else{
													for(int j=TempDate.size()-1;j>-1;j--){
%>
														<option VALUE="/sensorlog.jsp?tempDate=<%=orderDate%>&Date1=<%=TempDate.get(j)%>&Title=<%=TempActi.get(j)%>"><%=TempDate.get(j) %>::<%=TempActi.get(j) %></option>
<%
													}
												}
%>
											</select>
											<%
											if(order.equals("next")){
											%>
												<a href="/sensorlog.jsp?tempDate=<%=originDate.equals(TempDate.get(TempDate.size()-1))?tempDate:TempDate.get(TempDate.size()-1)%>&order=next">Next</a>
											<%
											}else{
											%>
												<a href="/sensorlog.jsp?tempDate=<%=originDate.equals(TempDate.get(0))?tempDate:TempDate.get(0)%>&order=next">Next</a>
											<%
											}
											%>
										</FORM>
										
<%    
										if(Date1==null){
										}else{
%>
											<p><b>Date</b> :: <%=Date1 %> | <b>Title</b>::<%=title %> </p> 
<%
										}
								    	pm.close();
											    
								    	if(Date1==null){
											    
								    	}else{
											PersistenceManager pm1 = PMF.get().getPersistenceManager();
										
											Date d= df.parse(Date1);
														
											Query query1 = pm1.newQuery("select from " + Datastore.class.getName() + " where date == d");
											query1.declareImports("import java.util.Date");
											query1.declareParameters("Date d");
											
											List<Datastore> datastores1 = (List<Datastore>) query1.execute(d);
											if(!datastores1.isEmpty()){
												int jjj = 0;
												for(Datastore g : datastores1){
													
													TempFNS.add(g.getFNS());
													phone_location.add(g.getPhoneLocation());
													comment.add(g.getComment());
													//out.print(phone_location.get(jjj));
													//out.print(jjj);
													//jjj++;
												}
												
											}
											
											pm1.close();
										}
%>
										<div id="tableContainer" class="tableContainer">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" class="scrollTable">
											<thead class="fixedHeader">
												<tr>
													<th>Download</th>
													<th>Activity</th>
													<th>Phone Location</th>
													<th>Note</th>
												</tr>
											</thead>
	
											<tbody class="scrollContent">
								        		<tr>
<%
													if(Date1==null){
%>
														<td>Select File from the above drop-down list.</td>
								
<%			
													}else{
												       	String[] tempd = Date1.split(" ");
												       	excelDate=tempd[0]+"_"+tempd[1];
												  		
%>
														<td><a href="/export?filename=<%=title %>_<%=excelDate %>&date=<%=Date1 %>" STYLE="TEXT-DECORATION: NONE"><button>Export Excel File</button></a></td>
														<td><%= title %></td>
														<td><%= phone_location.isEmpty()?"Null":phone_location.get(0)%></td>
														<td><%= comment.isEmpty()?"Null":comment.get(0) %></td>
<%
													}
%>
												</tr>
									        </tbody>
											</table>
										</div>
<%
									
									}
%>
								</div>
	                        	<div class="entry">
	                        		<h1 class="title">Summary</h1>
	                            	Data summary service is not ready yet.
								</div>
<%
								}else{
%>
									<div class="entry">
										<h1 class="title">Sensor Data</h1>
										<p>Sorry, developers only. </p>
									</div>
<%
								}
							}else{
								%>
								<div class="entry">
									<h1 class="title">Sensor Data</h1>
									<p>Sorry, developers only. </p>
								</div>
<%
							}
						}else{
%>								
							<div class="entry">
								<h1 class="title">Sensor Data</h1>
								<p>Please log in.</p>
							</div>
<%
							}
%>
					
					</div>

				</div>
				<!-- end content -->
                <div style="clear:both">&nbsp;</div>
</div>
<!-- end page -->
<!-- start footer -->
<div id="footer">
	<p>Design & Icons by <a href="https://github.com/justin85/ContextApi">justin85</a>.</p>
</div>
<!-- end footer -->
</body>
</html>
