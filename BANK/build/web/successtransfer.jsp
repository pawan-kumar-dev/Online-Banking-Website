<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TRANSFER</title>
         <link href="maincss.css" rel="stylesheet"/></head>
    <body><div  class="topnav">
         <div style="float:left;"><img src="banklo.png" style="height: 100px; width: 300px; padding-top: 10px; padding-left: 10px;" alt="TransaQ BANK"/></div>
         <div style="float:left;padding-top: 50px; padding-left: 100px;"><h1><b><u>Transfer Amount</u></b></h1></div>
        <div class="dropdown" style="float:right; padding-top: 50px;"><img src="navi.svg" alt="Navigation" style="height:50px; width: 80px; cursor: pointer;"/>
         <div class="content">
            <a href="welcome.jsp" class="bt"><button class="btd">HOME</button></a>
              <a href="aadhar.html" class="bt"><button class="btd">AADHAR<br>UPDATE</button></a>
            <a href="cheque.jsp" class="bt"><button class="btd">CHEQUE<br>REQUEST</button></a>
            <a href="contact.html" class="bt"><button class="btd">CONTACT US</button></a>
            <a href="personalloan.html" class="bt"><button class="btd">APPLY FOR<br>LOAN</button></a>
            <a href="transactionhistory.jsp" class="bt"><button class="btd">VIEW<br>TRANSACTION<br>HISTORY</button></a>
             <a href="update.html" class="bt"><button class="btd">UPDATE<br>DETAILS</button></a>
            <a href="logout.jsp" class="bt"><button class="btd">LOGOUT</button></a>
         </div></div></div><br><br><br><br>
        <%
        HttpSession userid=request.getSession();
            String uid="";
            if(userid!=null){
            uid=(String)userid.getAttribute("username");}
            HttpSession useraccount=request.getSession();
            String acc="";
            if(useraccount!=null){
                acc=(String)useraccount.getAttribute("useracc");}
              HttpSession transactionId=request.getSession();
            String transacId="";
            if(transactionId!=null){
                transacId=(String)transactionId.getAttribute("transacId");}
            try{
                 Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/Bank","root","root");
        Statement welcome=conn.createStatement();
        ResultSet welogin=welcome.executeQuery("select * from customer where customerid='"+uid+"';");
        if(welogin.next()){
            %>
    <center><table><tr><td>
                    <%="<b>AMOUNT SUCCESSFULLY SEND TO "+acc+"<br><br>"%>
                </td></tr><tr><td>
                    <%="TRANSACTION ID : "+transacId+"<br><br>"%>
                </td></tr><tr><td>
                    <%="YOUR CURRENT BALANCE IS "+welogin.getDouble(11)+"</b>"%>
                </td></tr></table></center>
        <%
}else{
%><script>alert("SESSION HAS BEEN EXPIRED");
window.location.href="loginform.html"; </script><% }
}catch(Exception e){response.sendRedirect("errorpage.html");}
        %></body></html>