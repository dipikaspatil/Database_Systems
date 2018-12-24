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

import dbconutil.OraConnection;
import dboperations.DeleteStudent;

/**
 * Servlet implementation class DeleteStudentServlet
 */
@WebServlet("/deleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default Constructor
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteStudentServlet() {
		super();
	}

	/**
	 * Method to display Delete Student Page
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Forward request to login page
		RequestDispatcher disp = this.getServletContext().getRequestDispatcher("/WEB-INF/views/deleteStudent.jsp");
		disp.forward(request, response);
	}

	/**
	 * Method to invoke DB procedure as per the request from UI and return response to UI
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Local variables
		boolean hasError = false;
		String errorMessage = null;
		List<String> deleteStudentList = null;
		String bNumber = request.getParameter("bNumber");
		Connection conn = OraConnection.dbConnection;

		// Validation for empty input from front end side
		if (bNumber == null || bNumber.length() == 0) {
			hasError = true;
			errorMessage = "Please enter B-Number.";
		} else {
			// Call respective DB procedure using respective Model class
			try {
				deleteStudentList = DeleteStudent.deleteStudent(conn, bNumber);
			} catch(SQLException ex) {
				ex.printStackTrace();
				hasError = true;
				errorMessage = ex.getMessage();
			}
		}

		// Condition check for valid/ invalid credentials
		request.setAttribute("bNumber", bNumber);
		if (hasError) {
			// Forward loaded error to same page
			request.setAttribute("errorMessage", errorMessage);
		} else {
			if (deleteStudentList.size() > 0) {
				if ("Error".equals(deleteStudentList.get(0))) {
					request.setAttribute("errorMessage", deleteStudentList.get(1));
				} else if ("Warning".equals(deleteStudentList.get(0))) {
					request.setAttribute("warningMessage", deleteStudentList.get(1));
				}
			}
		}
		RequestDispatcher disp = this.getServletContext().getRequestDispatcher("/WEB-INF/views/deleteStudent.jsp");
		disp.forward(request, response);
	}
}
