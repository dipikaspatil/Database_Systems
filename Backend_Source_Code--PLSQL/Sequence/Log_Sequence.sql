-- Create sequence for Log table
/*
	Sequence to generate log# automatically when new log records are inserted in log table
*/
create sequence LOG_SEQ_GENERATOR
minvalue 1
maxvalue 9999999999999999999999999999
start with 100
increment by 1
cache 20;
