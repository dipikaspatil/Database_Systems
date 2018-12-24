## STUDENT REGISTRATION SYSTEM

#### PL/SQL Backend Source Code

--------------------------------------------------------------------------------------------------------------------

#### PL/SQL Instructions (Complete Setup):

* **COMMAND TO SETUP COMPLETE DB IN ONE GO**:
	* start DB_Full_Setup

--------------------------------------------------------------------------------------------------------------------

#### PL/SQL Instructions (One-by-One Setup):

* **COMMAND TO SETUP DB OBJECTS ONE BY ONE**:

	* **Command to setup database (Drop all tables, triggers, sequence and creation / insertion of tables)**:
		* start DB_Basic_Setup

	* **Command to create and start Sequence**:
		* start Log_Sequence

	* **Command to create and start Triggers**:
		* start TRIG_ON_DEL_ENROLL_INS_LOGS
		* start TRIG_ON_DEL_ENROLL_UPD_CLASSES
		* start TRIG_ON_DEL_STUD_DEL_ENROLL
		* start TRIG_ON_DEL_STUDENTS_DEL_TA
		* start TRIG_ON_DEL_STUDENTS_INS_LOGS
		* start TRIG_ON_DEL_TAS_INS_LOGS
		* start TRIG_ON_DEL_TAS_UPD_CLASSES
		* start TRIG_ON_INS_ENROLL_INS_LOGS
		* start TRIG_ON_INS_ENROLL_UPD_CLASSES
		* start TRIG_ON_UPD_CLASSES_INS_LOGS

	* **Command to create Package Specification**:
		* start STUDENT_REGISTRATION_SYSTEM_SPEC

	* **Command to create Package Body**:
		* start STUDENT_REGISTRATION_SYSTEM_BODY

--------------------------------------------------------------------------------------------------------------------