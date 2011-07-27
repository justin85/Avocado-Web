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
<link href="/css/permissionstyle.css" rel="stylesheet" type="text/css" media="screen" />
<script language="JavaScript">

window.onload=init;
	


function loadPage(list) {

  location.href=list.options[list.selectedIndex].value

}
function checkall(){
	var a = document.getElementsByName("t1")
	var b = document.getElementsByName("t2")
	var a_count = a.length
	if(b[0].checked){
		for (i=0 ; i < a_count;i++){
			a[i].checked = true;
		}
	}else{
		for (i=0 ; i < a_count;i++){
			a[i].checked = false;
		}
	}
}
function deleteSubmit(){
	var doIt=confirm('Are you sure you want to delete selected records?');
	if(doIt){
		var a = document.getElementsByName("t1")
		var a_count = a.length
		var val = ""
		var all_val = ""
		var items = new Array();
		var count =1;
		for (i=0 ; i < a_count;i++){
		
			all_val = all_val + a[i].value + ","
		
			if (a[i].checked == true){
		
				val = val + a[i].value + ","
				items[count]=a[i].value;
				count++;
			}
		}
	 	
		document.body.innerHTML += '<form id="dynForm" action="/deleteselected.jsp" method="post"><input type="hidden" name="q" value="'+val+'"></form>';
		document.getElementById("dynForm").submit();
	}else{
		
	}

}
function this(state){
	var disState = state == 1;
	alert(disState);
	}
function setPermission(){
	
	var a = document.getElementsByName("t1")
	var a_count = a.length
	var val = ""
	var all_val = ""
	var items = new Array();
	var count =1;
	
	for (i=0 ; i < a_count;i++){
	
		all_val = all_val + a[i].value + ","
	
		if (a[i].checked == true){
	
			val = val + a[i].value + ","
			items[count]=a[i].value;
			count++;
		}
	}
	
	if(document.permission.level.value==1){
		var doIt=confirm('Developer permission is selected. Continue?');
		if(doIt){
			var Permission = "0";
			document.body.innerHTML += '<form id="dynForm" action="/permissionservlet" method="post"><input type="hidden" name="q" value="'+val+'"><input type="hidden" name="Permission" value="'+Permission+'"></form>';
			document.getElementById("dynForm").submit();
		}else{
			
		}
	}
	else if(document.permission.level.value==2){
		var doIt=confirm('Developer permission is selected. Continue?');
		if(doIt){
			var Permission = "1";
			document.body.innerHTML += '<form id="dynForm" action="/permissionservlet" method="post"><input type="hidden" name="q" value="'+val+'"><input type="hidden" name="Permission" value="'+Permission+'"></form>';
			document.getElementById("dynForm").submit();
		}else{
			
		}
	}
	

}


-->
            
</script>

</head>
<body>

<!-- start header -->
<%

UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();
PersistenceManager pm1 = PMF.get().getPersistenceManager();
List<Userstore> userstore1 = new ArrayList<Userstore>();
if(user!=null){
	String query = "select from " + Userstore.class.getName() + " where UID == '"+user.getNickname()+"'";
	userstore1 = (List<Userstore>) pm1.newQuery(query).execute();
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
						if(!userstore1.isEmpty()){
							if(userstore1.get(0).getPermission().equals("0")){
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
					<div class="post">
                    	<div class="entry">
							<h1 class="title">Permission Setting</h1>
<%
								if(user != null){
									if(userstore1.get(0).getPermission().equals("0") || user.getNickname().equals("jungoo8512")){
										PersistenceManager pm = PMF.get().getPersistenceManager();
							    		String query = "select from " + Userstore.class.getName() + " order by UID asc";
							    
							    		List<Userstore> userstore = (List<Userstore>) pm.newQuery(query).execute();
%>					    	
								    	
										<div id="tableContainer" class="tableContainer">
											<table border="0" cellpadding="0" cellspacing="0" width="100%" class="scrollTable">
												
												<thead class="fixedHeader">
													<tr>
														<th><INPUT onClick="checkall()" TYPE="checkbox" NAME="t2" id="t2" value=""></INPUT></th>
														<th>UID</th>
														<th>IMEI</th>
														<th>Model</th>
														<th>Permission</th>
													</tr>
												</thead>
												<tbody class="scrollContent">
<%   		    
										String date;
										String permission = "";
										
										for(int i=0;i<userstore.size();i++){
											if(userstore.get(i).getPermission().equals("0")){
												permission = "Developer";
											}
											else if(userstore.get(i).getPermission().equals("1")){
												permission = "Viewer";
											}
											if(userstore.get(i).getUID().equals(user.getNickname())){
%>
									
					       							<tr>
												  		<td><INPUT TYPE="checkbox" NAME="t1" id="t1" value="<%= userstore.get(i).getUID() %>"></INPUT></td>
														<td><b><%= userstore.get(i).getUID()%></b></td>
														<td><b><%= userstore.get(i).getIMEI()%></b></td>
														<td><b><%= userstore.get(i).getModel()%></b></td>
														<td><b><%= permission %></b></td>
													</tr>
													
<%
											}
											else{
%>
													<tr>
												  		<td><INPUT TYPE="checkbox" NAME="t1" id="t1" value="<%= userstore.get(i).getUID() %>"></INPUT></td>
														<td><%= userstore.get(i).getUID()%></td>
														<td><%= userstore.get(i).getIMEI()%></td>
														<td><%= userstore.get(i).getModel()%></td>
														<td><%= permission %></td>
													</tr>
<%
											}
										}
%>
												</tbody>
											</table>
										</div>
									<FORM name="permission">
										Select Item:
											<select name="level" size="1"
											  onchange="setPermission();"
											  target="_parent._top"
											  onmouseclick="this.focus()"
											  style="background-color:#ffffff">
											  	<option value="0">Select Permission</option>
												<option value="1">Developer</option>
												<option value="2">Viewer</option>
											</select>
									</FORM>	
<%
									}else{
%>
										<p>Developers only.</p>
										<p>If you have problems, , please contact <a href="u4775375@anu.ed.au">Justin</a> :)</p>
<%
									}
								}
%>	
										
                        </div>
                        
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
