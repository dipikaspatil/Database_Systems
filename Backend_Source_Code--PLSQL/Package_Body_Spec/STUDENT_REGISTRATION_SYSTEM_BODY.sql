CREATE OR REPLACE PACKAGE BODY STUDENT_REGISTRATION_SYSTEM AS

  -- Helper Functions

  /*
   * Function to validate B# of a student
   */
  FUNCTION VALIDATE_STUDENT_B#(B#_IN IN STUDENTS.B#%TYPE) RETURN BOOLEAN IS
    STUDENT_COUNT NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO STUDENT_COUNT
      FROM STUDENTS
     WHERE UPPER(B#) = UPPER(B#_IN);
    IF STUDENT_COUNT > 0 THEN
      RETURN TRUE;
    END IF;
    RETURN FALSE;
  END;

  /*
   * Function to validate DEPTCODE of a COURSES
   */
  FUNCTION VALIDATE_DEPTCODE_COURSE#(DEPTCODE_IN IN COURSES.DEPT_CODE%TYPE,
                                     COURSE#_IN  IN COURSES.COURSE#%TYPE)
    RETURN BOOLEAN IS
    VALID_COUNT NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO VALID_COUNT
      FROM COURSES
     WHERE UPPER(DEPT_CODE) = UPPER(DEPTCODE_IN)
       AND COURSE# = COURSE#_IN;
    IF VALID_COUNT > 0 THEN
      RETURN TRUE;
    END IF;
    RETURN FALSE;
  END;

  /*
   * Function to validate classid of a classes
   */
  FUNCTION VALIDATE_STUDENT_CLASSID(CLASSID_IN IN CLASSES.CLASSID%TYPE)
    RETURN BOOLEAN IS
    CLASS_CNT NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO CLASS_CNT
      FROM CLASSES
     WHERE UPPER(CLASSID) = UPPER(CLASSID_IN);
    IF CLASS_CNT > 0 THEN
      RETURN TRUE;
    END IF;
    RETURN FALSE;
  END;

  /*
   * Function to validate whether particular class is offered in current semester or not
   * Current sem - FALL2018  
   */
  FUNCTION VALIDATE_CURRENT_SEM_CLASS(CLASSID_IN IN CLASSES.CLASSID%TYPE)
    RETURN BOOLEAN IS
    CLASS_CNT NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO CLASS_CNT
      FROM CLASSES
     WHERE UPPER(CLASSID) = UPPER(CLASSID_IN)
       AND UPPER(SEMESTER) = 'FALL'
       AND YEAR = 2018;
  
    IF CLASS_CNT > 0 THEN
      RETURN TRUE;
    END IF;
    RETURN FALSE;
  END;

  /*
   * Procedure to get course# and dept_code from classes for given classid
   */
  PROCEDURE GET_COURSE_INFO(CLASSID_IN    IN CLASSES.CLASSID%TYPE,
                            DEPT_CODE_OUT OUT CLASSES.DEPT_CODE%TYPE,
                            COURSE#_OUT   OUT CLASSES.COURSE#%TYPE) IS
    CURSOR C1 IS
      SELECT DEPT_CODE, COURSE# FROM CLASSES WHERE CLASSID = CLASSID_IN;
  BEGIN
    OPEN C1;
    FETCH C1
      INTO DEPT_CODE_OUT, COURSE#_OUT;
    CLOSE C1;
  END;

  /*
   * Function to validate whether particular student is enrolled or not
   */
  FUNCTION VALIDATE_STUDENT_ENROLLMENTS(B#_IN      IN STUDENTS.B#%TYPE,
                                        CLASSID_IN IN CLASSES.CLASSID%TYPE)
    RETURN BOOLEAN IS
    ENROLLMENTS_CNT NUMBER;
    L_DEPT_CODE_OUT CLASSES.DEPT_CODE%TYPE;
    L_COURSE#_OUT   CLASSES.COURSE#%TYPE;
    T_DEPT_CODE_OUT CLASSES.DEPT_CODE%TYPE;
    T_COURSE#_OUT   CLASSES.COURSE#%TYPE;
  
    CURSOR C1 IS
      SELECT CLASSID FROM ENROLLMENTS E WHERE UPPER(E.B#) = UPPER(B#_IN);
  
  BEGIN
    SELECT COUNT(1)
      INTO ENROLLMENTS_CNT
      FROM ENROLLMENTS
     WHERE UPPER(B#) = UPPER(B#_IN)
       AND UPPER(CLASSID) = UPPER(CLASSID_IN);
  
    GET_COURSE_INFO(CLASSID_IN, L_DEPT_CODE_OUT, L_COURSE#_OUT);
    --DBMS_OUTPUT.PUT_LINE('L ' || L_DEPT_CODE_OUT || L_COURSE#_OUT);
    FOR C1_REC IN C1 LOOP
      GET_COURSE_INFO(C1_REC.CLASSID, T_DEPT_CODE_OUT, T_COURSE#_OUT);
      --DBMS_OUTPUT.PUT_LINE(T_DEPT_CODE_OUT || T_COURSE#_OUT);
      IF T_DEPT_CODE_OUT = L_DEPT_CODE_OUT AND
         T_COURSE#_OUT = L_COURSE#_OUT THEN
        RETURN TRUE;
      END IF;
    END LOOP;
  
    IF ENROLLMENTS_CNT > 0 THEN
      RETURN TRUE;
    END IF;
    RETURN FALSE;
  END;

  /*
   * Function to validate pre-req course condition for given classid
   */
  FUNCTION VALIDATE_STUDENT_PREREQ(B#_IN      IN ENROLLMENTS.B#%TYPE,
                                   CLASSID_IN IN ENROLLMENTS.CLASSID%TYPE)
    RETURN BOOLEAN IS
    CURSOR C1 IS
      SELECT E.CLASSID
        FROM ENROLLMENTS E, CLASSES C
       WHERE UPPER(E.B#) = UPPER(B#_IN)
         AND UPPER(E.CLASSID) != UPPER(CLASSID_IN)
         AND E.CLASSID = C.CLASSID
         AND UPPER(C.SEMESTER) = 'FALL'
         AND C.YEAR = 2018;
  
    --CURRENT_PREREQ  VARCHAR2(10000);
    L_DEPT_CODE     CLASSES.DEPT_CODE%TYPE;
    L_COURSE#       CLASSES.COURSE#%TYPE;
    L_CUR_DEPT_CODE CLASSES.DEPT_CODE%TYPE;
    L_CUR_COURSE#   CLASSES.COURSE#%TYPE;
    L_PREREQ        VARCHAR2(10000);
  BEGIN
    GET_COURSE_INFO(CLASSID_IN, L_DEPT_CODE, L_COURSE#);
    FOR C1_REC IN C1 LOOP
      -- Get DEPT_CODE and COURSE# for specific CLASSID
      GET_COURSE_INFO(C1_REC.CLASSID, L_CUR_DEPT_CODE, L_CUR_COURSE#);
      -- Get all prerequisite courses for above course info
      CLASS_PREREQ(L_CUR_DEPT_CODE, L_CUR_COURSE#, L_PREREQ);
      -- Check if input course info is prereq of any other enrolled course
      IF INSTR(L_PREREQ, (L_DEPT_CODE || L_COURSE#)) > 0 THEN
        RETURN FALSE;
      END IF;
    END LOOP;
    RETURN TRUE;
  END;

  /*
   * Function to validate last enrolled class for the student
   */
  FUNCTION VALIDATE_LAST_ENROLLMENT(B#_IN IN ENROLLMENTS.B#%TYPE)
    RETURN BOOLEAN IS
    CURSOR C1 IS
      SELECT COUNT(1) FROM ENROLLMENTS WHERE UPPER(B#) = UPPER(B#_IN);
    CLASS_CNT NUMBER;
  BEGIN
    OPEN C1;
    FETCH C1
      INTO CLASS_CNT;
    CLOSE C1;
    IF CLASS_CNT = 1 THEN
      RETURN FALSE;
    END IF;
    RETURN TRUE;
  END;

  /*
   * Function to validate last enrolled student for the class
   */
  FUNCTION VALIDATE_LAST_STUDENT(CLASSID_IN IN ENROLLMENTS.CLASSID%TYPE)
    RETURN BOOLEAN IS
    CURSOR C1 IS
      SELECT COUNT(1)
        FROM ENROLLMENTS
       WHERE UPPER(CLASSID) = UPPER(CLASSID_IN);
    STUDENT_CNT NUMBER;
  BEGIN
    OPEN C1;
    FETCH C1
      INTO STUDENT_CNT;
    CLOSE C1;
    IF STUDENT_CNT = 1 THEN
      RETURN FALSE;
    END IF;
    RETURN TRUE;
  END;

  /*
   * Function to validate if class is full
   */
  FUNCTION VALIDATE_CLASS_FULL(CLASSID_IN IN CLASSES.CLASSID%TYPE)
    RETURN BOOLEAN IS
    CLASS_CNT NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO CLASS_CNT
      FROM CLASSES
     WHERE UPPER(CLASSID) = UPPER(CLASSID_IN)
       AND LIMIT = CLASS_SIZE;
  
    IF CLASS_CNT > 0 THEN
      RETURN TRUE;
    END IF;
    RETURN FALSE;
  END;

  /*
   * Function to get the count of student enrollments
   */
  FUNCTION GET_STUDENT_ENROLL_COUNT(B#_IN IN ENROLLMENTS.B#%TYPE)
    RETURN NUMBER IS
    ENROLL_CNT NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO ENROLL_CNT
      FROM ENROLLMENTS EN, CLASSES CL
     WHERE UPPER(EN.B#) = UPPER(B#_IN)
       AND UPPER(EN.CLASSID) = UPPER(CL.CLASSID)
       AND UPPER(CL.SEMESTER) = 'FALL'
       AND CL.YEAR = 2018;
  
    RETURN ENROLL_CNT;
  END;

  /*
   * Function to get classid from courses from prev semester i.e not FALL 2018
   */
  FUNCTION GET_CLASSID(COURSE_INFO IN VARCHAR2) RETURN CLASSES.CLASSID%TYPE IS
    CURSOR C1 IS
      SELECT CLASSID
        FROM CLASSES CL
       WHERE UPPER(CL.DEPT_CODE) || CL.COURSE# = UPPER(COURSE_INFO)
         AND NOT (UPPER(CL.SEMESTER) = 'FALL' AND CL.YEAR = 2018);
  
    L_CLASSID CLASSES.CLASSID%TYPE;
  BEGIN
    OPEN C1;
    FETCH C1
      INTO L_CLASSID;
    CLOSE C1;
    RETURN L_CLASSID;
  END;

  /*
   * Function to get grade of student for particular class - from enrollments
   */
  FUNCTION GET_GRADE(B#_IN      IN ENROLLMENTS.B#%TYPE,
                     CLASSID_IN IN ENROLLMENTS.CLASSID%TYPE)
    RETURN ENROLLMENTS.LGRADE%TYPE IS
    CURSOR C1 IS
      SELECT EN.LGRADE
        FROM ENROLLMENTS EN
       WHERE UPPER(EN.B#) = UPPER(B#_IN)
         AND UPPER(EN.CLASSID) = UPPER(CLASSID_IN);
    L_GRADE ENROLLMENTS.LGRADE%TYPE;
  BEGIN
    OPEN C1;
    FETCH C1
      INTO L_GRADE;
    CLOSE C1;
    RETURN L_GRADE;
  END;

  /*
   * Function to validate pre-req course condition for given classid
   */
  FUNCTION VALIDATE_STUDENT_PREREQ_GRADE(B#_IN      IN ENROLLMENTS.B#%TYPE,
                                         CLASSID_IN IN ENROLLMENTS.CLASSID%TYPE)
    RETURN BOOLEAN IS
    CURSOR C1(C_PREREQ IN VARCHAR2) IS
      SELECT REGEXP_SUBSTR(C_PREREQ, '[^,]+', 1, LEVEL) AS DATA
        FROM DUAL
      CONNECT BY REGEXP_SUBSTR(C_PREREQ, '[^,]+', 1, LEVEL) IS NOT NULL;
  
    L_DEPT_CODE   CLASSES.DEPT_CODE%TYPE;
    L_COURSE#     CLASSES.COURSE#%TYPE;
    L_PREREQ      VARCHAR2(10000);
    L_CLASSID     CLASSES.CLASSID%TYPE;
    L_CURR_PREREQ VARCHAR2(10000);
    L_GRADE       ENROLLMENTS.LGRADE%TYPE;
  BEGIN
    --get course info of a class
    GET_COURSE_INFO(CLASSID_IN, L_DEPT_CODE, L_COURSE#);
    --get all prereq of course
    CLASS_PREREQ(L_DEPT_CODE, L_COURSE#, L_PREREQ);
  
    IF L_PREREQ IS NULL THEN
      RETURN TRUE;
    END IF;
  
    --check one by one for all prereq - whether student has enrolled in prev sem and has gread atleast c
    FOR C1_REC IN C1(L_PREREQ) LOOP
      L_CURR_PREREQ := C1_REC.DATA;
      L_CLASSID     := GET_CLASSID(L_CURR_PREREQ);
      IF L_CLASSID IS NULL THEN
        RETURN FALSE;
      END IF;
      --check the grade - if greater than c - return false - required grade atleast c 
      L_GRADE := GET_GRADE(B#_IN, L_CLASSID);
      IF L_GRADE IS NULL OR
         (UPPER(SUBSTR(L_GRADE, 1, 1)) > 'C' OR UPPER(L_GRADE) = 'C-') THEN
        RETURN FALSE;
      END IF;
    END LOOP;
    RETURN TRUE;
  END;

  /*
   * Procedures to display the tuples in each of the seven tables for this project.
   * Procedure "show_students"
   */
  PROCEDURE SHOW_STUDENTS(REF_CURSOR_STUDENTS OUT REF_CURSOR) IS
  BEGIN
    OPEN REF_CURSOR_STUDENTS FOR
      SELECT * FROM STUDENTS;
  END;

  /*
   * Procedures to display the tuples in each of the seven tables for this project.
   * Procedure "show_tas"
   */
  PROCEDURE SHOW_TAS(REF_CURSOR_TAS OUT REF_CURSOR) IS
  BEGIN
    OPEN REF_CURSOR_TAS FOR
      SELECT * FROM TAS;
  END;

  /*
   * Procedures to display the tuples in each of the seven tables for this project.
   * Procedure "show_courses"
   */
  PROCEDURE SHOW_COURSES(REF_CURSOR_COURSES OUT REF_CURSOR) IS
  BEGIN
    OPEN REF_CURSOR_COURSES FOR
      SELECT * FROM COURSES;
  END;

  /*
   * Procedures to display the tuples in each of the seven tables for this project.
   * Procedure "show_classes"
   */
  PROCEDURE SHOW_CLASSES(REF_CURSOR_CLASSES OUT REF_CURSOR) IS
  BEGIN
    OPEN REF_CURSOR_CLASSES FOR
      SELECT * FROM CLASSES;
  END;

  /*
   * Procedures to display the tuples in each of the seven tables for this project.
   * Procedure "show_enrollments"
   */
  PROCEDURE SHOW_ENROLLMENTS(REF_CURSOR_ENROLLMENTS OUT REF_CURSOR) IS
  BEGIN
    OPEN REF_CURSOR_ENROLLMENTS FOR
      SELECT * FROM ENROLLMENTS;
  END;

  /*
   * Procedures to display the tuples in each of the seven tables for this project.
   * Procedure "show_prerequisites"
   */
  PROCEDURE SHOW_PREREQUISITES(REF_CURSOR_PREREQUISITES OUT REF_CURSOR) IS
  BEGIN
    OPEN REF_CURSOR_PREREQUISITES FOR
      SELECT * FROM PREREQUISITES;
  END;

  /*
   * Procedures to display the tuples in each of the seven tables for this project.
   * Procedure "show_logs"
   */
  PROCEDURE SHOW_LOGS(REF_CURSOR_LOGS OUT REF_CURSOR) IS
  BEGIN
    OPEN REF_CURSOR_LOGS FOR
      SELECT * FROM LOGS;
  END;

  /*
   * Procedure to list B#, first name and last name of the TA of the class for a given class
   * If the class does not have a TA, report “The class has no TA.” 
   * If the provided classid is invalid (i.e., not in the Classes table), report “The classid is invalid.”
   */
  PROCEDURE CLASS_TA(CLASSID_IN     IN CLASSES.CLASSID%TYPE,
                     TA_B#_OUT      OUT CLASSES.TA_B#%TYPE,
                     FIRST_NAME_OUT OUT STUDENTS.FIRST_NAME%TYPE,
                     LAST_NAME_OUT  OUT STUDENTS.LAST_NAME%TYPE) IS
  
    CURSOR CUR_CHECK_CLASSID IS
      SELECT CL.CLASSID
        FROM CLASSES CL
       WHERE UPPER(CLASSID) = UPPER(CLASSID_IN);
  
    L_CLASS_ID CLASSES.CLASSID%TYPE;
    E_NO_CLASS_TA     EXCEPTION;
    E_INVALID_CLASSID EXCEPTION;
  BEGIN
    OPEN CUR_CHECK_CLASSID;
    FETCH CUR_CHECK_CLASSID
      INTO L_CLASS_ID;
  
    IF L_CLASS_ID IS NULL THEN
      RAISE E_INVALID_CLASSID;
    END IF;
  
    SELECT B#, FIRST_NAME, LAST_NAME
      INTO TA_B#_OUT, FIRST_NAME_OUT, LAST_NAME_OUT
      FROM STUDENTS ST, CLASSES CL
     WHERE UPPER(CLASSID) = UPPER(CLASSID_IN)
       AND UPPER(ST.B#) = UPPER(CL.TA_B#);
  
    CLOSE CUR_CHECK_CLASSID;
  EXCEPTION
    WHEN E_INVALID_CLASSID THEN
      DBMS_OUTPUT.PUT_LINE('The classid is invalid.');
      CLOSE CUR_CHECK_CLASSID;
    
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('The class has no TA.');
      CLOSE CUR_CHECK_CLASSID;
    
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Issue with student_registration_system.class_ta procedure' || ' ' ||
                           SQLCODE || SQLERRM);
      CLOSE CUR_CHECK_CLASSID;
  END;

  /*
   * Recursive helper procedure to get direct and indirect prerequisites
   * If course C1 has course C2 as a prerequisite, C2 is a direct prerequisite.
   * If C2 has course C3 has a prerequisite, then C3 is an indirect prerequisite for C1.
   */
  PROCEDURE GET_PREREQ_COURSE(DEPT_CODE_IN IN PREREQUISITES.DEPT_CODE%TYPE,
                              COURSE#_IN   IN PREREQUISITES.COURSE#%TYPE,
                              PRE_REQ_OUT  IN OUT VARCHAR2) IS
    CURSOR C1 IS
      SELECT PRE_DEPT_CODE, PRE_COURSE#
        FROM PREREQUISITES
       WHERE UPPER(DEPT_CODE) = UPPER(DEPT_CODE_IN)
         AND COURSE# = COURSE#_IN;
    TEMP_DEPT_CODE PREREQUISITES.PRE_DEPT_CODE%TYPE;
    TEMP_COURSE#   PREREQUISITES.PRE_COURSE#%TYPE;
  BEGIN
    FOR C1_REC IN C1 LOOP
      TEMP_DEPT_CODE := C1_REC.PRE_DEPT_CODE;
      TEMP_COURSE#   := C1_REC.PRE_COURSE#;
      PRE_REQ_OUT    := PRE_REQ_OUT || TEMP_DEPT_CODE || TEMP_COURSE# || ',';
      GET_PREREQ_COURSE(TEMP_DEPT_CODE, TEMP_COURSE#, PRE_REQ_OUT);
    END LOOP;
  END;

  /*
   * Procedure to list all prerequisite courses for given course (with dept_code and course#)
   * Including both direct and indirect prerequisite courses
   */
  PROCEDURE CLASS_PREREQ(DEPT_CODE_IN IN PREREQUISITES.DEPT_CODE%TYPE,
                         COURSE#_IN   IN PREREQUISITES.COURSE#%TYPE,
                         PRE_REQ_OUT  OUT VARCHAR2) IS
  
  BEGIN
    IF VALIDATE_DEPTCODE_COURSE#(DEPT_CODE_IN, COURSE#_IN) = FALSE THEN
      RAISE EXCP_INVALID_DEPTCODE_COURSE#;
    END IF;
    GET_PREREQ_COURSE(DEPT_CODE_IN, COURSE#_IN, PRE_REQ_OUT);
    IF LENGTH(PRE_REQ_OUT) > 0 AND SUBSTR(PRE_REQ_OUT, -1) = ',' THEN
      PRE_REQ_OUT := SUBSTR(PRE_REQ_OUT, 1, LENGTH(PRE_REQ_OUT) - 1);
    END IF;
  EXCEPTION
    WHEN EXCP_INVALID_DEPTCODE_COURSE# THEN
      DBMS_OUTPUT.PUT_LINE(DEPT_CODE_IN || COURSE#_IN ||
                           ' does not exist.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Issue with STUDENT_REGISTRATION_SYSTEM.GET_PREREQ_COURSE procedure' || ' ' ||
                           SQLCODE || SQLERRM);
  END;

  /*
   * Procedure to Enroll Student for given class (insert a tuple into Enrollments table)
   * If the student is not in the Students table, report “The B# is invalid.” 
   * If the classid is not in the classes table, report “The classid is invalid.” 
   * If the class is not offered in the current semester (i.e., Fall 2018), reject the enrollment:
      “Cannot enroll into a class from a previous semester.” 
   * If the class is already full before the enrollment request, reject the enrollment request:
      “The class is already full.” 
   * If the student is already in the class, report “The student is already in the class.” 
   * If the student is already enrolled in four other classes in the same semester and the same year, report:
      “The student will be overloaded with the new enrollment.” but still allow the student to be enrolled. 
   * If the student is already enrolled in five other classes in the same semester and the same year, report:
      “Students cannot be enrolled in more than five classes in the same semester.” and reject the enrollment.
   * If the student has not completed the required prerequisite courses with at least a grade C, reject the enrollment:
      “Prerequisite not satisfied.”
   * For all the other cases, the requested enrollment should be carried out successfully.
   */
  PROCEDURE ENROLL_STUDENT(B#_IN      IN STUDENTS.B#%TYPE,
                           CLASSID_IN IN CLASSES.CLASSID%TYPE) IS
  
  BEGIN
  
    IF VALIDATE_STUDENT_B#(B#_IN) = FALSE THEN
      --1ST VALIDATION 
      RAISE EXCP_INVALID_B#;
    ELSIF VALIDATE_STUDENT_CLASSID(CLASSID_IN) = FALSE THEN
      --2ND VALIDATION 
      RAISE EXCP_INVALID_CLASSID;
    ELSIF VALIDATE_CURRENT_SEM_CLASS(CLASSID_IN) = FALSE THEN
      --3Rd VALIDATION 
      RAISE EXCP_INVALID_SEM_CLASS;
    ELSIF VALIDATE_CLASS_FULL(CLASSID_IN) = TRUE THEN
      --4TH VALIDATION 
      RAISE EXCP_CLASS_IS_FULL;
    ELSIF VALIDATE_STUDENT_ENROLLMENTS(B#_IN, CLASSID_IN) = TRUE THEN
      --5TH VALIDATION 
      RAISE EXCP_INVALID_STUDENT_ENROLL;
    ELSIF GET_STUDENT_ENROLL_COUNT(B#_IN) >= 5 THEN
      --7TH VALIDATION 
      RAISE EXCP_EXCEEDED_ENROLLMENT;
    ELSIF VALIDATE_STUDENT_PREREQ_GRADE(B#_IN, CLASSID_IN) = FALSE THEN
      --8TH VALIDATION 
      RAISE EXCP_PREREQ_NOT_SATISFIED;
    END IF;
  
    IF GET_STUDENT_ENROLL_COUNT(B#_IN) = 4 THEN
      --6th WARNING
      DBMS_OUTPUT.PUT_LINE('MSG:The student will be overloaded with the new enrollment.');
    END IF;
  
    INSERT INTO ENROLLMENTS VALUES (B#_IN, CLASSID_IN, NULL);
    DBMS_OUTPUT.PUT_LINE('MSG:Successfully Enrolled student with B# --> ' ||
                         B#_IN || ' and Classid --> ' || CLASSID_IN);
    COMMIT;
  EXCEPTION
    WHEN EXCP_INVALID_B# THEN
      DBMS_OUTPUT.PUT_LINE('The B# is invalid.');
      --RAISE_APPLICATION_ERROR(-20008, 'The B# is invalid.');
    WHEN EXCP_INVALID_CLASSID THEN
      DBMS_OUTPUT.PUT_LINE('The classid is invalid.');
      --RAISE_APPLICATION_ERROR(-20009, 'The classid is invalid.');
    WHEN EXCP_INVALID_SEM_CLASS THEN
      DBMS_OUTPUT.PUT_LINE('Cannot enroll into a class from a previous semester.');
      --RAISE_APPLICATION_ERROR(-20010,
    --                      'Cannot enroll into a class from a previous semester.');
    WHEN EXCP_CLASS_IS_FULL THEN
      DBMS_OUTPUT.PUT_LINE('The class is already full.');
      --RAISE_APPLICATION_ERROR(-20011, 'The class is already full.');
    WHEN EXCP_INVALID_STUDENT_ENROLL THEN
      DBMS_OUTPUT.PUT_LINE('The student is already in the class.');
      --RAISE_APPLICATION_ERROR(-20012,
    --                      'The student is already in the class.');
    WHEN EXCP_EXCEEDED_ENROLLMENT THEN
      DBMS_OUTPUT.PUT_LINE('Students cannot be enrolled in more than five classes in the same semester.');
      --RAISE_APPLICATION_ERROR(-20013,
    --                      'Students cannot be enrolled in more than five classes in the same semester.');
    WHEN EXCP_PREREQ_NOT_SATISFIED THEN
      DBMS_OUTPUT.PUT_LINE('Prerequisite not satisfied.');
      --RAISE_APPLICATION_ERROR(-20014, 'Prerequisite not satisfied.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Issue with STUDENT_REGISTRATION_SYSTEM.ENROLL_STUDENT procedure' || ' ' ||
                           SQLCODE || SQLERRM);
  END;

  /*
   * Procedure to drop a student from a class (delete a tuple from Enrollments table)
   * If the student is not in the Students table, report “The B# is invalid.” 
   * If the classid is not in the Classes table, report “The classid is invalid.” 
   * If the student is not enrolled in the class, report “The student is not enrolled in the class.” 
   * If the class is not offered in Fall 2018, reject the drop attempt and report:
      “Only enrollment in the current semester can be dropped.”
   * If dropping the student from class would cause a violation of the prerequisite requirement, reject the drop attempt:
      “The drop is not permitted because another class the student registered uses it as a prerequisite.” 
   * In all the other cases, the student will be dropped from the class. 
   * If the class is the last class for the student, delete and report “This student is not enrolled in any classes.”  
   * If the student is the last student in the class, delete and report “The class now has no students.” 
   */
  PROCEDURE DELETE_STUDENT_ENROLLMENT(B#_IN      IN STUDENTS.B#%TYPE,
                                      CLASSID_IN IN CLASSES.CLASSID%TYPE) IS
  
  BEGIN
  
    IF VALIDATE_STUDENT_B#(B#_IN) = FALSE THEN
      --1ST VALIDATION 
      RAISE EXCP_INVALID_B#;
    ELSIF VALIDATE_STUDENT_CLASSID(CLASSID_IN) = FALSE THEN
      --2ND VALIDATION 
      RAISE EXCP_INVALID_CLASSID;
    ELSIF VALIDATE_STUDENT_ENROLLMENTS(B#_IN, CLASSID_IN) = FALSE THEN
      --3RD VALIDATION 
      RAISE EXCP_INVALID_STUDENT_ENROLL;
    ELSIF VALIDATE_CURRENT_SEM_CLASS(CLASSID_IN) = FALSE THEN
      --4TH VALIDATION 
      RAISE EXCP_INVALID_SEM_CLASS;
    ELSIF VALIDATE_STUDENT_PREREQ(B#_IN, CLASSID_IN) = FALSE THEN
      --5TH VALIDATION 
      RAISE EXCP_INVALID_DROP_PREREQ;
    END IF;
  
    IF VALIDATE_LAST_ENROLLMENT(B#_IN) = FALSE THEN
      --6TH WARNING
      DBMS_OUTPUT.PUT_LINE('MSG:This student is no more enrolled in any classes.');
    END IF;
  
    IF VALIDATE_LAST_STUDENT(CLASSID_IN) = FALSE THEN
      --7TH VALIDATION
      DBMS_OUTPUT.PUT_LINE('MSG:The class now has no students.');
      --RAISE EXCP_INVALID_DROP_LAST_STUDENT;
    END IF;
  
    --DELETE ENROLLMENTS AFTER ALL VALIDATION CHECKS
    DELETE FROM ENROLLMENTS
     WHERE UPPER(B#) = UPPER(B#_IN)
       AND UPPER(CLASSID) = UPPER(CLASSID_IN);
    DBMS_OUTPUT.PUT_LINE('MSG:Successfully Deleted Student Enrollment with B# --> ' ||
                         B#_IN || ' and Classid --> ' || CLASSID_IN);
    COMMIT;
  EXCEPTION
    WHEN EXCP_INVALID_B# THEN
      DBMS_OUTPUT.PUT_LINE('The B# is invalid.');
      --RAISE_APPLICATION_ERROR(-20002, 'The B# is invalid.');
    WHEN EXCP_INVALID_CLASSID THEN
      DBMS_OUTPUT.PUT_LINE('The classid is invalid.');
      --RAISE_APPLICATION_ERROR(-20003, 'The classid is invalid.');
    WHEN EXCP_INVALID_STUDENT_ENROLL THEN
      DBMS_OUTPUT.PUT_LINE('The student is not enrolled in the class.');
      --RAISE_APPLICATION_ERROR(-20004,
    --                      'The student is not enrolled in the class.');
    WHEN EXCP_INVALID_SEM_CLASS THEN
      DBMS_OUTPUT.PUT_LINE('Only enrollment in the current semester can be dropped.');
      --RAISE_APPLICATION_ERROR(-20005,
    --                      'Only enrollment in the current semester can be dropped.');
    WHEN EXCP_INVALID_DROP_PREREQ THEN
      DBMS_OUTPUT.PUT_LINE('The drop is not permitted because another class the student registered uses it as a prerequisite.');
      --RAISE_APPLICATION_ERROR(-20006,
    --                      'The drop is not permitted because another class the student registered uses it as a prerequisite.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Issue with STUDENT_REGISTRATION_SYSTEM.DELETE_STUDENT_ENROLLMENT procedure' || ' ' ||
                           SQLCODE || SQLERRM);
  END;

  /*
   * Procedure to delete Student (delete a tuple from Students table)
   * If the student is not in the Students table, report “The B# is invalid.”
   */
  PROCEDURE DELETE_STUDENT(B#_IN IN STUDENTS.B#%TYPE) IS
  BEGIN
    IF VALIDATE_STUDENT_B#(B#_IN) = FALSE THEN
      --1ST VALIDATION 
      RAISE EXCP_INVALID_B#;
    END IF;
  
    -- Triggers will delete from other tables before deleting student
    DELETE FROM STUDENTS WHERE UPPER(B#) = UPPER(B#_IN);
    DBMS_OUTPUT.PUT_LINE('MSG:Successfully Deleted Student with B# --> ' ||
                         B#_IN);
    COMMIT;
  EXCEPTION
    WHEN EXCP_INVALID_B# THEN
      DBMS_OUTPUT.PUT_LINE('The B# is invalid.');
      --RAISE_APPLICATION_ERROR(-20001, 'The B# is invalid.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Issue with STUDENT_REGISTRATION_SYSTEM.DELETE_STUDENT procedure' || ' ' ||
                           SQLCODE || SQLERRM);
  END;
END;
/
