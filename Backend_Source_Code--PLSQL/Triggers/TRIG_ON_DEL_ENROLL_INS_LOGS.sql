/*
	Trigger to make entry in log table on deletion of enrollment table entry
*/
CREATE OR REPLACE TRIGGER TRIG_ON_DEL_ENROLL_INS_LOGS
  AFTER DELETE ON ENROLLMENTS
  FOR EACH ROW
BEGIN
  INSERT INTO LOGS
  VALUES
    (LOG_SEQ_GENERATOR.NEXTVAL,
     USER,
     SYSDATE,
     'ENROLLMENTS',
     'DELETE',
     :OLD.B# || ',' || :OLD.CLASSID);
END;
/
