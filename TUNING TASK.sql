CREATE TABLE SOE.ORDERS2 ( ORDER_ID NUMBER(12), ORDER_DATE TIMESTAMP(6) WITH
LOCAL TIME ZONE, ORDER_TOTAL NUMBER(8,2),ORDER_MODE VARCHAR2(8), CUSTOMER_ID
NUMBER(12), ORDER_STATUS NUMBER(2), SALES_REP_ID NUMBER(6));

INSERT INTO SOE.ORDERS2 SELECT ORDER_ID, ORDER_DATE, ORDER_TOTAL, ORDER_MODE,
CUSTOMER_ID, ORDER_STATUS, SALES_REP_ID FROM SOE.ORDERS WHERE ORDER_TOTAL
BETWEEN 10000 AND 15000;


SET AUTOTRACE TRACEONLY;

SELECT COUNT(*) FROM SOE.ORDERS2 WHERE ORDER_TOTAL < 10050;


SET AUTOT OFF
DECLARE
V_TASK_NAME VARCHAR2(30);
V_SQLTEXT CLOB;
BEGIN
V_SQLTEXT := 'select count(*) from student where classno=30';
V_TASK_NAME := DBMS_SQLTUNE.CREATE_TUNING_TASK (
 SQL_TEXT => V_SQLTEXT,
 USER_NAME => 'SOE',
 SCOPE => 'COMPREHENSIVE',
 TIME_LIMIT => NULL,
 TASK_NAME => 'STA_STUDENT_TTASK',
 DESCRIPTION => 'A sample STA tuning task');
END;
/ 

exec DBMS_SQLTUNE.EXECUTE_TUNING_TASK(TASK_NAME=>'STA_STUDENT_TTASK')
SELECT DBMS_SQLTUNE.REPORT_TUNING_TASK('STA_STUDENT_TTASK' ) FROM DUAL;


create index SOE.IDX$$_00350001 on SOE.ORDERS2("ORDER_TOTAL");
