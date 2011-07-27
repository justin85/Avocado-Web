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
<%@ page import="com.avocado.servlet.Activitystore" %>
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
    <script src="/js/raphael.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/g.raphael.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/g.pie.js" type="text/javascript" charset="utf-8"></script>

<script language="JavaScript">

window.onload=init;
	
function init(){

	percentage();
	date_selector.init(window.document.forms['form1']);
}

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


function percentage() {
	var r = Raphael("percentage");
	r.g.txtattr.font = "12px 'Fontin Sans', Fontin-Sans, sans-serif";
	r.g.text(250, 30, "Activities Time Spent").attr({"font-size": 20});
	val1 = val1/1000;
	val2 = val2/1000;
	val3 = val3/1000;
	val4 = val4/1000;
	val5 = val5/1000;
	val6 = val6/1000;
	val7 = val7/1000;
	var valArray = [val1,val2,val3,val4,val5,val6,val7];
	var strValArray = ["","","","","","",""];
        
	for(var i = 0; i<valArray.length; i++){
		if(valArray[i]>=60){
			var sec =0;
			sec = valArray[i]%60;
			valArray[i]=parseInt(valArray[i]/60);
			if(valArray[i]>=60){
				var min =0;
				min = valArray[i]%60;
				valArray[i]=parseInt(valArray[i]/60);
				if(valArray[i]>=60){
					var hour=0;
					hour = valArray[i]%60;  
					valArray[i]=parseInt(valArray[i]/60);
					strValArray[i]=valArray[i]+" days"+hour+" hours "+min+" mins "+sec+" secs"              			
				}else{
					strValArray[i]=valArray[i]+" hours "+min+" mins "+sec+" secs"
				}
			}else{
				strValArray[i]=valArray[i]+" mins "+sec+" secs"
			}	
		}else{
			strValArray[i]=valArray[i]+" secs";
		}
	} 
	var pie = r.g.piechart(150, 130, 70, [val1,val2,val3,val4,val5,val6,val7], {legend: ["%%.%% – Unknown :: "+strValArray[0], "%%.%% – Uncarried :: "+strValArray[1],"%%.%% – Walking :: "+strValArray[2],"%%.%% – Stationary :: "+strValArray[3],"%%.%% – Paddling :: "+strValArray[4],"%%.%% – Travelling :: "+strValArray[5],"%%.%% – Charging :: "+strValArray[6]], legendpos: "east"});
	pie.hover(function () {
		this.sector.stop();
		this.sector.scale(1.1, 1.1, this.cx, this.cy);
		if (this.label) {
			this.label[0].stop();
			this.label[0].scale(1.5);
			this.label[1].attr({"font-weight": 800});
		}
	}, function () {
		this.sector.animate({scale: [1, 1, this.cx, this.cy]}, 500, "bounce");
		if (this.label) {
			this.label[0].animate({scale: 1}, 500, "bounce");
			this.label[1].attr({"font-weight": 400});
		}
	});
}
<!--
	var date_selector =   {
		frm:null,
		init:function(frm1){
			this.frm=frm1;
		},
		getMonthTable:function(year, month, date){
			var tableText = "";
			var months =
			[
	         "January", "February", "March", "April", "May", "June", "July",
	         "August", "September", "October", "November", "December"
			];
			var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
			month = (month == null || isNaN(month) ? null : month);
			if(year == null || isNaN(year) || month == null || isNaN(month)){
				var dt = new Date();
				year = dt.getFullYear();
				month = dt.getMonth();
				date = dt.getDate();
			}
			date = (date == null || isNaN(date) ? null : date);
			var previousMonth = new Date(year, month-1, 1);
			var nextMonth = new Date(year, month+1, 1);
			tableText =
			(
				"<table align=\"center\" id=\"dateSelector_sample\" \
				style=\"border-collapse:collapse;\" \
				cellpadding=\"1\" cellspacing=\"0\">\
				<tr>\
				<th style=\"cursor:pointer;text-align:left;\" \
				onclick=\"date_selector.updateDateSelectorPane("
				+previousMonth.getFullYear()+", "+previousMonth.getMonth()
				+");\">&#8592;</th>\
				<th style=\"text-align:center;\" colspan=\"4\">"+months[month]
				+", "+year+"</th>\
				<th style=\"cursor:pointer;text-align:right;\" \
				onclick=\"date_selector.updateDateSelectorPane("
				+nextMonth.getFullYear()+", "+nextMonth.getMonth()+");\">&#8594;</th>\
				<th style=\"text-align:right;cursor:pointer;\" \
				onclick=\"date_selector.updateDateElement();\">X</th>\
				</tr>"
			);
			for(var i=0; i<days.length; i++){
				tableText += "<th>"+days[i]+"</th>";
			}
			tableText += "</tr>";
			var tempDate;
			for(var i=1-(new Date(year, month, 1)).getDay();; i++){
				tempDate = new Date(year, month, i);
				if(tempDate.getDay() == 0){
				tableText += "<tr>";
				}
				tableText +=
				(
					"<td"+(tempDate.getMonth() == month ? " \
					onclick=\"date_selector.updateDateElement("
					+tempDate.getFullYear()+", "+
					tempDate.getMonth()+", "+tempDate.getDate()+");\""+
					(tempDate.getDate() == date
					? " style=\"border:solid 2px black;font-weight:bold;\"" : "")
					: " \
					style=\"color:silver;cursor:default;\"")+">"+
					tempDate.getDate()+
					"</td>"
				);
				if(tempDate.getDay() == 6){
					tableText += "</tr>";
				}
				tempDate = new Date(year, month, i+1);
				if(tempDate.getMonth() != month && tempDate.getDay() == 0){
					break;
				}
			}
			tableText += "</table>";
			return tableText;
		},
		updateDateSelectorPane:function(year, month, day){
			var d = document.getElementById("dateSelectorPane");
			d.innerHTML = this.getMonthTable(year, month, day);
			d.style.display = "block";
		},
		showDateSelector:function(elementName){
			if(elementName == null){
				this.updateDateSelectorPane();
			}else{
				this.dateElementToUpdate = elementName;
				var e = this.frm.elements[elementName];
				e = e.value.split("/");
				try{
					e[0] = parseInt(e[0], 10);
					e[1] = parseInt(e[1], 10);
					e[2] = parseInt(e[2], 10);
					this.updateDateSelectorPane(e[2], e[0]-1, e[1]);
				}catch(e){
					this.updateDateSelectorPane();
				}
			}
		},
		updateDateElement:function(year, month, day){
			document.getElementById("dateSelectorPane").style.display="none";
			if(year != null && month != null && day != null){
				month = (month+1)+"";
				day += "";
				month = (month.length == 1 ? "0"+month : month);
				day = (day.length == 1 ? "0"+day : day);
				this.frm.elements[this.dateElementToUpdate].value
				= (month+"/"+day+"/"+year);
			}
			this.dateElementToUpdate = null;
		},
		dateElementToUpdate:null
	};
function printDateRange(){
	var frm = date_selector.frm;
	var from = frm.minimumDate.value;
	var to =frm.maximumDate.value;
	document.body.innerHTML += '<form id="range" action="/aclog.jsp" method="post"><input type="hidden" name="from" value="'+from+'"><input type="hidden" name="to" value="'+to+'"></form>';
	document.getElementById("range").submit();
}
-->
            
</script>

</head>
<body>

<!-- start header -->
<%
DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
DateFormat df1 = new SimpleDateFormat("MM/dd/yyyy");
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
        <li class="current_page_item"><a href="/aclog.jsp">Avocado A.C</a></li>
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
								<li>　　<a href="aclog.jsp">About Activity Classifier</a></li>
								<li>　　<a href="aclog.jsp">Activity Logs</a></li>
								<li>　　<a href="aclog.jsp">Application Logs</a></li>
							</ul>
						</li>

					</ul>
				</div>
				<!-- end sidebar -->
       
       


                <!-- start content -->
				<div id="content">
					<div class="post">
<%
						if (user != null) {
%>
						<div class="entry">
							<h1 class="title">Activity Logs</h1>
<%
							String tempfrom = request.getParameter("from");
							String tempto = request.getParameter("to");
							String DefaultTo="";
							String DefaultFrom="";
							
%>    	
<%
                                //String id = request.getParameter("IMEI");
                                //String Model = request.getParameter("Model");

								if(tempfrom==null && tempto==null){
  									Query qu;
	   								PersistenceManager pm3 = PMF.get().getPersistenceManager();

                                    qu = pm3.newQuery(Activitystore.class);
                                    qu.setFilter("UID=='"+user.getNickname()+"'");
                                    qu.setOrdering("startDate desc");
                                    qu.setRange(0,2);
		
									List<Activitystore> recentTime = (List<Activitystore>) qu.execute();
									if(recentTime.size()!=0){
										DefaultTo = df1.format(recentTime.get(0).getStartDate());
                                    }else{
                                        Date defaultTo = new Date();
                                        DefaultTo = df1.format(defaultTo);
                                    }
                                    String[] tempDefaultFrom =DefaultTo.split("/");
                                    int tempday = Integer.parseInt(tempDefaultFrom[1])-2;
                                    int tempmonth = Integer.parseInt(tempDefaultFrom[0]);
                                    if(tempday==0 || tempday==-1){
                                        if(tempmonth==1){
                                        	tempmonth=12;
                                        }else{
                                        	tempmonth = tempmonth-1;
                                        }
                                        tempDefaultFrom[0]=tempmonth+"";
                                        tempday=30;
                                   	}
                                    String day;
                                    if(tempday<10) 
                                        day="0"+tempday;
                                    else
                                        day=""+tempday;
                                    
                                    DefaultFrom = tempDefaultFrom[0]+"/"+day+"/"+tempDefaultFrom[2];
	}
								ArrayList<String> IMEInum=new ArrayList<String>();
								ArrayList<String> PhoneModel=new ArrayList<String>();
							    PersistenceManager pm = PMF.get().getPersistenceManager();
						    	Query query;
						    	query = pm.newQuery(Userstore.class);
						   		query.setFilter("UID=='"+user.getNickname()+"'");
							    List<Userstore> users = (List<Userstore>) query.execute();
							    for(Userstore g : users){
							    	PhoneModel.add(g.getModel());
							    }
							    if(tempfrom == null&&tempto==null){
%>
			    				<form style="display:inline;" method="post" id="form1" name="form1">
      								<table style="border-collapse:collapse;vertical-align:top;" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<div style="text-align:center;">
													From : 
													<input type="text" name="minimumDate" style="width:75px;font-size:8pt;"
													value="<%=DefaultFrom %>">
													<input type="button" style="height:20px;width:20px;" value="▼"
													onclick="date_selector.showDateSelector('minimumDate');">
													To : 
													<input type="text" name="maximumDate" style="width:75px;font-size:8pt;"
													value="<%=DefaultTo %>">
													<input type="button" style="height:20px;width:20px;" value="▼"
													onclick="date_selector.showDateSelector('maximumDate' );">
													<button onclick=printDateRange()>Apply</button>
												</div>
												<div id="dateSelectorPane"></div>
											</td>
										</tr>
									</table>
								</form>
<%
								}else{
%>
			    					<form style="display:inline;" method="post" id="form1" name="form1">
      									<table style="border-collapse:collapse;vertical-align:top;" cellpadding="0" cellspacing="0">
											<tr>
												<td>
													<div style="text-align:center;">
													From : 
													<input type="text" name="minimumDate" style="width:75px;font-size:8pt;"
													value="<%=tempfrom %>">
													<input type="button" style="height:20px;width:20px;" value="▼"
													onclick="date_selector.showDateSelector('minimumDate');">
													To : 
													<input type="text" name="maximumDate" style="width:75px;font-size:8pt;"
													value="<%=tempto %>">
													<input type="button" style="height:20px;width:20px;" value="▼"
													onclick="date_selector.showDateSelector('maximumDate' );">
													<button onclick=printDateRange()>Apply</button>
													</div>
													<div id="dateSelectorPane"></div>
												</td>
											</tr>
										</table>
									</form>

<%
								}
%>

<%
								pm.close();
								
								if(tempfrom == null&&tempto==null){
								tempfrom=DefaultFrom;
								tempto=DefaultTo;
								}
								Date from1;
								Date to1;
								
								String[] Sfrom=tempfrom.split("/");
								String[] Sto=tempto.split("/");
								String from="";
								String to="";
								from=Sfrom[2]+"-"+Sfrom[0]+"-"+Sfrom[1]+" "+"00:00:00";
								to =Sto[2]+"-"+Sto[0]+"-"+Sto[1]+" "+"23:59:59";
								from1=df.parse(from);
								to1=df.parse(to);
								Query q;
								PersistenceManager pm2 = PMF.get().getPersistenceManager();
								
								q = pm2.newQuery(Activitystore.class);
								q.setFilter("UID=='"+user.getNickname()+"' && startDate > from1 && startDate < to1");
								q.setOrdering("startDate desc");
								q.setRange(0,500);
								q.declareImports("import java.util.Date");
								q.declareParameters("Date from1, Date to1");
								
								List<Activitystore> datab = (List<Activitystore>) q.execute(from1,to1);
								ArrayList<String> activityName = new ArrayList<String>();
								ArrayList<Long> activityPeriod = new ArrayList<Long>();
%>

	    						<div id="tableContainer" class="tableContainer">
									<table border="0" cellpadding="0" cellspacing="0" width="100%" class="scrollTable">
										
										<thead class="fixedHeader">
											<tr>
												<th><INPUT onClick="checkall()" TYPE="checkbox" NAME="t2" id="t2" value=""></INPUT></th>
												<th>Time</th>
												<th>Activity</th>
												<th>MET</th>
											</tr>
										</thead>
										<tbody class="scrollContent">
<%   		    
								String date;
								for(int i=0;i<datab.size();i++){
									long dateDiff =0;
									try{
										date=df.format(datab.get(i).getStartDate());
										if(!datab.get(i).getActi().equals("END")){
											long currDate = datab.get(i).getStartDate().getTime(); 
											long lastDate = datab.get(i).getEndDate().getTime(); 
											dateDiff = lastDate - currDate;
											activityName.add(datab.get(i).getNiceName());
											activityPeriod.add(dateDiff);
										}
%>
			       							<tr>
										  		<td><INPUT TYPE="checkbox" NAME="t1" id="t1" value="<%= date %>"></INPUT></td>
												<td><%= datab.get(i).getStartDate().toLocaleString()+" "+datab.get(i).getTimezone() %></td>
												<td><%= datab.get(i).getNiceName().contains("END")?"End of Previous Classifications":datab.get(i).getNiceName()%></td>
												<td></td>
											</tr>
						
<%
									}catch (Exception e) {
									// TODO Auto-generated catch block
										e.printStackTrace();
									}  
								}
%>
										</tbody>
					
										
									</table>
								</div>


								

								<p>To delete selected records, <button onclick=deleteSubmit()>Delete</button></p>
								<p><b>* Scroll Bar in above table might not work on certain web browser. </b></p>
								
								<p>Total <b><%=datab.size() %></b> records are showed. *You can see at most 500 records at a time. </p>
								<p>If you want delete your all records, <a href="/deleteActivity.jsp?UID=<%=user.getNickname()%>" onclick="return confirm('You sure you want to delete every record?');"><i>Click me!</i></a></p>
							

                           
                        	
						</div>
						<div style="clear:both">&nbsp;</div>
                        
                        <div class="entry">
                        	<h1 class="title">Summary</h1>
<%
								long UNKNOWN = 0;
								long UNCARRIED = 0;
								long WALKING = 0;
								long STATIONARY = 0;
								long PADDLING = 0;
								long TRAVELLING = 0;		
								long CHARGING = 0;
								int numUNKNOWN = 0;
								int numUNCARRIED = 0;
								int numWALKING = 0;
								int numSTATIONARY = 0;
								int numPADDLING = 0;
								int numTRAVELLING = 0;		
								int numCHARGING = 0;
							
								for(int i = 0;i<activityName.size();i++){
									if(activityName.get(i).contains("UNKNOWN")){
										UNKNOWN += activityPeriod.get(i);
										numUNKNOWN++;
									}else if(activityName.get(i).contains("UNCARRIED")){
										UNCARRIED += activityPeriod.get(i);
										numUNCARRIED++;
									}else if(activityName.get(i).contains("WALKING")){
										WALKING += activityPeriod.get(i);
										numWALKING++;
									}else if(activityName.get(i).contains("STATIONARY")){
										STATIONARY += activityPeriod.get(i);
										numSTATIONARY++;
									}else if(activityName.get(i).contains("PADDLING")){
										PADDLING += activityPeriod.get(i);
										numPADDLING++;
									}else if(activityName.get(i).contains("TRAVELLING")){
										TRAVELLING += activityPeriod.get(i);
										numTRAVELLING++;
									}else if(activityName.get(i).contains("CHARGING")){
										CHARGING += activityPeriod.get(i);
										numCHARGING++;
									}
								}
						
%>
								 <script type="text/javascript">
								 var val1 = <%=UNKNOWN%>
								 var val2 = <%=UNCARRIED%>
						 		 var val3 = <%=WALKING%>
								 var val4 = <%=STATIONARY%>
						 		 var val5 = <%=PADDLING%>
								 var val6 = <%=TRAVELLING%>
						 		 var val7 = <%=CHARGING%>

								 </script>

	 							<div id="percentage"></div>
								
						</div>

<%
								pm2.close();
							}else{
%>								<h1 class="title">Activity Logs</h1>
						
								<div class="entry">
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
	<p>Design by & Icons by <a href="https://github.com/justin85/ContextApi">justin85</a>.</p>
    
</div>
<!-- end footer -->
</body>
</html>
