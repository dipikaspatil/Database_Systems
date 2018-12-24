package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbconutil.OraConnection;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default Constructor
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
	}

	/**
	 * Method to display Login Page
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		// Forward request to login page
		RequestDispatcher disp = this.getServletContext().getRequestDispatcher("/WEB-INF/views/login.jsp");
		disp.forward(request, response);
	}

	/**
	 * Method to validate credentials and create DB connection
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		// Retrieve request parameters coming from Front End - View
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		boolean hasError = false;
		String errorMessage = null;

		// Validate username, password and establish oracle DB connection
		if (username == null || password == null || username.length() == 0 || password.length() == 0) {
			hasError = true;
			errorMessage = "Required username and password.";
		} else {
			try {
				OraConnection oConn = new OraConnection(username, password);
				oConn.createConnection();
			} catch(SQLException ex) {
				ex.printStackTrace();
				hasError = true;
				errorMessage = ex.getMessage();
			}
		}

		// Condition check for valid/ invalid credentials
		if (hasError) {
			// Forward loaded error request to login page
			request.setAttribute("errorMessage", errorMessage);
			RequestDispatcher disp = this.getServletContext().getRequestDispatcher("/WEB-INF/views/login.jsp");
			disp.forward(request, response);
		} else {
			// Redirect to Student Registration System home page
			response.sendRedirect(request.getContextPath() + "/srsHomeServlet");
		}
	}
}
