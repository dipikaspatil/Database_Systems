PL/SQL Developer Test script 3.0
28
DECLARE
BEGIN
  --successful enrollment
  student_registration_system.ENROLL_STUDENT('B011', 'c0013');
  --successful enrollment
  student_registration_system.ENROLL_STUDENT('B011', 'c0014');
  --successful enrollment
  student_registration_system.ENROLL_STUDENT('B011', 'c0010');
  --successful enrollment
  student_registration_system.ENROLL_STUDENT('B011', 'c0011');
  --successful enrollment
  student_registration_system.ENROLL_STUDENT('B011', 'c0012');
  
  --invalid b#
  student_registration_system.ENROLL_STUDENT('B0', 'c0008');
  --invalid classid
  student_registration_system.ENROLL_STUDENT('B011', 'c000');
  --Cannot enroll into a class from a previous semester.
  student_registration_system.ENROLL_STUDENT('B009', 'c0002');
  --The class is already full.
  student_registration_system.ENROLL_STUDENT('B009', 'c0009');
  --The student is already in the class.
  student_registration_system.ENROLL_STUDENT('B001', 'c0001');
  --Students cannot be enrolled in more than five classes in the same semester.
  student_registration_system.ENROLL_STUDENT('B011', 'c0001');
  --Prerequisite not satisfied
  student_registration_system.ENROLL_STUDENT('B012', 'c0016'); 
end;
0
0
