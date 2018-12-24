<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Display Class Prerequisite</title>

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
	<h2>Display Class Prerequisite</h2>
	<br />
	<p style="color: red;">${errorMessage}</p>
	<br />
	<form method="POST" action="displayClassPrerequisiteServlet">
		<table>
			<tr>
				<td>Enter Department Code</td>
				<td><input type="text" name="deptCode" value="" /></td>
			</tr>
			<tr>
				<td>Enter Course Number</td>
				<td><input type="text" name="courseNumber" value="" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Submit" />
			</tr>
		</table>
	</form>
	<br />
	<br />
	<table>
		<c:if test="${fn:length(prereqDetailsList) gt 0}">
			<tr>
				<td><p style="color: green;">${courseInfo}</p></td>
			</tr>
			<tr>
				<th>Prerequisite Course</th>
			</tr>
			<c:forEach items="${prereqDetailsList}" var="prereq">
				<tr>
					<td><c:out value="${prereq}" /></td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<br />
	<br />
	<a href="srsHomeServlet">SRS Home Page</a>
</body>
</html>