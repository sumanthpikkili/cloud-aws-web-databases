<!-- 
Author Name: Sumanth Pikkili
UTA ID: 1001100941
Course: CSE 6331 - Cloud Computing
Assignment Number 3: AWS Web Services / WebSite
 -->


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>

<head>
<title>ADD PRODUCT</title>
</head>

<body background="images/back.jpg">
	<font color="white">

		<h2 ALIGN="CENTER">Item Details</h2> 
		<!--  Form to Enter the Product Details to be Added -->
		<FORM ACTION="uploadfile.jsp" METHOD=POST>


			<center>
				<table border="1" width="50%" cellpadding="10">

					<thead>
						<tr>
							<th colspan="2"><font color="white">Please Enter the
									Item details</font></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><font color="white">Item Name</font></td>
							<td><input type="text" name="itemname" /></td>
						</tr>
						<tr>
							<td><font color="white">Item Description</font></td>
							<td><input type="textarea" name="itemdesc" /></td>
						</tr>
						<tr>
							<td><font color="white">Select an image to upload:</font></td>
							<td><input type="file" name="fileToUpload" id="fileToUpload">
							</td>
						</tr>
						<tr>
							<td><input type="submit" value="Upload Item"
								name="itemSubmit" class="submit" /></td>
						</tr>
						</center>

					</tbody>
					</FORM>
					</font>
</body>
</html>

