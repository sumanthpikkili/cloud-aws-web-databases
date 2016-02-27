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
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>

<%
	
	AmazonS3           s3;
	AmazonDynamoDB dynamo;
	AWSCredentialsProvider credentialsProvider = new ClasspathPropertiesFileCredentialsProvider();
	s3     = new AmazonS3Client(credentialsProvider);
	//Creating the DynamoDbClient
	dynamo = new AmazonDynamoDBClient(credentialsProvider);
	
	//Setting the end point to us-west-2
	dynamo.setEndpoint("dynamodb.us-west-2.amazonaws.com");

	String userid = request.getParameter("uname");   
    String pwd = request.getParameter("pass");
   
    //Creating the HashMap and Scan
    Map<String, AttributeValue> expressionAttributeValues = 
    	    new HashMap<String, AttributeValue>();
    Map<String, AttributeValue> expressionAttributeValues1 = 
    	    new HashMap<String, AttributeValue>();
    expressionAttributeValues.put(":username", new AttributeValue().withS(userid));
    expressionAttributeValues1.put(":password", new AttributeValue().withS(pwd));
    ScanRequest scanRequest = new ScanRequest().withTableName("user_2").withFilterExpression("username = :username").withExpressionAttributeValues(expressionAttributeValues).withFilterExpression("password = :password").withExpressionAttributeValues(expressionAttributeValues1);
   
    ScanResult result = dynamo.scan(scanRequest);
  
	out.println(result.getItems());   
    ResultSet rs;
    
  
    if (result.getCount().equals(1)) {
        session.setAttribute("userid", userid);
        out.println("Welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("success.jsp");
    } else {
        out.println("Invalid Username / password entered <a href='index.jsp'>Please try again</a>");
    }

%>