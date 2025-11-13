SET SERVEROUTPUT ON;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE employees';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/


CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(100),
    salary NUMBER
);

INSERT INTO employees VALUES (101, 'Alice', 70000);
INSERT INTO employees VALUES (102, 'Bob', 55000);
INSERT INTO employees VALUES (103, 'Charlie', 45000);
COMMIT;


DECLARE
    v_emp_id   NUMBER := 101;  
    v_emp_name employees.emp_name%TYPE;
    v_salary   employees.salary%TYPE;

BEGIN
    SELECT emp_name, salary
    INTO   v_emp_name, v_salary
    FROM   employees
    WHERE  emp_id = v_emp_id;

    IF v_salary > 60000 THEN
        DBMS_OUTPUT.PUT_LINE(v_emp_name || ' has a high salary: ' || v_salary);
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_emp_name || ' has a standard salary: ' || v_salary);
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No employee found with ID ' || v_emp_id);
    
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown error occurred.');
END;
/
