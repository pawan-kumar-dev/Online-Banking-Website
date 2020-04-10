<%@page import="java.util.Random"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CONTACTING</title>
        <link href="maincss.css" rel="stylesheet"/></head>
    <body><div  class="topnav">
         <div id="topnav1" style="float:left;"><a href="index.html"><img src="banklo.png" style="height: 100px; width: 300px; padding-top: 10px; padding-left: 10px;" alt="TransaQ BANK"/></a></div>
         <div id="topnav1" style="float:left; padding-top:50px; padding-left: 100px;"><h1><b><u>CONTACT US</u></b></h1></div>
        </div><br><br>
        <%try{
             HttpSession userid=request.getSession();
            String uid="";
            if(userid!=null){
            uid=(String)userid.getAttribute("username");}
            String accno,query;
            query=request.getParameter("query");
            if(query.isEmpty()){
                response.sendRedirect("contact.html");}
            else{
                Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/Bank","root","root");
        Statement welcome=conn.createStatement();
        ResultSet welogin=welcome.executeQuery("select * from customer where customerid='"+uid+"';");
        if(welogin.next()){
                 Random r=new Random(System.currentTimeMillis());
             String qid="";
       for(int i=0;i<=7;i++){
           qid+=String.valueOf(r.nextInt(8));}
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
       java.util.Date d=new java.util.Date();
        PreparedStatement qinsert=conn.prepareStatement("insert into query(qid,customerid,about,date) values(?,?,?,?);");
        qinsert.setString(1,qid);
        qinsert.setString(2,uid);
        qinsert.setString(3,query);
        qinsert.setString(4,dateFormat.format(d));
        int q=qinsert.executeUpdate();
        if(q!=0){
            HttpSession contact=request.getSession();
     contact.setAttribute("queryid",qid);
        response.sendRedirect("contactsuccess.jsp");
        }}else{%><script>
            alert("SESSION HAS BEEN EXPIRED");
            window.location.href="loginform.html"; 
</script><% }}
}catch(Exception e){response.sendRedirect("errorpage.html");}%>
</body></html>