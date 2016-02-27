<!-- 
Author Name: Sumanth Pikkili
UTA ID: 1001100941
Course: CSE 6331 - Cloud Computing
Assignment Number 3: AWS Web Services / WebSite
 -->


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AWS DYNAMO LOGIN</title>
</head>
<body background="images/back.jpg">
	<h1 align="CENTER">
		<font color="white">AWS DYNAMO</font>
	</h1>
	<form method="post" action="login.jsp">
		<center>
			<table border="2" width="50%" cellpadding="4">
				<thead>
					<tr>
						<th colspan="2"><font color="white">Please Login Here</font></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><font color="white">User Name</font></td>
						<td><input type="text" name="uname" value="" /></td>
					</tr>
					<tr>
						<td><font color="white">Password</font></td>
						<td><input type="password" name="pass" value="" /></td>
					</tr>
					<tr>
						<td><input type="submit" value="Login" /></td>
						<td><input type="reset" value="Reset" /></td>
					</tr>
					<tr>
						<td colspan="2" align="CENTER"><font color="white">Not
								yet registrered?</font> <a href="reg.jsp"><font color="white">Register Here</font></a></td>
					</tr>
				</tbody>
			</table>
		</center>
	</form>
</body>
</html>