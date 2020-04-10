<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AADHAR UPDATE</title>
        <link href="maincss.css" rel="stylesheet"/>
    </head>
    <body>
       <div  class="topnav">
         <div style="float:left;"><img src="banklo.png" style="height: 100px; width: 300px; padding-top: 10px; padding-left: 10px;" alt="TransaQ BANK"/></div>
         <div style="float:left;padding-top: 50px; padding-left: 20px;"><h1><b><u>UPDATE YOUR AADHAR</u></b></h1></div>
         <div class="dropdown" style="padding-top: 50px;"><img src="navi.svg" alt="Navigation" style="height:50px; width: 80px; cursor: pointer;"/>
         <div class="content">
             <a href="welcome.jsp" class="bt"><button class="btd">HOME</button></a>
             <a href="cheque.jsp" class="bt"><button class="btd">CHEQUE<br>REQUEST</button></a>
             <a href="contact.html" class="bt"><button class="btd">CONTACT US</button></a>
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
            try{
                String aadhrno=request.getParameter("aadharno");
                if(aadhrno.isEmpty()){
                    response.sendRedirect("aadhar.html");
                }else{
             Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/Bank","root","root");
        Statement welcome=conn.createStatement();
        ResultSet welogin=welcome.executeQuery("select * from customer where customerid='"+uid+"';");
        if(welogin.next()){
            Statement aadharother=conn.createStatement();
            ResultSet rsaadharother=aadharother.executeQuery("select * from customer where aadhar='"+aadhrno+"' and not customerid='"+uid+"';");
            if(rsaadharother.next()){
                %><%="<center><b>IT SEEMS THE ENTERED AADHAR IS LINKED TO ANOTHER ACCOUNT<br>"
                        + "<a href=aadhar.html>CLICK HERE TO GO BACK.</a></b></center><br><br><br><br>"%><%
            }
            else if(welogin.getString(7)!=null){
            %><%="<center><b>AADHAR ALREADY UPDATED<br>CHECK YOUR ACCOUNT DETAILS</b></center><br><br><br><br>"%><%
         Statement alupdate=conn.createStatement();
         ResultSet rsalupdate=alupdate.executeQuery("select * from customer where customerid='"+uid+"';");
         if(rsalupdate.next()){
         %>
<details class="extra"><summary>View Account Details</summary> 
                            <%="<hr>Name. "+rsalupdate.getString(1).toUpperCase()+"<br><hr>"%>
                            <%="Account No. "+rsalupdate.getString(6)+"<br><hr>"%>
                            <%="Account Type. "+rsalupdate.getString(5).toUpperCase()+"<br><hr>"%>
                            <%="Customer Id. "+rsalupdate.getString(8)+"<br><hr>"%>
                            <%="Phone No. "+rsalupdate.getString(2)+"<br><hr>"%>
                            <%="Address and Pincode. "+rsalupdate.getString(9).toUpperCase()+" "+rsalupdate.getString(12)+"<br><hr>"%>
                            <%="Email Address. "+rsalupdate.getString(3).toLowerCase()+"<br><hr>"%>
                            <%="Account created on. "+rsalupdate.getString(10)+"<br><hr>"%>
                            <%="Aadhar number. "+rsalupdate.getString(7)%></details><%
}}else{
PreparedStatement aadharup=conn.prepareStatement("update customer set aadhar=? where customerid=?;");
aadharup.setString(1,aadhrno);
aadharup.setString(2,uid);
int aadupdated=aadharup.executeUpdate();
if(aadupdated!=0){  %>
<%="<center><b>AADHAR UPDATED<br>CHECK YOUR ACCOUNT DETAILS</b></center><br><br><br><br>"%><%
     Statement updated=conn.createStatement();
         ResultSet rsupdated=updated.executeQuery("select * from customer where customerid='"+uid+"';");
         if(rsupdated.next()){%>
<details class="extra"><summary>View Account Details</summary> 
                            <%="<hr>Name. "+rsupdated.getString(1).toUpperCase()+"<br><hr>"%>
                            <%="Account No. "+rsupdated.getString(6)+"<br><hr>"%>
                            <%="Account Type. "+rsupdated.getString(5).toUpperCase()+"<br><hr>"%>
                            <%="Customer Id. "+rsupdated.getString(8)+"<br><hr>"%>
                            <%="Phone No. "+rsupdated.getString(2)+"<br><hr>"%>
                            <%="Address and Pincode. "+rsupdated.getString(9).toUpperCase()+" "+rsupdated.getString(12)+"<br><hr>"%>
                            <%="Email Address. "+rsupdated.getString(3).toLowerCase()+"<br><hr>"%>
                            <%="Account created on. "+rsupdated.getString(10)+"<br><hr>"%>
                            <%="Aadhar number. "+rsupdated.getString(7)%></details>                        
<%    
      }}  }}else{%><script>
            alert("SESSION HAS BEEN EXPIRED");
            window.location.href="loginform.html"; </script><%
}}}catch(Exception e){response.sendRedirect("errorpage.html");}%>
</body></html>