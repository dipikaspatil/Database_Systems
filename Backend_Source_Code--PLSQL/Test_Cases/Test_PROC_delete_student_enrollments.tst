PL/SQL Developer Test script 3.0
7
declare 
begin
  -- successful test case
  --student_registration_system.DELETE_STUDENT_ENROLLMENT('b001', 'c0002');
  -- prerequisite test case
  student_registration_system.DELETE_STUDENT_ENROLLMENT('b001', 'c0001');
end;
0
0
