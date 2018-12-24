<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Display Table Contents</title>

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
	<h2>Display Database Contents</h2>
	<br />
	<p style="color: red;">${errorMessage}</p>
	<br />
	<form method="POST" action="displayTableContentServlet">
		<table>
			<tr>
				<td>Select database table</td>
				<td><select name="tablename">
						<option value="" selected disabled>Choose option</option>
						<option value="students">Students</option>
						<option value="tas">TAs</option>
						<option value="courses">Courses</option>
						<option value="classes">Classes</option>
						<option value="enrollments">Enrollments</option>
						<option value="prerequisites">Prerequisites</option>
						<option value="logs">Logs</option>
				</select></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Display Contents" />
			</tr>
		</table>
	</form>
	<br />
	<br />
	<table>
		<c:if test="${fn:length(studentsList) gt 0}">
			<tr>
				<td><p style="color: green;">${tableName}</p></td>
			</tr>
			<tr>
				<th>B#</th>
				<th>FIRST_NAME</th>
				<th>LAST_NAME</th>
				<th>STATUE</th>
				<th>GPA</th>
				<th>EMAIL</th>
				<th>BIRTH_DATE</th>
				<th>DEPT_NAME</th>
			</tr>
			<c:forEach items="${studentsList}" var="student">
				<tr>
					<td><c:out value="${student.bNumber}" /></td>
					<td><c:out value="${student.firstName}" /></td>
					<td><c:out value="${student.lastName}" /></td>
					<td><c:out value="${student.status}" /></td>
					<td><c:out value="${student.gpa}" /></td>
					<td><c:out value="${student.email}" /></td>
					<td><c:out value="${student.birthDate}" /></td>
					<td><c:out value="${student.deptName}" /></td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(taList) gt 0}">
			<tr>
				<td><p style="color: green;">${tableName}</p></td>
			</tr>
			<tr>
				<th>B#</th>
				<th>TA_LEVEL</th>
				<th>OFFICE</th>
			</tr>
			<c:forEach items="${taList}" var="ta">
				<tr>
					<td><c:out value="${ta.bNumber}" /></td>
					<td><c:out value="${ta.taLevel}" /></td>
					<td><c:out value="${ta.office}" /></td>
				<tr>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(courseList) gt 0}">
			<tr>
				<td><p style="color: green;">${tableName}</p></td>
			</tr>
			<tr>
				<th>DEPT_CODE</th>
				<th>COURSE#</th>
				<th>TITLE</th>
			</tr>
			<c:forEach items="${courseList}" var="course">
				<tr>
					<td><c:out value="${course.deptCode}" /></td>
					<td><c:out value="${course.courseNumber}" /></td>
					<td><c:out value="${course.title}" /></td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(classList) gt 0}">
			<tr>
				<td><p style="color: green;">${tableName}</p></td>
			</tr>
			<tr>
				<th>CLASSID</th>
				<th>DEPT_CODE</th>
				<th>COURSE#</th>
				<th>SECT#</th>
				<th>YEAR</th>
				<th>SEMESTER</th>
				<th>LIMIT</th>
				<th>CLASS_SIZE</th>
				<th>ROOM</th>
				<th>TA_B#</th>
			</tr>
			<c:forEach items="${classList}" var="cl">
				<tr>
					<td><c:out value="${cl.classId}" /></td>
					<td><c:out value="${cl.deptCode}" /></td>
					<td><c:out value="${cl.courseNumber}" /></td>
					<td><c:out value="${cl.sectionNumber}" /></td>
					<td><c:out value="${cl.year}" /></td>
					<td><c:out value="${cl.semester}" /></td>
					<td><c:out value="${cl.limit}" /></td>
					<td><c:out value="${cl.classSize}" /></td>
					<td><c:out value="${cl.room}" /></td>
					<td><c:out value="${cl.taBNumber}" /></td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(enrollmentList) gt 0}">
			<tr>
				<td><p style="color: green;">${tableName}</p></td>
			</tr>
			<tr>
				<th>B#</th>
				<th>CLASSID</th>
				<th>LGRADE</th>
			</tr>
			<c:forEach items="${enrollmentList}" var="enroll">
				<tr>
					<td><c:out value="${enroll.bNumber}" /></td>
					<td><c:out value="${enroll.classId}" /></td>
					<td><c:out value="${enroll.lGrade}" /></td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(prereqList) gt 0}">
			<tr>
				<td><p style="color: green;">${tableName}</p></td>
			</tr>
			<tr>
				<th>DEPT_CODE</th>
				<th>COURSE#</th>
				<th>PRE_DEPT_CODE</th>
				<th>PRE_COURSE#</th>
			</tr>
			<c:forEach items="${prereqList}" var="prereq">
				<tr>
					<td><c:out value="${prereq.deptCode}" /></td>
					<td><c:out value="${prereq.courseNumber}" /></td>
					<td><c:out value="${prereq.preDeptCode}" /></td>
					<td><c:out value="${prereq.preCourseNumber}" /></td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(logList) gt 0}">
			<tr>
				<td><p style="color: green;">${tableName}</p></td>
			</tr>
			<tr>
				<th>LOG#</th>
				<th>OP_NAME</th>
				<th>OP_TIME</th>
				<th>TABLE_NAME</th>
				<th>OPERATION</th>
				<th>KEY_VALUE</th>
			</tr>
			<c:forEach items="${logList}" var="log">
				<tr>
					<td><c:out value="${log.logNumber}" /></td>
					<td><c:out value="${log.opName}" /></td>
					<td><c:out value="${log.opTime}" /></td>
					<td><c:out value="${log.tableName}" /></td>
					<td><c:out value="${log.operation}" /></td>
					<td><c:out value="${log.keyvalue}" /></td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<br />
	<br />
	<a href="srsHomeServlet">SRS Home Page</a>
</body>
</html>