<!-- 
Author Name: Sumanth Pikkili
UTA ID: 1001100941
Course: CSE 6331 - Cloud Computing
Assignment Number 3: AWS Web Services / WebSite
 -->

<%
//Null-ing the user id to invalidate and end the session
session.setAttribute("userid", null);
session.invalidate();
response.sendRedirect("index.jsp");
%>