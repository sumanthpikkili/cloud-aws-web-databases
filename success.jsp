<!-- 
Author Name: Sumanth Pikkili
UTA ID: 1001100941
Course: CSE 6331 - Cloud Computing
Assignment Number 3: AWS Web Services / WebSite
 -->

<%@ page import="com.amazonaws.*"%>
<%@ page import="com.amazonaws.auth.*"%>
<%@ page import="com.amazonaws.services.ec2.*"%>
<%@ page import="com.amazonaws.services.ec2.model.*"%>
<%@ page import="com.amazonaws.services.s3.*"%>
<%@ page import="com.amazonaws.services.s3.model.*"%>
<%@ page import="com.amazonaws.services.dynamodbv2.*"%>
<%@ page import="com.amazonaws.services.dynamodbv2.model.*"%>
<%@ page import="com.amazonaws.services.dynamodbv2.document.Table"%>
<%@ page import="com.amazonaws.services.dynamodbv2.document.Item"%>
<%@ page import="com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient"%>
<%@ page import="com.amazonaws.services.dynamodbv2.document.DynamoDB"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.IOException"%>
<%@ page import="com.amazonaws.AmazonClientException"%>
<%@ page import="com.amazonaws.AmazonServiceException"%>
<%@ page import="com.amazonaws.auth.profile.ProfileCredentialsProvider"%>
<%@ page import="com.amazonaws.services.s3.AmazonS3"%>
<%@ page import="com.amazonaws.services.s3.AmazonS3Client"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AWS DYNAMO HOME</title>
</head>
<body background="images/back.jpg">
	<font color="white"> <%
 	AmazonS3 s3;
 	AmazonDynamoDB dynamo;
 	AWSCredentialsProvider credentialsProvider = new ClasspathPropertiesFileCredentialsProvider();

 	s3 = new AmazonS3Client(credentialsProvider);
 	
 	//Creating the DynamoDBClient
 	dynamo = new AmazonDynamoDBClient(credentialsProvider);
 	DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient(
 			credentialsProvider));
 	
 	//Setting the endpoint to us-west-2
 	dynamo.setEndpoint("dynamodb.us-west-2.amazonaws.com");
 	if ((session.getAttribute("userid") == null)
 			|| (session.getAttribute("userid") == "")) {
 %> You are not logged in <br /> <a href="index.jsp">Please Login
			Again</a> <%
 	} else {
 %><h3 ALIGN="CENTER">
			<!--  Getting the session user name -->
			Welcome
			<%=session.getAttribute("userid")%>
		</h3>
		<h3 ALIGN="RIGHT">
			<a href='logout.jsp'>Log out</a>
		</h3>

		<HR ALIGN="Center">
		<h2 ALIGN="CENTER">PRODUCT DETAILS</h2>

		<TABLE BORDER="1" ALIGN="CENTER">
			<tr>
				<TH>Uploaded By</TH>
				<TH>Item Name</TH>
				<TH>Item Description</TH>
				<TH>Image</TH>
			</tr>


			<%
				//Creating the Scan Request
				ScanRequest scanRequest = new ScanRequest().withTableName(
							"items").withAttributesToGet("ItemURL");
					ScanRequest scanRequest1 = new ScanRequest().withTableName(
							"items").withAttributesToGet("Username");
					ScanRequest scanRequest2 = new ScanRequest().withTableName(
							"items").withAttributesToGet("ItemName");
					ScanRequest scanRequest3 = new ScanRequest().withTableName(
							"items").withAttributesToGet("ItemDesc");
					ScanResult result = dynamo.scan(scanRequest);
					ScanResult result1 = dynamo.scan(scanRequest1);
					ScanResult result2 = dynamo.scan(scanRequest2);
					ScanResult result3 = dynamo.scan(scanRequest3);

					int count = result.getItems().size();
					for (int j = 0; j < count; j++) {

						String str1 = result.getItems().get(j).toString();
						String stritemurl = str1.substring(13, str1.length() - 3);
						String str2 = result1.getItems().get(j).toString();
						String strusername = str2.substring(14, str2.length() - 3);
						String str3 = result2.getItems().get(j).toString();
						String stritemname = str3.substring(14, str3.length() - 3);
						String str4 = result3.getItems().get(j).toString();
						String stritemdesc = str4.substring(14, str4.length() - 3);
			%>

			<tr>
				<td><%=strusername%></td>
				<td><%=stritemname%></td>
				<td><%=stritemdesc%></td>
				<td><img src=<%=stritemurl%> alt="" name="image5" width="100"
					height="100" id="" /> <br /></td>
			</tr>
			<%
				}
				}
			%>
		</TABLE>

		<h4 ALIGN="CENTER">
			<a href='addproduct.jsp'><font color="white"> Add an Item
			</font></a>
			</h5>
			<h4 ALIGN="CENTER">
				<a href='delete.jsp' ALIGN="CENTER"> <font color="white">Remove
						an Item </font></a>
				</h5></font>
</body>
</html>