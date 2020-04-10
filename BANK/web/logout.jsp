<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOGOUT</title></head><body>
        <%
HttpSession transactionId=request.getSession();
transactionId.invalidate();
HttpSession useraccount=request.getSession();
useraccount.invalidate();
HttpSession contact=request.getSession();
contact.invalidate();
HttpSession userid=request.getSession();
userid.invalidate();%>
<script>alert("SUCCESSFULLY LOGOUT");</script><%
response.sendRedirect("loginform.html");
        %>
</body></html>