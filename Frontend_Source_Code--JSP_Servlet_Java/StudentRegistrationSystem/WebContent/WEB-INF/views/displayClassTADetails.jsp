<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TA Details for specific ClassId</title>

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
	<h2>TA Details for specific ClassId</h2>
	<br />
	<p style="color: red;">${errorMessage}</p>
	<br />
	<form method="POST" action="displayClassTADetailsServlet">
		<table>
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
	<table>
		<c:if test="${not empty taBNumber}">
			<tr>
				<td><p style="color: green;">TA Details for input ClassId :
						${classId}</p></td>
			</tr>
			<tr>
				<th>B#</th>
				<th>FIRST_NAME</th>
				<th>LAST_NAME</th>
			</tr>
			<tr>
				<td>${taBNumber}</td>
				<td>${taFirstName}</td>
				<td>${taLastName}</td>
			</tr>
		</c:if>
	</table>
	<br />
	<br />
	<a href="srsHomeServlet">SRS Home Page</a>
</body>
</html>