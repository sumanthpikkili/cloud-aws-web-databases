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


<html>
<head>
<title>REMOVE PRODUCT</title>
</head>

<body background="images/back.jpg">

	<font color="white"> <%!private AmazonEC2 ec2;
	private AmazonS3 s3;
	private AmazonDynamoDB dynamo;
	private DynamoDB dynamoDB;%> <%
 	if (ec2 == null) {
 		AWSCredentialsProvider credentialsProvider = new ClasspathPropertiesFileCredentialsProvider();
 		ec2 = new AmazonEC2Client(credentialsProvider);
 		s3 = new AmazonS3Client(credentialsProvider);
 		
 	    //Creating the DynamoDB Client
 		dynamo = new AmazonDynamoDBClient(credentialsProvider);
 	    
 	    //Setting the default end point to us-west-2 since this is not the default end point
 		dynamo.setEndpoint("dynamodb.us-west-2.amazonaws.com");

 	}
 %>
		<TABLE BORDER="2">
			<CENTER>
			<tr>
				<TH><font color="white">Uploaded By</font></TH>
				<TH><font color="white">Item Name</font></TH>
				<TH><font color="white">Item Description</font></TH>
				<TH><font color="white">Image</font></TH>
			</tr>


			<%
			    //Creating the HashMap and Scan
			    
				Map<String, AttributeValue> expressionAttributeValues = new HashMap<String, AttributeValue>();
				String user_name = (String) session.getAttribute("userid");
				expressionAttributeValues.put(":userid",
						new AttributeValue().withS(user_name));
				ScanRequest scanRequest = new ScanRequest().withTableName("items")
						.withFilterExpression("Username = :userid")
						.withExpressionAttributeValues(expressionAttributeValues);

				ScanResult scan_result = dynamo.scan(scanRequest);

				ArrayList<String> urls = new ArrayList<String>();
				ArrayList<String> alldescs = new ArrayList<String>();
				ArrayList<String> allunames = new ArrayList<String>();
				ArrayList<String> allitems = new ArrayList<String>();
				int count_items = scan_result.getItems().size();

				for (Map<String, AttributeValue> item : scan_result.getItems()) {
					AttributeValue itmName = item.get("ItemName");
					AttributeValue itemDesc = item.get("ItemDesc");
					AttributeValue image = item.get("ItemURL");
					AttributeValue usname = item.get("Username");

					String itname = itmName.getS();
					allitems.add(itname);
					String itdesc = itemDesc.getS();
					alldescs.add(itdesc);
					String url = image.getS();
					urls.add(url);
					String usnme = usname.getS();
					allunames.add(usnme);

				}
				String item_name = "";
				String item_desc = "";
				String item_url = "";
				String strusername = "";

				for (int p = 0; p < count_items; p++) {

					item_url = urls.get(p);
					item_name = allitems.get(p);
					strusername = allunames.get(p);
					item_desc = alldescs.get(p);
			%>

			<tr>
				<td><font color="white"><%=strusername%></font></td>
				<td><font color="white"><%=item_name%></font></td>
				<td><font color="white"><%=item_desc%></font></td>
				<td><img src=<%=item_url%> alt="" name="image" width="100"
					height="100" id="" /> <br /></td>
			</tr>
			<%
				}
			%>
			</CENTER>
		</TABLE>
<!-- Select item to delete and delete the item from the table in DynamoDB -->

		<TABLE Border="0">
			<form action="removeproduct.jsp" method="post">
				<tr>
					<td><font color="white">Select an item to delete</font></td>
					<td><select name="items" id="items">
							<%
								for (int z = 0; z < allitems.size(); z++) {
									String itemmName = allitems.get(z);
							%>
							<option><%=itemmName%></option>
							<%
								}
							%>
					</select></td>
				</tr>
				<tr>
					<td><input type="submit" value="Remove" name="itemRemove"
						class="submit" /></td>
				</tr>
			</form>
		</TABLE>
	</font>
</BODY>
</HTML>
