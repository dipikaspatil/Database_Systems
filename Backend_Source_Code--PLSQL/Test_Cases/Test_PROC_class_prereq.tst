PL/SQL Developer Test script 3.0
8
declare 
  -- Local variables here
 l_prereq VARCHAR2(10000);
begin
  -- Test statements here
  student_registration_system.CLASS_PREREQ('cs', '532', l_prereq);
  dbms_output.put_line(l_prereq);
end;
0
0
