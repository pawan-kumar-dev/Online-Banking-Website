<%@page import="java.text.*"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <link href="maincss.css" rel="stylesheet"/></head>
    <body>
        <style>
            #view{padding: 0;background-color: lightcyan;}
        </style><div  class="topnav">
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
            Class.forName("com.mysql.jdbc.Driver");
        Connection conn=null;
        Savepoint transferchk=null;
        try{
            conn=DriverManager.getConnection("jdbc:mysql://localhost/Bank","root","root");
           conn.setAutoCommit(false);
            String straccno,stramount;
            straccno=request.getParameter("toacc");
            stramount=request.getParameter("amount");
            if(straccno.isEmpty()||stramount.isEmpty()||Double.parseDouble(stramount)<=0){
                response.sendRedirect("transfer.html");}
            else{
            double amount=Double.parseDouble(stramount);
        Statement welcome=conn.createStatement();
        ResultSet welogin=welcome.executeQuery("select * from customer where customerid='"+uid+"';");
        if(welogin.next()){
            Statement anotheruser=conn.createStatement();
            ResultSet chkanotheruser=anotheruser.executeQuery("select * from customer where accnum='"+straccno+"';");
            if(chkanotheruser.next()){
                double amt=(double)welogin.getDouble(11);
                if(straccno.equals(welogin.getString(6))){%>
    <center><table style=" padding-top: 50px;">
                      <tr>
                            <td style="height: 50px; width: 100%;">
                                <%="<center><b>IT SEEMS YOU HAVE ENTERED YOUR ACCOUNT NUMBER<br>KINDLY ENTERED THE ACCOUNT NUMBER TO <br>WHOM YOU WANT THE TRANSFER AMOUNT<br><br><a href=transfer.html>CLICK HERE TO GO BACK....</a><b>"%>
                            </td></tr>   <%  }
               else if(amount>amt){%>
                        <tr>
                            <td style="height: 50px; width: 100%;">
                                <%="<b><center>ENTERED AMOUNT IS GREATER THAN THE AVAILABLE BALANCE....<br>PLEASE CHECK YOUR BALANCE.<b><br>"%>
                            </td></tr>
                        <tr>
                            <td style="height: 50px; width: 50px;">
                                <button id="view" onclick="view()"><img src="view.jpg" style="height: 70px; width: 100px;"/></button>
                            </td></tr><tr>
                            <td style="height: 50px; width: 50px;">
                                <b><div id="bal"></div></b>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 50px; width: 100%;">
                                <%="<br><b><a href=transfer.html>CLICK HERE TO GO BACK....</a><b>"%>
                            </td></tr>
<script language="javascript">
    function view(){
        document.getElementById("bal").innerHTML="Your Account Balance is "+<%=(double)welogin.getDouble(11)%>;}
</script><%
}else if(amount<=amt){
 transferchk=conn.setSavepoint("Transfer");
                double amt2=(double)chkanotheruser.getDouble(11);
                amt2=amt2+amount;
  PreparedStatement pst=conn.prepareStatement("update customer set balance='"+amt2+"'where accnum='"+straccno+"';");
  int send=pst.executeUpdate();
  if(send!=0){
amt=amt-amount;
 PreparedStatement ps=conn.prepareStatement("update customer set balance='"+amt+"'where customerid='"+uid+"';");
  int deduct=ps.executeUpdate();
if(deduct!=0){
Random r=new Random(System.currentTimeMillis());//generating 10 digit Transactionid
       String transID="";
       for(int i=0;i<=9;i++){
           transID+=String.valueOf(r.nextInt(8));}
DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
       java.util.Date d=new java.util.Date();
HttpSession useraccount=request.getSession();
useraccount.setAttribute("useracc",straccno);
HttpSession transactionId=request.getSession();
transactionId.setAttribute("transacId",transID);
PreparedStatement trans=conn.prepareStatement("insert into transfer(transacID,customerID,toaccount,amount,date,fromaccount) values(?,?,?,?,?,?);");
trans.setString(1,transID);
trans.setString(2,uid);
trans.setString(3,straccno);
trans.setDouble(4,amount);
trans.setString(5,dateFormat.format(d));
trans.setString(6,welogin.getString(6));
trans.executeUpdate();
Statement status=conn.createStatement();
ResultSet chkstatus=status.executeQuery("select * from customer where customerid='"+uid+"';");
if(chkstatus.next()){
PreparedStatement transhis=conn.prepareStatement("insert into transactionhistory(transacID,customerid,account,amount,status,date) values(?,?,?,?,?,?);");
transhis.setString(1,transID);
transhis.setString(2,uid);
transhis.setString(3,welogin.getString(6));
transhis.setDouble(4,amount);
transhis.setString(5,"DEBITED");
transhis.setString(6,dateFormat.format(d));
transhis.executeUpdate();}
Statement status1=conn.createStatement();
ResultSet chkstatus1=status1.executeQuery("select * from customer where customerid='"+chkanotheruser.getString(8)+"';");
if(chkstatus1.next()){
PreparedStatement transhis1=conn.prepareStatement("insert into transactionhistory(transacID,customerid,account,amount,status,date) values(?,?,?,?,?,?);");
transhis1.setString(1,transID);
transhis1.setString(2,chkanotheruser.getString(8));
transhis1.setString(3,chkanotheruser.getString(6));
transhis1.setDouble(4,amount);
transhis1.setString(5,"CREDITED");
transhis1.setString(6,dateFormat.format(d));
transhis1.executeUpdate();
conn.commit();}
response.sendRedirect("successtransfer.jsp");
}}}  }
else{%><tr>
    <td style="height: 50px; width: 100%;">
      <%="<center><b>INVALID ACCOUNT NUMBER....<br>PLEASE VERIFY THE ACCOUNT NUMBER....<b></center>"%>  
    </td></tr><tr>
<td style="height: 50px; width: 100%;">
    <%="<center><br><b><a href=transfer.html>CLICK HERE TO GO BACK....</a><b></center>"%></td></tr></table></center><%
}}else{
%><script>alert("SESSION HAS BEEN EXPIRED");
window.location.href="loginform.html"; </script><% }
}}
catch(Exception e){
conn.rollback(transferchk);            
response.sendRedirect("errorpage.html");}%>
</body></html>