<!-- 
Author Name: Sumanth Pikkili
UTA ID: 1001100941
Course: CSE 6331 - Cloud Computing
Assignment Number 3: AWS Web Services / WebSite
 -->

<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Iterator"%>
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
<%@ page
	import="com.amazonaws.services.dynamodbv2.document.spec.DeleteItemSpec"%>



<HTML>
<body background="images/back.jpg">



	<%!private AmazonEC2 ec2;
	private AmazonS3 s3;
	private AmazonDynamoDB dynamo;
	private DynamoDB dynamoDB;
	%>
	<%
		if (ec2 == null) {
			AWSCredentialsProvider credentialsProvider = new ClasspathPropertiesFileCredentialsProvider();
			ec2 = new AmazonEC2Client(credentialsProvider);
			s3 = new AmazonS3Client(credentialsProvider);
			dynamoDB = new DynamoDB(new AmazonDynamoDBClient(
					new ProfileCredentialsProvider()));
			dynamo = new AmazonDynamoDBClient(credentialsProvider);
			dynamo.setEndpoint("dynamodb.us-west-2.amazonaws.com");

		}
	%>

	<%
		String item_name = request.getParameter("items");

		//Creating the HashMap
		Map<String, ExpectedAttributeValue> expectedValues = new HashMap<String, ExpectedAttributeValue>();
		HashMap<String, AttributeValue> key_value = new HashMap<String, AttributeValue>();
		ReturnValue returnValues = ReturnValue.ALL_OLD;
		String username = (String) session.getAttribute("userid");
		key_value.put("ItemName", new AttributeValue().withS(item_name));

		
		//Creating a delete Item Request
		DeleteItemRequest deleteItemRequest = new DeleteItemRequest()
				.withTableName("items").withKey(key_value)
				.withReturnValues(returnValues);

		DeleteItemResult rsult = dynamo.deleteItem(deleteItemRequest);
	%>

	<h1 align="CENTER">
		<font color="white">The Product has been deleted</font>
	</h1>
	<br />
	<a href='success.jsp'><font color="white">Click here to go
			back to the Home Page</font></a>
	<br />
</body>
</HTML>