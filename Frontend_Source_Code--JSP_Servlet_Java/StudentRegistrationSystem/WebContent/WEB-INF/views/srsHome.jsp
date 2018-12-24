<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SRS Home</title>
</head>

<body>
	<h2>Welcome to Student Registration System Home Page</h2>
	<br />
	<h3>Choose any of the below options:- </h3>
	<ul>
		<li><a href="displayTableContentServlet">Display Table Contents</a></li>
		<li><a href="displayClassTADetailsServlet">Display TA Details for Specific Class</a></li>
		<li><a href="displayClassPrerequisiteServlet">Display Prerequisite Courses for Specific Dept_Code and Course#</a></li>
		<li><a href="enrollStudentServlet">Enroll Student into Class in Current Semester</a></li>
		<li><a href="deleteStudentEnrollmentServlet">Delete Student's Enrollment of Class from Current Semester</a></li>
		<li><a href="deleteStudentServlet">Delete Student</a></li>
	</ul>
	<br/>
	<br/>
	<a href="loginServlet">Sign Out</a>
</body>
</html>