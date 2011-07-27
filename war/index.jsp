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
<%@ page import="com.avocado.servlet.Greetingstore" %>
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
<link href="/css/style1.css" rel="stylesheet" type="text/css" media="screen" />


</head>
<body>

<!-- start header -->
<%

UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();
PersistenceManager pm = PMF.get().getPersistenceManager();
List<Userstore> userstore = new ArrayList<Userstore>();
if(user!=null){
	String query = "select from " + Userstore.class.getName() + " where UID == '"+user.getNickname()+"'";
	userstore = (List<Userstore>) pm.newQuery(query).execute();
}
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
        <li class="current_page_item"><a href="/index.jsp">Home</a></li>
        <li><a href="/aclog.jsp">Avocado A.C</a></li>
        <li><a href="/sensorlog.jsp">Avocado Logger</a></li>
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
							<h2>Activity Classifier</h2>
							<ul>
								<li>　　<a href="/aclog.jsp">About Activity Classifier</a></li>
								<li>　　<a href="/aclog.jsp">Activity Logs</a></li>
								<li>　　<a href="#">Application Logs</a></li>
							</ul>
						</li>
					</ul>
                    <ul>
						<li>
							<h2>Logger</h2>
							<ul>
								<li>　　<a href="/sensorlog.jsp">About Logger</a></li>
								<li>　　<a href="/sensorlog.jsp">Sensor Data</a></li>
								<li>　　<a href="#">Application Logs</a></li>
							</ul>
						</li>
					</ul>
                    <ul>
						<li>
							<h2>Download</h2>
							<ul>
								<li>　　<a href="#">Developer Only</a></li>
							</ul>
						</li>
					</ul>
<%
					if(user != null){
						if(!userstore.isEmpty()){
							if(userstore.get(0).getPermission().equals("0") || user.getNickname().equals("jungoo8512")){
%>
					<ul>
						<li>
							<h2>Administrator</h2>
							<ul>
								<li>　　<a href="/permission.jsp">Permission</a></li>
							</ul>
						</li>
					</ul>
<%
							}
						}
					}
%>					
				</div>
				<!-- end sidebar -->
 

                <!-- start content -->
				<div id="content">
				<!-- 
					<div class="post">
                    	<div class="entry">
							<h1 class="title">What is Avocado Activity Classifier?</h1>
						
                        </div>
						
						
                        <div class="entry">
                        	<h1 class="title">What is Avocado Logger?</h1>
                            
						</div>
						
					</div>
				 -->
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
