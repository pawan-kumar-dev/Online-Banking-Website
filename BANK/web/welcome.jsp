<%@page import="java.math.BigInteger"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>WELCOME PAGE</title>
        <link href="maincss.css" rel="stylesheet"/></head>
    <body><style>
            #view{padding: 0;background-color: lightcyan;}
        </style>
       <div  class="topnav">
         <div style="float:left;"><img src="banklo.png" style="height: 100px; width: 300px; padding-top: 10px; padding-left: 10px;" alt="TransaQ BANK"/></div>
         <div style="float:left;padding-top: 50px; padding-left: 20px;"><h1><b><u>WELCOME TO TransaQ BANK</u></b></h1></div>
         <div class="dropdown" style="float:right;padding-top: 50px;"><img src="navi.svg" alt="Navigation" style="height:50px; width: 80px; cursor: pointer;"/>
         <div class="content">
             <a href="aadhar.html" class="bt"><button class="btd">AADHAR<br>UPDATE</button></a>
             <a href="cheque.jsp" class="bt"><button class="btd">CHEQUE<br>REQUEST</button></a>
             <a href="contact.html" class="bt"><button class="btd">CONTACT US</button></a>
             <a href="personalloan.html" class="bt"><button class="btd">APPLY FOR<br>PERSONAL LOAN</button></a>
             <a href="transfer.html" class="bt"><button class="btd">TRANSFER<br>AMOUNT</button></a>
             <a href="transactionhistory.jsp" class="bt"><button class="btd">VIEW<br>TRANSACTION<br>HISTORY</button></a>
             <a href="update.html" class="bt"><button class="btd">UPDATE<br>DETAILS</button></a>
             <a href="logout.jsp" class="bt"><button class="btd">LOGOUT</button></a>
         </div></div></div><br><br>
        <% try{
            HttpSession userid=request.getSession();
            String uid="";
            if(userid!=null){
            uid=(String)userid.getAttribute("username");}
             Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/Bank","root","root");
        Statement welcome=conn.createStatement();
        ResultSet welogin=welcome.executeQuery("select * from customer where customerid='"+uid+"';");
        if(welogin.next()){
        %><div style="width: 100%;"><table style="display:inline-block; padding-bottom: 100px; padding-top: 100px;">
                <tr><td><b><u>NAME :</u></b></td>
                    <td><b><%=welogin.getString(1).toUpperCase()%></u></b></td>
                </tr>
                <tr><td><b><u>CUSTOMER ID :</u></b></td>
                    <td><b><%=welogin.getString(8)%></u></b></td>
                </tr>
                <tr><td><b><u>ACCOUNT TYPE :</u></b></td>
                    <td><b><%=welogin.getString(5).toUpperCase()%></u></b></td>
                </tr>
                <tr><td><b><u>ACCOUNT NUMBER :</u></b></td>
                    <td><b><%=welogin.getString(6)%></u></b></td>
                </tr>
            </table>
                <table style="display:inline-block;  padding-bottom: 50px; padding-top: 50px; padding-left: 100px;">
                        <tr><td style="height: 50px; width: 50px;">
                                <button id="view" onclick="view()"><img src="view.jpg" style="height: 70px; width: 100px;"/></button>
                            </td></tr><tr><td style="height: 50px; width: 50px;">
                                <b><div id="bal"></div></b></td></tr></table></div>
                    <script language="javascript">
    function view(){
        document.getElementById("bal").innerHTML="Your Account Balance is "+<%=(double)welogin.getDouble(11)%>;}
                        </script>
                        <details class="extra"><summary>View Extra Account Details</summary>
                            <%="<hr>Phone No. "+welogin.getString(2)+"<br><hr>"%>
                            <%="Address and Pincode. "+welogin.getString(9)+" "+welogin.getString(12)+"<br><hr>"%>
                            <%="Email Address. "+welogin.getString(3)+"<br><hr>"%>
                             <%="Account created on. "+welogin.getString(10)+"<br><hr>"%>
                            <%if(welogin.getString(7)==null){
%><%="Aadhar number not updated.<br><a href=aadhar.html>Kindly add your aadhar details</a><br>"%>
<%  }else{  %><%="Aadhar number. "+welogin.getString(7)%><%  }  %>
</details><%
        }else{%><script>
            alert("SESSION HAS BEEN EXPIRED");
            window.location.href="loginform.html"; </script>
<%
}}catch(Exception e){response.sendRedirect("errorpage.html");
}%></body></html>