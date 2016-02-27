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
<title>AWS DYNAMO Registration</title>
</head>
<body background="images/back.jpg">
	<font color="white">
		<h1 ALIGN="CENTER">REGISTRATION</h1>

		<form method="post" action="registration.jsp">
			<center>
				<table border="1" width="30%" cellpadding="5">
					<thead>
						<tr>
							<th colspan="2">Please Enter your Details</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>First Name</td>
							<td><input type="text" name="fname" value="" /></td>
						</tr>
						<tr>
							<td>Last Name</td>
							<td><input type="text" name="lname" value="" /></td>
						</tr>
						<tr>
							<td>Email ID</td>
							<td><input type="text" name="email" value="" /></td>
						</tr>
						<tr>
							<td>User Name</td>
							<td><input type="text" name="uname" value="" /></td>
						</tr>
						<tr>
							<td>Password</td>
							<td><input type="password" name="pass" value="" /></td>
						</tr>
						<tr>
							<td><input type="submit" value="Submit" /></td>
							<td><input type="reset" value="Reset" /></td>
						</tr>
						<tr>
							<td colspan="2" align="CENTER">Already registered?? <a
								href="index.jsp"> <font color="white">Login Here</font></a></td>
						</tr>
					</tbody>
				</table>
			</center>
		</form>
	</font>
</body>
</html>