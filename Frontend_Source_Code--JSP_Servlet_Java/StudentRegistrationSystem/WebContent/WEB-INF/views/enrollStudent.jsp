<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Enroll Student B# into ClassId</title>

<style>
table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 50%;
}

td, th {
	border: 1px solid #dddddd;
	text-align: center;
	padding: 4px;
}

tr:nth-child(even) {
	background-color: #dddddd;
}
</style>
</head>
<body>
	<h2>Enroll Student B# into specific Class</h2>
	<br />
	<p style="color: red;">${errorMessage}</p>
	<br />
	<form method="POST" action="enrollStudentServlet">
		<table>
			<tr>
				<td>Enter Student B#</td>
				<td><input type="text" name="bNumber" value="" /></td>
			</tr>
			<tr>
				<td>Enter ClassId</td>
				<td><input type="text" name="classId" value="" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Submit" />
			</tr>
		</table>
	</form>
	<br />
	<br />
	<p style="color: green;">${warningMessage}</p>
	<br />
	<br />
	<a href="srsHomeServlet">SRS Home Page</a>
</body>
</html>