<!-- 
Author Name: Sumanth Pikkili
UTA ID: 1001100941
Course: CSE 6331 - Cloud Computing
Assignment Number 3: AWS Web Services / WebSite
 -->

<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.amazonaws.*"%>
<%@ page import="com.amazonaws.auth.*"%>
<%@ page import="com.amazonaws.auth.profile.ProfileCredentialsProvider"%>
<%@ page import="com.amazonaws.services.ec2.*"%>
<%@ page import="com.amazonaws.services.ec2.model.*"%>
<%@ page import="com.amazonaws.services.s3.*"%>
<%@ page import="com.amazonaws.services.s3.model.*"%>
<%@ page import="com.amazonaws.services.dynamodbv2.*"%>
<%@ page import="com.amazonaws.services.dynamodbv2.model.*"%>
<%@ page import="com.amazonaws.services.dynamodbv2.document.*"%>
<%@ page import="com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient"%>
<%@ page import="com.amazonaws.services.dynamodbv2.document.DynamoDB"%>
<%@ page import="com.amazonaws.services.dynamodbv2.document.Item"%>
<%@ page import="com.amazonaws.services.dynamodbv2.document.Table"%>
<%@ page
	import="com.amazonaws.services.dynamodbv2.document.ItemCollection"%>
<%@ page import="java.lang.Object"%>


<%!
	private AmazonEC2 ec2;
	private AmazonS3 s3;
	private AmazonDynamoDB dynamo;%>
<%
	if (ec2 == null) {
		AWSCredentialsProvider credentialsProvider = new ClasspathPropertiesFileCredentialsProvider();
		
		//Creating the DynamoDB Client
		dynamo = new AmazonDynamoDBClient(credentialsProvider);
	}
%>
<%
	String itemname = request.getParameter("itemname");
	String itemdesc = request.getParameter("itemdesc");
	String itemfileimage = request.getParameter("fileToUpload");
	String fullname = itemfileimage;

	String uname = (String) session.getAttribute("userid");
	String filename = fullname.substring(itemfileimage
			.lastIndexOf("\\") + 1);
	
	//Setting the S3 endpoint
	s3.setEndpoint("s3-us-west-2.amazonaws.com");

	File ff = new File(fullname);

	//Uploading the File to S3
	s3.putObject(new PutObjectRequest("resourcesimages/images/",
			filename, ff));

	DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient(
			new ProfileCredentialsProvider()));

	//Creating the imageURL(metadata) to store in dynamoDB
	String imageurl = "https://s3-us-west-2.amazonaws.com/resourcesimages/images//"
			+ filename;
	
	//Setting the dynamoDB endpoint
	dynamo.setEndpoint("dynamodb.us-west-2.amazonaws.com");

	//Adding the item in the items table in dynamoDB
	dynamo.putItem(new PutItemRequest().withTableName("items")
			.addItemEntry("Username", new AttributeValue(uname))
			.addItemEntry("ItemDesc", new AttributeValue(itemdesc))
			.addItemEntry("ItemName", new AttributeValue(itemname))
			.addItemEntry("ItemURL", new AttributeValue(imageurl)));

	out.println("The item has been added");
%>
<a href="success.jsp"> Click Here to redirect to the Home Page </a>











