PL/SQL Developer Test script 3.0
26
-- Testing of "student_registration_system.class_ta" procedure
declare
  ta_b#         classes.ta_b#%type;
  ta_first_name students.first_name%type;
  ta_last_name  students.last_name%type;
begin
  -- Success
  student_registration_system.class_ta('c0001',
                                       ta_b#,
                                       ta_first_name,
                                       ta_last_name);
  dbms_output.put_line(ta_b# || ' ' || ta_first_name || ' ' ||
                       ta_last_name);

  -- Invalid classid
  student_registration_system.class_ta('c0100',
                                       ta_b#,
                                       ta_first_name,
                                       ta_last_name);

  -- No TA for valid classid
  student_registration_system.class_ta('c0007',
                                       ta_b#,
                                       ta_first_name,
                                       ta_last_name);
end;
0
0
