/*
  Trigger to make entry in log table on deletion of STUDENT table entry
*/
CREATE OR REPLACE TRIGGER TRIG_ON_DEL_STUDENTS_INS_LOGS
  AFTER DELETE ON STUDENTS
  FOR EACH ROW
BEGIN
  INSERT INTO LOGS
  VALUES
    (LOG_SEQ_GENERATOR.NEXTVAL,
     USER,
     SYSDATE,
     'STUDENTS',
     'DELETE',
     :OLD.B#);
END;
/
