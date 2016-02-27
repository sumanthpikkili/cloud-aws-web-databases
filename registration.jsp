<!-- 
Author Name: Sumanth Pikkili
UTA ID: 1001100941
Course: CSE 6331 - Cloud Computing
Assignment Number 3: AWS Web Services / WebSite
 -->

<%@ page import="java.sql.*"%>
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
<%@ page
	import="com.amazonaws.services.dynamodbv2.document.ItemCollection"%>


<%
	AmazonDynamoDB dynamo;

	AWSCredentialsProvider credentialsProvider = new ClasspathPropertiesFileCredentialsProvider();

	//Creating the dynamoDB client
	dynamo = new AmazonDynamoDBClient(credentialsProvider);

	String user = request.getParameter("uname");
	String pwd = request.getParameter("pass");
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	String email = request.getParameter("email");
	
	//Setting the end point to the us-west-2
	dynamo.setEndpoint("dynamodb.us-west-2.amazonaws.com");

	dynamo.putItem(new PutItemRequest().withTableName("user_2")
			.addItemEntry("username", new AttributeValue(user))
			.addItemEntry("password", new AttributeValue(pwd))
			.addItemEntry("email", new AttributeValue(email))
			.addItemEntry("fname", new AttributeValue(fname))
			.addItemEntry("lname", new AttributeValue(lname)));

	//Setting the session attribute after registration
	session.setAttribute("userid", user);

	out.print("Your Registration is successfull!"
			+ "<a href='index.jsp'><br />Click here to go to Login Page</a>");
%>