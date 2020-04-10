<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>REGISTERED</title><link href="maincss.css" rel="stylesheet"/></head>
    <body>
         <div  class="topnav">
         <div style="float:left;"><a href="index.html"><img src="banklo.png" style="height: 100px; width: 300px; padding-top: 10px; padding-left: 10px;" alt="TransaQ BANK"/></a></div>
         <div style="float:left;padding-top: 20px;"><h1><b><u>SUCCESSFULLY REGISTERED TO <br>TransaQ BANK</u></b></h1></div></div><br><br>
        <div><%
            HttpSession registered=request.getSession();
            String uid="";
            if(registered!=null){
            uid=(String)registered.getAttribute("username");}
            try{
             Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/Bank","root","root");
        Statement register=conn.createStatement();
        ResultSet showuid=register.executeQuery("select * from customer where customerid='"+uid+"';");
        if(showuid.next()){%>
            <h2 style="font-weight: bold; text-align: center;text-decoration: underline;"><center>DEAR CUSTOMER YOU ARE SUCCESSFULLY REGISTERED<br>
                    YOUR USER ID IS</h2><h1 style="font-weight: bolder; text-align: center; text-decoration: blink; text-orientation: sideways-right"><%=showuid.getString(8)%></h1> <h2 style="font-weight: bold; text-align: center;text-decoration: underline;">
                        USE IT TO LOGIN INTO YOUR ACCOUNT<br><br><a href="loginform.html"><button value="LOGIN">LOGIN</button></a></center> </h2> </div>
                <br><br><%   }        registered.removeAttribute("username");
                   registered.invalidate();
}catch(Exception e){%><jsp:forward page="errorpage.html"/><%}
%></body></html>