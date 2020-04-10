<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CONTACT US</title><link href="maincss.css" rel="stylesheet"/></head>
    <body><div  class="topnav">
         <div id="topnav1" style="float:left;"><a href="index.html"><img src="banklo.png" style="height: 100px; width: 300px; padding-top: 10px; padding-left: 10px;" alt="TransaQ BANK"/></a></div>
         <div id="topnav1" style="float:left; padding-top:50px; padding-left: 100px;"><h1><b><u>CHEQUE REQUEST</u></b></h1></div>
        <div class="dropdown" style=" padding-top: 50px;"><img src="navi.svg" alt="Navigation" style="height:50px; width: 80px; cursor: pointer;"/>
         <div class="content">
              <a href="welcome.jsp" class="bt"><button class="btd">HOME</button></a>
             <a href="aadhar.html" class="bt"><button class="btd">AADHAR<br>UPDATE</button></a>
             <a href="cheque.jsp" class="bt"><button class="btd">CHEQUE REQUEST</button></a>
              <a href="personalloan.html" class="bt"><button class="btd">APPLY FOR<br>PERSONAL LOAN</button></a>
             <a href="transfer.html" class="bt"><button class="btd">TRANSFER<br>AMOUNT</button></a>
             <a href="transactionhistory.jsp" class="bt"><button class="btd">VIEW<br>TRANSACTION<br>HISTORY</button></a>
             <a href="update.html" class="bt"><button class="btd">UPDATE<br>DETAILS</button></a>
            <a href="logout.jsp" class="bt"><button class="btd">LOGOUT</button></a>
         </div></div></div><br><br>
        <%
         HttpSession userid=request.getSession();
            String uid="";
            if(userid!=null){
            uid=(String)userid.getAttribute("username");}
         HttpSession contact=request.getSession();
            String con="";
            if(contact!=null){
                con=(String)contact.getAttribute("queryid");}
            try{
            Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/Bank","root","root");
        Statement welcome=conn.createStatement();
        ResultSet welogin=welcome.executeQuery("select * from customer where customerid='"+uid+"';");
        if(welogin.next()){
        %>
    <center><table>
            <tr><td><%="<b>QUERY SUCCESSFULLY REGISTERED<br><br>"%></td>
            </tr>
            <tr><td><%="YOUR QUERY ID IS "+con+"<br><br>"%></td>
            </tr>
        </table></center>
        <%
Statement queryst=conn.createStatement();
        ResultSet query=queryst.executeQuery("select * from query where customerid='"+uid+"';");
%><%="<center><b>YOUR TOTAL QUERY IS <br><br>"%>
        <table border="1">
        <tr><th><h3>QUERY ID</h3></th><th><h3>QUERY</h3></th><th><h3>SUBMITTED ON</h3></th></tr><%
    while(query.next()){  %>
        <%="<tr><td>"+query.getString(1)+"</td><td><center>"+query.getString(3)+"</center></td><td>"+query.getString(4)+"</td></tr>"%><%
}%></table><%
    }else{%><script>
            alert("SESSION HAS BEEN EXPIRED");
            window.location.href="loginform.html";</script><%
}}catch(Exception e){response.sendRedirect("errorpage.html");}%>
</body></html>