<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <link href="maincss.css" rel="stylesheet"/></head>
    <body><div  class="topnav">
         <div style="float:left;"><img src="banklo.png" style="height: 100px; width: 300px; padding-top: 10px; padding-left: 10px;" alt="TransaQ BANK"/></div>
         <div style="float:left;padding-top: 50px; padding-left: 100px;"><h1><b><u>UPDATE YOUR DETAILS</u></b></h1></div>
        <div class="dropdown" style="float:right; padding-top: 50px;"><img src="navi.svg" alt="Navigation" style="height:50px; width: 80px; cursor: pointer;"/>
         <div class="content">
            <a href="welcome.jsp" class="bt"><button class="btd">HOME</button></a>
             <a href="aadhar.html" class="bt"><button class="btd">AADHAR<br>UPDATE</button></a>
             <a href="cheque.jsp" class="bt"><button class="btd">CHEQUE<br>REQUEST</button></a>
             <a href="contact.html" class="bt"><button class="btd">CONTACT US</button></a>
              <a href="personalloan.html" class="bt"><button class="btd">APPLY FOR<br>PERSONAL LOAN</button></a>
             <a href="transfer.html" class="bt"><button class="btd">TRANSFER<br>AMOUNT</button></a>
             <a href="transactionhistory.jsp" class="bt"><button class="btd">VIEW<br>TRANSACTION<br>HISTORY</button></a>
            <a href="logout.jsp" class="bt"><button class="btd">LOGOUT</button></a>
         </div></div></div><br><br><br><br>
        <%
             HttpSession userid=request.getSession();
            String uid="";
            if(userid!=null){
            uid=(String)userid.getAttribute("username");}
            try{
                String address,email,aadhar;
        double phone,pin;
        address=request.getParameter("add");
        email=request.getParameter("mail");
        aadhar=request.getParameter("aadhar");
        String strphone=request.getParameter("num");
        String strpin=request.getParameter("pincode");
        if(address.isEmpty()||aadhar.isEmpty()||email.isEmpty()||strphone.isEmpty()||strpin.isEmpty()){
        response.sendRedirect("update.html");}
        else{
            phone=Double.parseDouble(strphone);
            pin=Double.parseDouble(strpin);
            Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/Bank","root","root");
         Statement welcome=conn.createStatement();
        ResultSet welogin=welcome.executeQuery("select * from customer where customerid='"+uid+"';");
        if(welogin.next()){
           PreparedStatement update=conn.prepareStatement("update customer set address=?,email=?,aadhar=?,phone=?,pin=? where customerid=?;");
        update.setString(1,address);
        update.setString(2,email);
        update.setString(3,aadhar);
     update.setDouble(4,phone);
     update.setDouble(5,pin);
     update.setString(6,uid);
     int updated=update.executeUpdate();
     if(updated!=0){%>
         <%="<center><b><h1> Record Successfully Updated.<br> Your new Record is</h1></b> </center><br><br>"%>
         <% Statement afterupdate=conn.createStatement();
         ResultSet rsafterupdate=afterupdate.executeQuery("select * from customer where customerid='"+uid+"';");
         if(rsafterupdate.next()){
         %> <details class="extra"><summary>View Account Details</summary> 
                            <%="<hr>Name. "+rsafterupdate.getString(1).toUpperCase()+"<br><hr>"%>
                            <%="Account No. "+rsafterupdate.getString(6)+"<br><hr>"%>
                            <%="Account Type. "+rsafterupdate.getString(5).toUpperCase()+"<br><hr>"%>
                            <%="Customer Id. "+rsafterupdate.getString(8)+"<br><hr>"%>
                            <%="Phone No. "+rsafterupdate.getString(2)+"<br><hr>"%>
                            <%="Address and Pincode. "+rsafterupdate.getString(9).toUpperCase()+" "+rsafterupdate.getString(12)+"<br><hr>"%>
                            <%="Email Address. "+rsafterupdate.getString(3).toLowerCase()+"<br><hr>"%>
                            <%="Account created on. "+rsafterupdate.getString(10)+"<br><hr>"%>
                            <%if(rsafterupdate.getString(7)==null){
                                    %><%="Aadhar number not updated.<br><a href=aadhar.html>Kindly add your aadhar details</a><br>"%>
<%}else{  %><%="Aadhar number. "+rsafterupdate.getString(7)%><%
}%></details><%   }}}}}
catch(Exception e){response.sendRedirect("errorpage.html");}%>
</body></html>