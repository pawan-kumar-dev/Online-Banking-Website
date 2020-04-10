<%@page import="java.text.*"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>REGISTERING</title></head>
    <body>
        <%
            try{
        String name,address,password,type,email;
        double phone,pin,amount;
        name=request.getParameter("name");
        address=request.getParameter("add");
        password=request.getParameter("pass");
        type=request.getParameter("type");
        email=request.getParameter("mail");
        String strphone=request.getParameter("num");
        String strpin=request.getParameter("pincode");
        String stramt=request.getParameter("money");
        if(name.isEmpty()|| address.isEmpty()||password.isEmpty()||type.isEmpty()||email.isEmpty()||strphone.isEmpty()||strpin.isEmpty()){
        response.sendRedirect("regisform.html");
        }else{String typeacc;
        if(type.equals("1")){
            typeacc="Saving";}
        else{typeacc="Current";}
        phone=Double.parseDouble(strphone);
        pin=Double.parseDouble(strpin);
        amount=Double.parseDouble(stramt);
        Random r=new Random(System.currentTimeMillis());//generating 15 digit acc num
       String num="";
       for(int i=0;i<=4;i++){
           num+=String.valueOf(r.nextInt(8));}
       String acc="6440020100";
        String straccno=acc+num;
        String account=straccno.replace(".","");
        Random r1=new Random(System.currentTimeMillis());
        String uid="";
        for(int i=0;i<=5;i++){
           uid+=String.valueOf(r1.nextInt(8));}
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        java.util.Date d=new java.util.Date();
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/Bank","root","root");
        PreparedStatement pst=conn.prepareStatement("insert into customer(name,address,phone,pin,email,pass,type,customerid,accnum,balance,date) values(?,?,?,?,?,?,?,?,?,?,?);");
        pst.setString(1,name);
        pst.setString(2,address);
        pst.setDouble(3,phone);
        pst.setDouble(4,pin);
        pst.setString(5,email);
        pst.setString(6,password);
        pst.setString(7,typeacc);
         pst.setString(8,uid);
        pst.setString(9,account);
        pst.setDouble(10,amount);
        pst.setString(11,dateFormat.format(d));
        int insertdata=pst.executeUpdate();
if(insertdata!=0){
    HttpSession registered=request.getSession();
     registered.setAttribute("username",uid);
        response.sendRedirect("successregister.jsp");}}}
            catch(Exception e){
response.sendRedirect("errorpage.html");}%>
</body></html>