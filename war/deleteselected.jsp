<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.avocado.servlet.Activitystore" %>
<%@ page import="com.avocado.servlet.Userstore" %>
<%@ page import="com.avocado.servlet.PMF" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.jdo.Query" %>

<html xmlns="http://www.w3.org/1999/xhtml">


<head>
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <title>Activity Recorder::Delete Activity</title>
  <style type="text/css">
<!--
/* Terence Ordona, portal[AT]imaputz[DOT]com         */
/* http://creativecommons.org/licenses/by-sa/2.0/    */
ul#on {list-style-type:none; padding:0; margin:0; width:45em; height:5em; margin:0 auto;}
ul#on li {float:left; margin-right:0.2em;}
ul#on a {display:block; width:7em; height:1.5em; text-decoration:none; color:#000; border-bottom:0.5em solid #000;}
ul#on a:hover {border-bottom:0.5em solid #c00;}
ul#on a:active, ul#on a:focus {border-bottom:0.5em solid #00c; color:#00c;}

ul#off {list-style-type:none; padding:0; margin:0; width:63em; height:5em; margin:0 auto;}
ul#off li {display:block; width:10em; height:2em; float:left; margin-right:0.2em;}
ul#off a {display:block; width:10em; height:2em; position:relative; text-decoration:none; outline:0;}
ul#off a em {display:block; font-style:normal; width:10em; height:1.5em; color:#000; border-bottom:0.5em solid #000; position:absolute; top:0; left:0; cursor:pointer;}
ul#off a:hover {color:#c00;}
ul#off a:hover em {border-bottom:0.5em solid #c00;}
ul#off a:active, ul#off a:focus {width:0; height:0;}
ul#off a:active em, ul#off a:focus em {border-bottom:0.5em solid #00c; color:#00c;}

#info img {border:0;}
#info a.dots {display:block; width:88px; margin:0 auto;}
.image_holder {width:88px; height:150px; margin:0 auto;}
.image_holder a {display:block; width:0; height:0; position:relative; outline:0;}
.image_holder a img {position:absolute; left:0; top:0; border:0;}
.image_holder a:active {background:#eee;}
.image_holder a:active img, .image_holder a:focus img {background:#eec url(../graphics/arrow.gif) no-repeat top left; outline:0;}

.button {width:150px; height:50px; background:transparent url(../graphics/ready.gif); position:relative; margin:20px auto 100px auto;}
.button a {display:block; width:150px; height:50px; outline:0;}
.button a img {display:none;}
.button a:hover {background:url(../graphics/steady.gif);}
.button a:active, .button a:focus {position:absolute; width:0; height:0; top:0; left:0;}
.button a:active img, .button a:focus img {display:block; width:150px; height:50px;}

/* begin some basic styling here                     */
body {
	background: #FFF;
	color: #000;
	font: normal normal 12px Verdana, Geneva, Arial, Helvetica, sans-serif;
	margin: 10px;
	padding: 0
}

table, td, a {
	color: #000;
	font: normal normal 12px Verdana, Geneva, Arial, Helvetica, sans-serif
}

h1 {
	font: normal normal 18px Verdana, Geneva, Arial, Helvetica, sans-serif;
	margin: 0 0 5px 0
}

h2 {
	font: normal normal 16px Verdana, Geneva, Arial, Helvetica, sans-serif;
	margin: 0 0 5px 0
}

h3 {
	font: normal normal 13px Verdana, Geneva, Arial, Helvetica, sans-serif;
	color: #008000;
	margin: 0 0 15px 0
}
/* end basic styling                                 */

/* define height and width of scrollable area. Add 16px to width for scrollbar          */
div.tableContainer {
	clear: both;
	border: 1px solid #963;
	height: 285px;
	overflow: auto;
	width: 756px
}

/* Reset overflow value to hidden for all non-IE browsers. */
html>body div.tableContainer {
	overflow: hidden;
	width: 756px
}

/* define width of table. IE browsers only                 */
div.tableContainer table {
	float: left;
	width: 740px
}

/* define width of table. Add 16px to width for scrollbar.           */
/* All other non-IE browsers.                                        */
html>body div.tableContainer table {
	width: 756px
}

/* set table header to a fixed position. WinIE 6.x only                                       */
/* In WinIE 6.x, any element with a position property set to relative and is a child of       */
/* an element that has an overflow property set, the relative value translates into fixed.    */
/* Ex: parent element DIV with a class of tableContainer has an overflow property set to auto */
thead.fixedHeader tr {
	position: relative
}

/* set THEAD element to have block level attributes. All other non-IE browsers            */
/* this enables overflow to work on TBODY element. All other non-IE, non-Mozilla browsers */
html>body thead.fixedHeader tr {
	display: block
}

/* make the TH elements pretty */
thead.fixedHeader th {
	background: #C96;
	border-left: 1px solid #EB8;
	border-right: 1px solid #B74;
	border-top: 1px solid #EB8;
	font-weight: normal;
	padding: 4px 3px;
	text-align: left
}

/* make the A elements pretty. makes for nice clickable headers                */
thead.fixedHeader a, thead.fixedHeader a:link, thead.fixedHeader a:visited {
	color: #FFF;
	display: block;
	text-decoration: none;
	width: 100%
}

/* make the A elements pretty. makes for nice clickable headers                */
/* WARNING: swapping the background on hover may cause problems in WinIE 6.x   */
thead.fixedHeader a:hover {
	color: #FFF;
	display: block;
	text-decoration: underline;
	width: 100%
}

/* define the table content to be scrollable                                              */
/* set TBODY element to have block level attributes. All other non-IE browsers            */
/* this enables overflow to work on TBODY element. All other non-IE, non-Mozilla browsers */
/* induced side effect is that child TDs no longer accept width: auto                     */
html>body tbody.scrollContent {
	display: block;
	height: 262px;
	overflow: auto;
	width: 100%
}

/* make TD elements pretty. Provide alternating classes for striping the table */
/* http://www.alistapart.com/articles/zebratables/                             */
tbody.scrollContent td, tbody.scrollContent tr.normalRow td {
	background: #FFF;
	border-bottom: none;
	border-left: none;
	border-right: 1px solid #CCC;
	border-top: 1px solid #DDD;
	padding: 2px 3px 3px 4px
}

tbody.scrollContent tr.alternateRow td {
	background: #EEE;
	border-bottom: none;
	border-left: none;
	border-right: 1px solid #CCC;
	border-top: 1px solid #DDD;
	padding: 2px 3px 3px 4px
}

/* define width of TH elements: 1st, 2nd, and 3rd respectively.          */
/* Add 16px to last TH for scrollbar padding. All other non-IE browsers. */
/* http://www.w3.org/TR/REC-CSS2/selector.html#adjacent-selectors        */
html>body thead.fixedHeader th {
	width: 200px
}

html>body thead.fixedHeader th + th {
	width: 240px
}

html>body thead.fixedHeader th + th + th {
	width: 316px
}

/* define width of TD elements: 1st, 2nd, and 3rd respectively.          */
/* All other non-IE browsers.                                            */
/* http://www.w3.org/TR/REC-CSS2/selector.html#adjacent-selectors        */
html>body tbody.scrollContent td {
	width: 200px
}

html>body tbody.scrollContent td + td {
	width: 240px
}

html>body tbody.scrollContent td + td + td {
	width: 300px
}
-->
</style>
</head><body>


<div><br/></div>
<ul id="off">
<li><a href="http://activity.urremote.com/index.jsp"><em>Home</em></a></li>
<li><a href="http://activity.urremote.com/actihistory.jsp"><em>Activity History</em></a></li>
<li><a href="http://activity.urremote.com/read.jsp"><em>Sensor Data</em></a></li>
<li><a href="https://github.com/kentaylor/ContextApi"><em>GitHub</em></a></li>
<li><a href="https://appengine.google.com/dashboard?&app_id=testingjungoo"><em>GAE Dashboard</em></a></li>
<li><a href="http://activity.urremote.com/guestbook.jsp"><em>Guestbook</em></a></li>
</ul>
<p>Hi</p>
<%
String key = request.getParameter("q");
String[] items = key.split(",");

DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
List<Activitystore> datastores1 = new ArrayList<Activitystore>();
int size = items.length;
PersistenceManager pm1 = PMF.get().getPersistenceManager();
for(int i=0;i<size;i++){

	String[] dateArray = items[i].split("[- :]");
	String date ="";
	for(int j=0;j<dateArray.length;j++){
		if(j==dateArray.length-1){
			date+=dateArray[j];
		}else{
			date+=dateArray[j]+",";
		}
	}
	int[] dateIntArray = new int[6];
	String[] temp = date.split(",");
	for(int j=0;j<6;j++){
		dateIntArray[j]=Integer.parseInt(temp[j]);
	}
	
	Date d= df.parse(items[i]);
	
	Query query = pm1.newQuery("select from " + Activitystore.class.getName() + " where startDate == d");
	query.declareImports("import java.util.Date");
	query.declareParameters("Date d");
	
	
	List<Activitystore> datastores = (List<Activitystore>) query.execute(d);
	
	
	for(int k=0;k<datastores.size();k++){
		datastores1.add(datastores.get(k));
	}
	
	
}
for(int i=0;i<datastores1.size();i++){
%><p>Total <b><%=datastores1.get(i).getStartDate() %></b> <b><%=datastores1.get(i).getActi() %></b></p><%
}
%><p>Total <b><%=datastores1.size() %></b> items were deleted.</p><%
pm1.deletePersistentAll(datastores1);
response.sendRedirect("/aclog.jsp");
%>

  </body>


</html>
