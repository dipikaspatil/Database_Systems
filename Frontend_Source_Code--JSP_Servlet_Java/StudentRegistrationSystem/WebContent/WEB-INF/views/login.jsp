<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SRS Login</title>

<style>
table {
	border: none;
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 20%;
}

td, th {
	border: none;;
	text-align: center;
	padding: 4px;
}
}
</style>
</head>
<body>
	<h2>Student Registration System Sign-In Page</h2>
	<br />
	<p style="color: red;">${errorMessage}</p>
	<br />
	<form method="POST" action="loginServlet">
		<table>
			<tr>
				<td>Username</td>
				<td><input type="text" name="username" value="" /></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="password" value="" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="Login" />
			</tr>
		</table>
	</form>
</body>
</html>