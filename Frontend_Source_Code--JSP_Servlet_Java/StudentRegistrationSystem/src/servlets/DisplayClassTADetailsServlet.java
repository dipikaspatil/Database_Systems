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
import dboperations.DisplayClassTADetails;

/**
 * Servlet implementation class DisplayClassTADetailsServlet
 */
@WebServlet("/displayClassTADetailsServlet")
public class DisplayClassTADetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default Constructor
	 * @see HttpServlet#HttpServlet()
	 */
	public DisplayClassTADetailsServlet() {
		super();
	}

	/**
	 * Method to display Class TA Details Page
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Forward request to login page
		RequestDispatcher disp = this.getServletContext().getRequestDispatcher("/WEB-INF/views/displayClassTADetails.jsp");
		disp.forward(request, response);
	}

	/**
	 * Method to invoke DB procedure as per the request from UI and return response to UI
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Local variables
		boolean hasError = false;
		String errorMessage = null;
		List<String> taDetailsList = null;
		String classId = request.getParameter("classId");
		Connection conn = OraConnection.dbConnection;

		// Validation for empty input from front end side
		if (classId == null || classId.length() == 0) {
			hasError = true;
			errorMessage = "Please enter Class ID.";
		} else {
			// Call respective DB procedure using respective Model class
			try {
				taDetailsList = DisplayClassTADetails.showClassTaDetails(conn, classId);
			} catch(SQLException ex) {
				ex.printStackTrace();
				hasError = true;
				errorMessage = ex.getMessage();
			}
		}

		// Condition check for valid/ invalid credentials
		request.setAttribute("classId", classId);
		if (hasError) {
			// Forward loaded error to same page
			request.setAttribute("errorMessage", errorMessage);
		} else {
			if (taDetailsList.size() > 0) {
				if ("Error".equals(taDetailsList.get(0))) {
					request.setAttribute("errorMessage", taDetailsList.get(1));
				} else {
					request.setAttribute("taBNumber", taDetailsList.get(0));
					request.setAttribute("taFirstName", taDetailsList.get(1));
					request.setAttribute("taLastName", taDetailsList.get(2));
				}
			}
		}
		RequestDispatcher disp = this.getServletContext().getRequestDispatcher("/WEB-INF/views/displayClassTADetails.jsp");
		disp.forward(request, response);
	}
}
