<%@page import="java.text.*"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOAN REQUEST</title>
        <link href="maincss.css" rel="stylesheet"/></head>
    <body><div  class="topnav">
         <div style="float:left;"><img src="banklo.png" style="height: 100px; width: 300px; padding-top: 10px; padding-left: 10px;" alt="TransaQ BANK"/></div>
         <div style="float:left;padding-top: 50px; padding-left: 20px;"><h1><b><u>WELCOME TO TransaQ BANK</u></b></h1></div>
         <div class="dropdown" style="padding-top: 50px;"><img src="navi.svg" alt="Navigation" style="height:50px; width: 80px; cursor: pointer;"/>
         <div class="content">
             <a href="welcome.jsp" class="bt"><button class="btd">HOME</button></a>
            <a href="aadhar.html" class="bt"><button class="btd">AADHAR<br>UPDATE</button></a>
            <a href="contact.html" class="bt"><button class="btd">CONTACT US</button></a>
             <a href="cheque.jsp" class="bt"><button class="btd">CHEQUE<br>REQUEST</button></a>
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
        String stramount,strtime,strsalary,strresident,strwork;
        double amount;
        stramount=request.getParameter("amount");
        strtime=request.getParameter("time");
        strsalary=request.getParameter("sal");
        strresident=request.getParameter("resident");
        strwork=request.getParameter("work");
        if(stramount.isEmpty()||strtime.isEmpty()||strsalary.isEmpty()||strresident.isEmpty()||strwork.isEmpty()){
        response.sendRedirect("personalloan.html");
        }else{
            amount=Double.parseDouble(stramount);
             Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/Bank","root","root");
        Statement welcome=conn.createStatement();
        ResultSet welogin=welcome.executeQuery("select * from customer where customerid='"+uid+"';");
        if(welogin.next()){
        %><div style="width: 500px;"><table><tr>
                    <td><b><u>NAME :</u></b></td>
                    <td><b><%=welogin.getString(1).toUpperCase()%></u></b></td></tr>
                <tr>
                    <td><b><u>CUSTOMER ID :</u></b></td>
                    <td><b><%=welogin.getString(8)%></u></b></td>
                </tr><tr>
                    <td><b><u>ACCOUNT TYPE :</u></b></td>
                    <td><b><%=welogin.getString(5).toUpperCase()%></u></b></td>
                </tr><tr>
                    <td><b><u>ACCOUNT NUMBER :</u></b></td>
                    <td><b><%=welogin.getString(6)%></u></b></td>
                </tr></table></div><br><br><br><br><center><table><%    
    Random r=new Random(System.currentTimeMillis());//generating 6 digit loan id
       String perid="";
       for(int i=0;i<=5;i++){
           perid+=String.valueOf(r.nextInt(8));}
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
       java.util.Date d=new java.util.Date();
           Statement Perloan=conn.createStatement();
        ResultSet perloanrs=Perloan.executeQuery("select * from personalloan where customerid='"+uid+"';");
        if(!(perloanrs.next())){
     PreparedStatement perinsert=conn.prepareStatement("insert into personalloan(pid,customerid,amount,interest,date,status,account) values(?,?,?,?,?,?,?);");
            perinsert.setString(1,perid);
            perinsert.setString(2,uid);
            perinsert.setDouble(3,amount);
            perinsert.setString(4,"7.60");
            perinsert.setString(5,dateFormat.format(d));
            perinsert.setString(6,"Accepted");
            perinsert.setString(7,welogin.getString(6));
            int personal=perinsert.executeUpdate();
if(personal!=0){%><tr><b>
    <%="Successfully Requested for Loan , Your Loan ID is :"+perid+"<br>For amount "+amount+" for interest "+7.6+" visit our branch<br> with your aadhar card, pan card, Agreement, Bank Passbook for further process"%></b></tr>
    <%
}}else{
%><tr><b><%="Already Requested for Loan , Your Loan ID is :"+perloanrs.getString(1)+"<br>For amount "+perloanrs.getString(3)+" for interest "+7.6+" visit our branch<br> with your aadhar card, pan card, Agreement, Bank Passbook for further process"%></b></tr>
     <%   }}else{%><script>
            alert("SESSION HAS BEEN EXPIRED");
            window.location.href="loginform.html"; </script><% }
}}catch(Exception e){response.sendRedirect("errorpage.html");}%>
</table></center></body></html>