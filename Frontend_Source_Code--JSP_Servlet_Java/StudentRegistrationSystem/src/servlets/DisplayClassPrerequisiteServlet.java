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
import dboperations.DisplayClassPrerequisite;

/**
 * Servlet implementation class DisplayClassPrerequisiteServlet
 */
@WebServlet("/displayClassPrerequisiteServlet")
public class DisplayClassPrerequisiteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default Constructor
	 * @see HttpServlet#HttpServlet()
	 */
	public DisplayClassPrerequisiteServlet() {
		super();
	}

	/**
	 * Method to display Class Prerequisite Page
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Forward request to login page
		RequestDispatcher disp = this.getServletContext().getRequestDispatcher("/WEB-INF/views/displayClassPrerequisite.jsp");
		disp.forward(request, response);
	}

	/**
	 * Method to invoke DB procedure as per the request from UI and return response to UI
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Local variables
		boolean hasError = false;
		String errorMessage = null;
		List<String> prereqDetailsList = null;
		String deptCode = request.getParameter("deptCode");
		String courseNumStr = request.getParameter("courseNumber");
		Connection conn = OraConnection.dbConnection;

		// Validation for empty input from front end side
		if (deptCode == null || courseNumStr == null || deptCode.length() == 0 || courseNumStr.length() == 0) {
			hasError = true;
			errorMessage = "Please enter Department Code and Course Number.";
		} else {
			int courseNumber = Integer.parseInt(courseNumStr);
			// Call respective DB procedure using respective Model class
			try {
				prereqDetailsList = DisplayClassPrerequisite.getCoursePrerequisite(conn, deptCode, courseNumber);
			} catch(SQLException ex) {
				ex.printStackTrace();
				hasError = true;
				errorMessage = ex.getMessage();
			}
		}

		// Condition check for valid/ invalid credentials
		request.setAttribute("courseInfo", deptCode + courseNumStr);
		if (hasError) {
			// Forward loaded error to same page
			request.setAttribute("errorMessage", errorMessage);
		} else {
			if (prereqDetailsList.size() > 0) {
				if ("Error".equals(prereqDetailsList.get(0))) {
					request.setAttribute("errorMessage", prereqDetailsList.get(1));
				} else {
					request.setAttribute("prereqDetailsList", prereqDetailsList);
				}
			}
		}
		RequestDispatcher disp = this.getServletContext().getRequestDispatcher("/WEB-INF/views/displayClassPrerequisite.jsp");
		disp.forward(request, response);
	}
}
