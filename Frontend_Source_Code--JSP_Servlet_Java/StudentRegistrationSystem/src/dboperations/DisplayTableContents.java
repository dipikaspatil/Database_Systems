package dboperations;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import beans.Classes;
import beans.Course;
import beans.Enrollment;
import beans.Log;
import beans.Prerequisite;
import beans.Student;
import beans.Ta;
import oracle.jdbc.OracleTypes;

/**
 * Class to display DB table contents
 */
public class DisplayTableContents {

	/**
	 * Method to show contents of Students DB table
	 * @param conn
	 * @throws SQLException
	 */
	public static List<Student> showStudents(Connection conn) throws SQLException {
		// Local variable
		String query = "begin student_registration_system.show_students(:1); end;";

		//Prepare to call stored procedure:
		CallableStatement cs = conn.prepareCall(query);

		//register the out parameter (the second parameter)
		cs.registerOutParameter(1, OracleTypes.CURSOR);

		//execute the stored procedure
		cs.executeQuery();
		ResultSet rs = (ResultSet)cs.getObject(1);

		// Save students contents in list
		List<Student> studentList = new ArrayList<>();
		while (rs.next()) {
			Student student = new Student();
			student.setbNumber(rs.getString(1));
			student.setFirstName(rs.getString(2));
			student.setLastName(rs.getString(3));
			student.setStatus(rs.getString(4));
			student.setGpa(rs.getFloat(5));
			student.setEmail(rs.getString(6));
			student.setBirthDate(rs.getDate(7));
			student.setDeptName(rs.getString(8));

			studentList.add(student);
		}

		return studentList;
	}

	/**
	 * Method to show contents of TAs DB table
	 * @param conn
	 * @throws SQLException
	 */
	public static List<Ta> showTas(Connection conn) throws SQLException {
		// Local variable
		String query = "begin student_registration_system.show_tas(:1); end;";

		//Prepare to call stored procedure:
		CallableStatement cs = conn.prepareCall(query);

		//register the out parameter (the second parameter)
		cs.registerOutParameter(1, OracleTypes.CURSOR);

		//execute the stored procedure
		cs.executeQuery();
		ResultSet rs = (ResultSet)cs.getObject(1);

		// Save students contents in list
		List<Ta> taList = new ArrayList<>();
		while (rs.next()) {
			Ta ta = new Ta();
			ta.setbNumber(rs.getString(1));
			ta.setTaLevel(rs.getString(2));
			ta.setOffice(rs.getString(3));

			taList.add(ta);
		}

		return taList;
	}

	/**
	 * Method to show contents of Courses DB table
	 * @param conn
	 * @throws SQLException
	 */
	public static List<Course> showCourses(Connection conn) throws SQLException {
		// Local variable
		String query = "begin student_registration_system.show_courses(:1); end;";

		//Prepare to call stored procedure:
		CallableStatement cs = conn.prepareCall(query);

		//register the out parameter (the second parameter)
		cs.registerOutParameter(1, OracleTypes.CURSOR);

		//execute the stored procedure
		cs.executeQuery();
		ResultSet rs = (ResultSet)cs.getObject(1);

		// Save students contents in list
		List<Course> courseList = new ArrayList<>();
		while (rs.next()) {
			Course course = new Course();
			course.setDeptCode(rs.getString(1));
			course.setCourseNumber(rs.getInt(2));
			course.setTitle(rs.getString(3));

			courseList.add(course);
		}

		return courseList;
	}

	/**
	 * Method to show contents of Classes DB table
	 * @param conn
	 * @throws SQLException
	 */
	public static List<Classes> showClasses(Connection conn) throws SQLException {
		// Local variable
		String query = "begin student_registration_system.show_classes(:1); end;";

		//Prepare to call stored procedure:
		CallableStatement cs = conn.prepareCall(query);

		//register the out parameter (the second parameter)
		cs.registerOutParameter(1, OracleTypes.CURSOR);

		//execute the stored procedure
		cs.executeQuery();
		ResultSet rs = (ResultSet)cs.getObject(1);

		// Save students contents in list
		List<Classes> classList = new ArrayList<>();
		while (rs.next()) {
			Classes cl = new Classes();
			cl.setClassId(rs.getString(1));
			cl.setDeptCode(rs.getString(2));
			cl.setCourseNumber(rs.getInt(3));
			cl.setSectionNumber(rs.getInt(4));
			cl.setYear(rs.getInt(5));
			cl.setSemester(rs.getString(6));
			cl.setLimit(rs.getInt(7));
			cl.setClassSize(rs.getInt(8));
			cl.setRoom(rs.getString(9));
			cl.setTaBNumber(rs.getString(10));

			classList.add(cl);
		}

		return classList;
	}

	/**
	 * Method to show contents of Enrollments DB table
	 * @param conn
	 * @throws SQLException
	 */
	public static List<Enrollment> showEnrollments(Connection conn) throws SQLException {
		// Local variable
		String query = "begin student_registration_system.show_enrollments(:1); end;";

		//Prepare to call stored procedure:
		CallableStatement cs = conn.prepareCall(query);

		//register the out parameter (the second parameter)
		cs.registerOutParameter(1, OracleTypes.CURSOR);

		//execute the stored procedure
		cs.executeQuery();
		ResultSet rs = (ResultSet)cs.getObject(1);

		// Save students contents in list
		List<Enrollment> enrollmentList = new ArrayList<>();
		while (rs.next()) {
			Enrollment enroll = new Enrollment();
			enroll.setbNumber(rs.getString(1));
			enroll.setClassId(rs.getString(2));
			enroll.setlGrade(rs.getString(3));

			enrollmentList.add(enroll);
		}

		return enrollmentList;
	}

	/**
	 * Method to show contents of Prerequisites DB table
	 * @param conn
	 * @throws SQLException
	 */
	public static List<Prerequisite> showPrerequisites(Connection conn) throws SQLException {
		// Local variable
		String query = "begin student_registration_system.show_prerequisites(:1); end;";

		//Prepare to call stored procedure:
		CallableStatement cs = conn.prepareCall(query);

		//register the out parameter (the second parameter)
		cs.registerOutParameter(1, OracleTypes.CURSOR);

		//execute the stored procedure
		cs.executeQuery();
		ResultSet rs = (ResultSet)cs.getObject(1);

		// Save students contents in list
		List<Prerequisite> prereqList = new ArrayList<>();
		while (rs.next()) {
			Prerequisite prereq = new Prerequisite();
			prereq.setDeptCode(rs.getString(1));
			prereq.setCourseNumber(rs.getInt(2));
			prereq.setPreDeptCode(rs.getString(3));
			prereq.setPreCourseNumber(rs.getInt(4));

			prereqList.add(prereq);
		}

		return prereqList;
	}

	/**
	 * Method to show contents of Logs DB table
	 * @param conn
	 * @throws SQLException
	 */
	public static List<Log> showLogs(Connection conn) throws SQLException {
		// Local variable
		String query = "begin student_registration_system.show_logs(:1); end;";

		//Prepare to call stored procedure:
		CallableStatement cs = conn.prepareCall(query);

		//register the out parameter (the second parameter)
		cs.registerOutParameter(1, OracleTypes.CURSOR);

		//execute the stored procedure
		cs.executeQuery();
		ResultSet rs = (ResultSet)cs.getObject(1);

		// Save students contents in list
		List<Log> logList = new ArrayList<>();
		while (rs.next()) {
			Log log = new Log();
			log.setLogNumber(rs.getInt(1));
			log.setOpName(rs.getString(2));
			log.setOpTime(rs.getDate(3));
			log.setTableName(rs.getString(4));
			log.setOperation(rs.getString(5));
			log.setKeyvalue(rs.getString(6));

			logList.add(log);
		}

		return logList;
	}
}
