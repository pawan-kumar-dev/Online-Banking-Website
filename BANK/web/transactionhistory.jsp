<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <link href="maincss.css" rel="stylesheet"/></head>
    <body><div  class="topnav">
         <div style="float:left;"><img src="banklo.png" style="height: 100px; width: 300px; padding-top: 10px; padding-left: 10px;" alt="TransaQ BANK"/></div>
         <div style="float:left;padding-top: 50px; padding-left: 100px;"><h1><b><u>TRANSACTION HISTORY</u></b></h1></div>
        <div class="dropdown" style="padding-top: 50px;"><img src="navi.svg" alt="Navigation" style="height:50px; width: 80px; cursor: pointer;"/>
         <div class="content">
            <a href="welcome.jsp" class="bt"><button class="btd">HOME</button></a>
             <a href="aadhar.html" class="bt"><button class="btd">AADHAR<br>UPDATE</button></a>
             <a href="cheque.jsp" class="bt"><button class="btd">CHEQUE<br>REQUEST</button></a>
             <a href="contact.html" class="bt"><button class="btd">CONTACT US</button></a>
              <a href="personalloan.html" class="bt"><button class="btd">APPLY FOR<br>PERSONAL LOAN</button></a>
              <a href="transfer.html" class="bt"><button class="btd">TRNSFER<br>AMOUNT</button></a>
             <a href="update.html" class="bt"><button class="btd">UPDATE<br>DETAILS</button></a>
            <a href="logout.jsp" class="bt"><button class="btd">LOGOUT</button></a>
         </div></div></div><br><br><br><br>
        <%
            HttpSession userid=request.getSession();
            String uid="";
            if(userid!=null){
            uid=(String)userid.getAttribute("username");}
            try{
             Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/Bank","root","root");
         Statement welcome=conn.createStatement();
        ResultSet welogin=welcome.executeQuery("select * from customer where customerid='"+uid+"';");
                if(welogin.next()){
        Statement transfer=conn.createStatement();
        ResultSet rstransfer=transfer.executeQuery("select * from transfer where toaccount='"+welogin.getString(6)+"' or fromaccount='"+welogin.getString(6)+"';");
        if(rstransfer.next()){
            %><center><table border="1"><th>TRANSACTION ID</th><th>AMOUNT</th><th>STATUS</th><th>FROM ACCOUNT</th><th>TO ACCOUNT</th><th>DATE</th><%
        Statement transac=conn.createStatement();
        ResultSet rstransac=transac.executeQuery("select * from transactionhistory where customerid='"+uid+"' and status='"+"Debited"+"';");  
        while(rstransac.next()){
%><%="<tr><td>"+rstransac.getString(1)+"</td><td>"+rstransac.getDouble(3)+"</td><td>Debited</td><td>"+rstransac.getString(6)%>
            <% Statement transid=conn.createStatement();
            ResultSet rstransid=transid.executeQuery("select * from transfer where transacID='"+rstransac.getString(1)+"';");
            if(rstransid.next()){ %>
                <%="</td><td>"+rstransid.getString(3)+"</td><td>"+rstransac.getString(4)+"</td></tr>"%><%
                      }}
Statement transac1=conn.createStatement();
        ResultSet rstransac1=transac1.executeQuery("select * from transactionhistory where customerid='"+uid+"' and status='"+"Credited"+"';");  
while(rstransac1.next()){
%><%="<tr><td>"+rstransac1.getString(1)+"</td><td>"+rstransac1.getDouble(3)+"</td><td>Credited</td>"%>
 <% Statement transid1=conn.createStatement();
            ResultSet rstransid1=transid1.executeQuery("select * from transfer where transacID='"+rstransac1.getString(1)+"';");
            if(rstransid1.next()){ %>
                 <%="<td>"+rstransid1.getString(6)+"</td></td><td>"+rstransid1.getString(3)+"</td><td>"+rstransac1.getString(4)+"</td></tr>"%><%
                      }%><%
}}else{
%><%="<tr><td><center>NO TRANSACTION PERFORMED YET....<br>"
        + "<a href=transfer.html>Click here to start your first transaction</a></center></td></tr>"%><%
}}
else{
%><script>alert("SESSION HAS BEEN EXPIRED");
window.location.href="loginform.html"; </script><% }
}catch(Exception e){
response.sendRedirect("errorpage.html");}
        %></table></center></body></html>