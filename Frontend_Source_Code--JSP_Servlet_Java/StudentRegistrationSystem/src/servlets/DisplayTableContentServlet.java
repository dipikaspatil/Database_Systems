package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Classes;
import beans.Course;
import beans.Enrollment;
import beans.Log;
import beans.Prerequisite;
import beans.Student;
import beans.Ta;
import dbconutil.OraConnection;
import dboperations.DisplayTableContents;

/**
 * Servlet implementation class DisplayTableContentServlet
 */
@WebServlet("/displayTableContentServlet")
public class DisplayTableContentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default Constructor
	 * @see HttpServlet#HttpServlet()
	 */
	public DisplayTableContentServlet() {
		super();
	}

	/**
	 * Method to display Table Contents Page
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Forward request to login page
		RequestDispatcher disp = this.getServletContext().getRequestDispatcher("/WEB-INF/views/displayTableContent.jsp");
		disp.forward(request, response);
	}

	/**
	 * Method to invoke DB procedure as per the request from UI and return response to UI
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Local variables
		boolean hasError = false;
		String errorMessage = null;
		List<Student> studentsList = null;
		List<Ta> taList = null;
		List<Course> courseList = null;
		List<Classes> classList = null;
		List<Enrollment> enrollmentList = null;
		List<Prerequisite> prereqList = null;
		List<Log> logList = null;
		String tableName = request.getParameter("tablename");
		Connection conn = OraConnection.dbConnection;

		// Validation for empty input from front end side
		if (tableName == null || tableName.length() == 0) {
			hasError = true;
			errorMessage = "Please select valid tablename from dropdown.";
		} else {
			// Call respective DB procedure using respective Model class
			try {
				if ("students".equalsIgnoreCase(tableName)) {
					studentsList = DisplayTableContents.showStudents(conn);
				} else if ("tas".equalsIgnoreCase(tableName)) {
					taList = DisplayTableContents.showTas(conn);
				} else if ("courses".equalsIgnoreCase(tableName)) {
					courseList = DisplayTableContents.showCourses(conn);
				} else if ("classes".equalsIgnoreCase(tableName)) {
					classList = DisplayTableContents.showClasses(conn);
				} else if ("enrollments".equalsIgnoreCase(tableName)) {
					enrollmentList = DisplayTableContents.showEnrollments(conn);
				} else if ("prerequisites".equalsIgnoreCase(tableName)) {
					prereqList = DisplayTableContents.showPrerequisites(conn);
				} else if ("logs".equalsIgnoreCase(tableName)) {
					logList = DisplayTableContents.showLogs(conn);
				}
			} catch(SQLException ex) {
				ex.printStackTrace();
				hasError = true;
				errorMessage = ex.getMessage();
			}
		}

		// Condition check for valid/ invalid credentials
		if (hasError) {
			// Forward loaded error to same page
			request.setAttribute("errorMessage", errorMessage);
			RequestDispatcher disp = this.getServletContext().getRequestDispatcher("/WEB-INF/views/displayTableContent.jsp");
			disp.forward(request, response);
		} else {
			// Forward extracted result to same front end
			if ("students".equalsIgnoreCase(tableName)) {
				request.setAttribute("tableName", "STUDENTS");
				request.setAttribute("studentsList", studentsList);
				/*for (Student stud : studentsList) {
					System.out.println(stud);
				}*/
			} else if ("tas".equalsIgnoreCase(tableName)) {
				request.setAttribute("tableName", "TAs");
				request.setAttribute("taList", taList);
				/*for (Ta ta : taList) {
					System.out.println(ta);
				}*/
			} else if ("courses".equalsIgnoreCase(tableName)) {
				request.setAttribute("tableName", "COURSES");
				request.setAttribute("courseList", courseList);
				/*for (Course course : courseList) {
					System.out.println(course);
				}*/
			} else if ("classes".equalsIgnoreCase(tableName)) {
				request.setAttribute("tableName", "CLASSES");
				request.setAttribute("classList", classList);
				/*for (Classes cl : classList) {
					System.out.println(cl);
				}*/
			} else if ("enrollments".equalsIgnoreCase(tableName)) {
				request.setAttribute("tableName", "ENROLLMENTS");
				request.setAttribute("enrollmentList", enrollmentList);
				/*for (Enrollment enroll : enrollmentList) {
					System.out.println(enroll);
				}*/
			} else if ("prerequisites".equalsIgnoreCase(tableName)) {
				request.setAttribute("tableName", "PREREQUISITES");
				request.setAttribute("prereqList", prereqList);
				/*for (Prerequisite prereq : prereqList) {
					System.out.println(prereq);
				}*/
			} else if ("logs".equalsIgnoreCase(tableName)) {
				request.setAttribute("tableName", "LOGS");
				request.setAttribute("logList", logList);
				/*for (Log log : logList) {
					System.out.println(log);
				}*/
			}
			RequestDispatcher disp = this.getServletContext().getRequestDispatcher("/WEB-INF/views/displayTableContent.jsp");
			disp.forward(request, response);
		}
	}

}
