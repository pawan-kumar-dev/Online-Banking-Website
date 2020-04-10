<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CHEQUE REQUEST</title>
         <link href="maincss.css" rel="stylesheet"/></head>
    <body>
        <div  class="topnav">
         <div id="topnav1" style="float:left;"><a href="index.html"><img src="banklo.png" style="height: 100px; width: 300px; padding-top: 10px; padding-left: 10px;" alt="TransaQ BANK"/></a></div>
         <div id="topnav1" style="float:left; padding-top:50px; padding-left: 100px;"><h1><b><u>CHEQUE REQUEST</u></b></h1></div>
        <div class="dropdown" style=" padding-top: 50px;"><img src="navi.svg" alt="Navigation" style="height:50px; width: 80px; cursor: pointer;"/>
         <div class="content">
             <a href="welcome.jsp" class="bt"><button class="btd">HOME</button></a>
             <a href="aadhar.html" class="bt"><button class="btd">AADHAR<br>UPDATE</button></a>
             <a href="contact.html" class="bt"><button class="btd">CONTACT US</button></a>
              <a href="personalloan.html" class="bt"><button class="btd">APPLY FOR<br>PERSONAL LOAN</button></a>
             <a href="transfer.html" class="bt"><button class="btd">TRANSFER<br>AMOUNT</button></a>
             <a href="transactionhistory.jsp" class="bt"><button class="btd">VIEW<br>TRANSACTION<br>HISTORY</button></a>
             <a href="update.html" class="bt"><button class="btd">UPDATE<br>DETAILS</button></a>
            <a href="logout.jsp" class="bt"><button class="btd">LOGOUT</button></a>
         </div></div></div><br><br>
        <%  HttpSession userid=request.getSession();
            String uid="";
            if(userid!=null){
            uid=(String)userid.getAttribute("username");}
            try{
             Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/Bank","root","root");
        Statement welcome=conn.createStatement();
        ResultSet welogin=welcome.executeQuery("select * from customer where customerid='"+uid+"';");
        if(welogin.next()){
        %><div style="width: 500px;"><table><tr><td><b><u>NAME :</u></b></td>
                    <td><b><%=welogin.getString(1).toUpperCase()%></u></b></td>
                </tr><tr><td><b><u>CUSTOMER ID :</u></b></td>
                    <td><b><%=welogin.getString(8)%></u></b></td>
                </tr><tr>
                    <td><b><u>ACCOUNT TYPE :</u></b></td>
                    <td><b><%=welogin.getString(5).toUpperCase()%></u></b></td>
                </tr><tr>
                    <td><b><u>ACCOUNT NUMBER :</u></b></td>
                    <td><b><%=welogin.getString(6)%></u></b></td>
                </tr></table></div><br><br><br><br><center><table>
                    <%
    Random r=new Random(System.currentTimeMillis());//generating 8 digit cheque id
       String num="";
       for(int i=0;i<=7;i++){
           num+=String.valueOf(r.nextInt(8));}
           Statement cheque=conn.createStatement();
        ResultSet chereq=cheque.executeQuery("select * from Cheque where customerid='"+uid+"';");
        if(!(chereq.next())){
     PreparedStatement cheinsert=conn.prepareStatement("insert into Cheque(customerid,accnum,status,cid) values(?,?,?,?);");
            cheinsert.setString(1,uid);
            cheinsert.setString(2,welogin.getString(6));
            cheinsert.setString(3,"Yes");
            cheinsert.setString(4,num);
            int success=cheinsert.executeUpdate();
if(success!=0){%><tr><b>
    <%="Successfully Requested for Cheque , Your Cheque ID is :"+num+"<br>You will receive your cheque in 4-5 working days"%></b></tr>
    <%
}}else{
%><tr><b><%="Already Requested for cheque, Your Cheque ID is :"+chereq.getString(1)+"<br>You will receive your cheque in 4-5 working days"%></b></tr>
<%   }
}else{%><script>
            alert("SESSION HAS BEEN EXPIRED");
            window.location.href="loginform.html"; </script> <%
}}catch(Exception e){%><jsp:forward page="errorpage.html"/><%
}%></table></center><br><br>
</body></html>