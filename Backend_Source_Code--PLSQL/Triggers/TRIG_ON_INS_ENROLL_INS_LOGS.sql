/*
	Trigger to make entry in log table on insertion of enrollment table entry
*/
CREATE OR REPLACE TRIGGER TRIG_ON_INS_ENROLL_INS_LOGS
  AFTER INSERT ON ENROLLMENTS
  FOR EACH ROW
BEGIN
  INSERT INTO LOGS
  VALUES
    (LOG_SEQ_GENERATOR.NEXTVAL,
     USER,
     SYSDATE,
     'ENROLLMENTS',
     'INSERT',
     :NEW.B# || ',' || :NEW.CLASSID);
END;
/
