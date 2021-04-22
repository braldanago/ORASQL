SELECT
    *
FROM employees;

SELECT
    FIRST_NAME||' '||last_name "apellido mio",
    salary,
    salary/1000 castigo
FROM
    employees;

select DISTINCT job_id FROM employees;

SELECT last_name
FROM employees
WHERE last_name LIKE 'O%';

SELECT last_name
FROM employees
WHERE last_name LIKE '_O%';

SELECT last_name, hire_date h
FROM employees
WHERE last_name LIKE '_o%'
ORDER BY h
FETCH NEXT 5 ROWS ONLY;

SELECT EMPLOYEE_ID, LAST_NAME, &&variable
FROM employees;

SELECT
    *
FROM employees
FETCH FIRST 5 ROWS ONLY;

SELECT
    last_name,
    job_id,
    hire_date
FROM
    employees
WHERE last_name IN ('Matos','Taylor')
ORDER BY hire_date;

SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
    hire_date BETWEEN '01/01/2010' AND '31/12/2010';
    
SELECT
    last_name
FROM
    employees
WHERE last_name LIKE '__a%';

SELECT
    last_name,
    job_id
FROM
    employees
WHERE MANAGER_ID IS NULL;

SELECT
    last_name
FROM
    employees
WHERE last_name LIKE '%{ae}%';


-------------------------
-- Using Single-Row Functions to Customize Output
----------------------
--CASE CONVERSION
select upper('hola mundo') from dual;

select lower('hola mUndo') from dual;

select INITCAP('hola mUndo') from dual;

--CHARACTER MANIPULATION FUNCTIONS

select concat(FIRST_NAME, LAST_NAME) from employees;

select SUBSTR('hola mundo',1,5) from dual;
select SUBSTR('hola mundo',6,5) from dual;
select SUBSTR('hola mundo',1,1) from dual;

select instr('hola mundo','m') from dual;

select rpad('hello',10,'+') from dual;

select lpad('hello',10,'+') from dual;

select trim('h' from 'holamundohphh') from dual;

select replace('hello world','hello','que hubo pues ') from dual;

select replace('Assss','A','a') from dual;

---ROUND (aproxima) AND TRUNC (posiciones decimal)
--round 45.93     trunc 45.92
select round(45.926,2) , trunc(45.926,2) from dual;


-------
---PRACTICE 4-1
------

select sysdate from dual;

SELECT
    employee_id,
    last_name,
    salary,
    ROUND(salary*1.155,0) "New Salary"
FROM
    employees;

SELECT
    employee_id,
    last_name,
    salary,
    ROUND(salary*1.155,0) "New Salary",
    ROUND(salary*1.155,0) - salary "Increase"
FROM
    employees;

SELECT
    INITCAP(last_name),
    LENGTH(last_name)
FROM
    employees
WHERE
    last_name like 'A%' or last_name like 'M%'
ORDER BY last_name;

SELECT
    INITCAP(last_name)
FROM
    employees;


SELECT
    INITCAP(last_name),
    LENGTH(last_name)
FROM
    employees
WHERE
    last_name like '&var_name%'
ORDER BY last_name;

SELECT
    INITCAP(last_name),
    LENGTH(last_name)
FROM
    employees
WHERE
    last_name like UPPER('&var_name%')
ORDER BY last_name;


SELECT
    last_name,
    round(MONTHS_BETWEEN(SYSDATE,hire_date)) "MONTHS WORKED"
FROM
    employees
ORDER BY 2;

SELECT
    last_name,
    LPAD(salary,15, '$') salary
FROM
    employees;
    
SELECT
    last_name,
    Lpad('*',TRUNC(salary/1000,0),'*'),
    salary
FROM
    employees
ORDER BY 2 DESC;


SELECT
    last_name,
    round(MONTHS_BETWEEN(SYSDATE,hire_date)*4) "TENURE"
FROM
    employees
wHERE department_id = 90
ORDER BY 2 DESC;


select ROUND(sysdate,'MONTH') from dual;
select TRUNC(sysdate,'MONTH') from dual;

SELECT ROUND(125.0,-1) FROM DUAL;
SELECT TRUNC(129.0,-1) FROM DUAL;

--------------------------------------------------------------------------------
----- 5 -- Using Conversion Functions and Conditional Expressions --------------
--------------------------------------------------------------------------------

SELECT
    employee_id,
    TO_CHAR(hire_date,'DD/MM')
FROM
    employees;
    
SELECT
    employee_id,
    TO_CHAR(salary,'$99,999.99')
FROM
    employees;
    ---------------------- GENERAL FUNCTIONS--------------
    -- NVL FUNCTION
    --converts a null value to an actual value

SELECT
    last_name,
    salary,
    commission_pct,
    NVL(commission_pct,0),
    (SALARY*12)+(SALARY*12*NVL(commission_pct,0)) Salario_anual
FROM
    employees;
    
    --NVL 2 SI NO ES NULO ENTONCES 2DO PARAMETRO, SI SI 3ER PARAMETRO

SELECT
    last_name,
    salary,
    commission_pct,
    NVL2(commission_pct,'SI','NO'),
    (SALARY*12)+(SALARY*12*NVL(commission_pct,0)) Salario_anual
FROM
    employees;

    --NULIF , SI AMBOS PARAMETROS IGUALES, RETORNA NULL, SI NO EL PRIMER PARAMETRO
    
SELECT
    first_name, LENGTH(first_name) expr1,
    last_name, LENGTH(last_name) expr2,
    NULLIF(LENGTH(first_name),LENGTH(last_name))
FROM
    employees;
    
    --COALESCE, SI EL 1ER PARAM ES NULL, RETORNA EL 2D0, Y ASI SUCESIVAMENTE

SELECT
    last_name,
    salary,
    commission_pct,
    COALESCE((salary+(commission_pct*salary)),salary+2000) "New salary"
FROM
    employees;
    
    
    --------------- CONDITIONAL EXPRESSIONS
    
SELECT
    last_name,
    job_id,
    salary,
    CASE job_id
        WHEN 'IT_PROG'   THEN
            1.10 * salary
        WHEN 'ST_CLERK'  THEN
            1.15 * salary
        ELSE
            salary
    END "REVISED SALARY"
FROM
    employees;
    
    -- SEARCHED CASE    
    
SELECT
    last_name,
    salary,
    CASE
        WHEN salary < 5000     THEN
            'LOW'
        WHEN salary < 10000    THEN
            'MEDIUM'
        WHEN salary < 20000    THEN
            'GOOD'
        ELSE
            'EXCELLENT'
    END "RANK SALARY"
FROM
    employees;
    
    --DECODE, MUY SIMILAR A CASE
SELECT
    last_name,
    job_id,
    salary,
    decode(job_id, 'IT_PROG', 1.10 * salary, 'ST_CLERK', 1.15 * salary,
           salary) "REVISED SALARY"
FROM
    employees;

-------
---PRACTICE 5-1
------


SELECT
    last_name||' EARNS '||TO_CHAR(salary,'fm$999,999.00')||' MONTHLY BUT WANTS '||TO_CHAR(salary*3,'fm$999,999.00') "Dream Salaries"
FROM
    employees;

SELECT
    last_name,
    hire_date,
    TO_CHAR(next_day(add_months(hire_date,6),1), 'fmDAY, "the" Ddspth "of "MONTH, YYYY')
FROM
    employees;
    

SELECT
    last_name,
    nvl(TO_CHAR(commission_pct),'No commission') "COMM"
FROM
    employees;

SELECT
    job_id,
    CASE job_id WHEN 'AD_PRES' THEN 'A'
                WHEN 'ST_MAN'  THEN 'B'
                WHEN 'IT_PROG' THEN 'C'
                WHEN 'SA_REP'  THEN 'D'
                WHEN 'ST_CLERK'  THEN 'E'
    ELSE '0' END "Grade"
FROM
    employees;

SELECT
    job_id,
    CASE  WHEN job_id = 'AD_PRES' THEN 'A'
                WHEN job_id = 'ST_MAN'  THEN 'B'
                WHEN job_id = 'IT_PROG' THEN 'C'
                WHEN job_id = 'SA_REP'  THEN 'D'
                WHEN job_id = 'ST_CLERK'  THEN 'E'
    ELSE '0' END "Grade"
FROM
    employees;
    
SELECT
    job_id,
    DECODE(job_id,'AD_PRES','A',
                'ST_MAN', 'B',
                'IT_PROG','C',
                'SA_REP','D',
                'ST_CLERK','E',
                '0') "Grade"
FROM
    employees;
    
--------------------------------------------------------------------------------
----- 6 -- Reporting Aggregated Data Using the Group Functions    --------------
--------------------------------------------------------------------------------

SELECT
    AVG(salary),MAX(salary),
    MIN(salary),SUM(salary)
FROM
    employees
WHERE job_id LIKE '%REP%';

/* YOU CAN USE MIN AND MAX FOR CHAR, NUM AND DATE DATA TYPES*/  
SELECT COUNT(*)
FROM employees
WHERE department_id = 50;

SELECT COUNT(commission_pct)
FROM employees
WHERE department_id = 50;
    
SELECT commission_pct
FROM employees
WHERE department_id = 90;

/*NO CUENTA VALORES NULOS*/
SELECT COUNT(DISTINCT department_id)
FROM employees;


SELECT AVG(commission_pct)
FROM employees;

SELECT AVG(NVL(commission_pct,0))
FROM employees;

/*ALL THE COLUMNS THAT ARE NOT IN GROUP FUNCTIONS MUST BE IN THE "group by" CLAUSE*/

SELECT department_id, AVG(salary) , SUM(salary)
FROM employees
GROUP BY  department_id;

/*THE "GROUP BY" COLUMN DOES NOT HAVE TO BE IN SELECT LIST*/

SELECT AVG(salary) 
FROM employees
GROUP BY department_id;

/*WE CAN ALSO GROUP BY MORE THAN ONE COLUMN*/

SELECT department_id, job_id ,AVG(salary) 
FROM employees
GROUP BY  department_id,job_id;

/*
you cannot use WHERE clause to restrict groups
you use the HAVING clause to restrict groups
you cannot use group functions in the where clause
*/
/*RESTRICT GROUPS RESULTS*/

SELECT
    department_id,
    max(salary)
FROM
    employees
GROUP BY department_id
HAVING max(salary)> 10000;

SELECT
    job_id,
    SUM(salary) payroll
FROM
    employees
WHERE
    job_id NOT LIKE '%REP%'
GROUP BY
    job_id
HAVING
    SUM(salary) > 13000
ORDER BY
    SUM(salary);

--NESTING GROUP FUNCTIONS, YOU CAN NEST GROUP FUNCTIONS TO A DEPTH OF 2

SELECT
    MAX(AVG(salary))
FROM
    employees
GROUP BY department_id;

/*
YOU CANNOT USE A COLUMN ALIAS IN THE GROUP BY CLAUSE

FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
*/


-------
---PRACTICE 6-1
------

SELECT
    job_id, MAX(salary), MIN(salary), SUM(salary), AVG(salary)
FROM
    employees
GROUP BY
    job_id;
    

SELECT
    job_id, count(*)
FROM
    employees
GROUP BY job_id;
    
    
SELECT
    count(DISTINCT manager_id) "Number of managers"
FROM 
    employees;
    
SELECT
    MAX(salary) - MIN(salary) "DIFFERENCE"
FROM
    employees; 
    
SELECT
    manager_id,
    MIN(salary)
FROM
    employees
WHERE
    manager_id IS NOT NULL
GROUP BY
    manager_id
HAVING
    MIN(salary) > 6000
ORDER BY
    MIN(salary) DESC;
    

SELECT
    COUNT(*) "TOTAL",
    SUM(decode(to_char(hire_date, 'YYYY'),'2002',1,0)) AS "2002",
    SUM(decode(to_char(hire_date, 'YYYY'),'2003',1,0)) AS "2003",
    SUM(decode(to_char(hire_date, 'YYYY'),'2004',1,0)) AS "2004",
    SUM(decode(to_char(hire_date, 'YYYY'),'2005',1,0)) AS "2005"
FROM
    employees;
    


SELECT
    DISTINCT job_id,
    sum(decode(department_id,'20',salary,NULL)) AS "Dept 20",
    sum(decode(department_id,'50',salary,NULL)) AS "Dept 50",
    sum(decode(department_id,'80',salary,NULL)) AS "Dept 80",
    sum(decode(department_id,'90',salary,NULL)) AS "Dept 90",
    sum(salary)
FROM
    employees
GROUP BY
    job_id;
    
--------------------------------------------------------------------------------
----- 7 -- Displaying Data from Multiple Tables Using Joins --------------
--------------------------------------------------------------------------------

--NATURAL JOIN (CON TABLAS QUE CONTENGAN UNA COLUMNA CON EL MISMO NOMBRE Y TIPO

SELECT
    last_name,
    department_name,
    department_id
FROM
    employees NATURAL JOIN departments;
    
--ESPCIFICAR LA COLUMNA PARA EL JOIN (USING JOIN)
SELECT
    last_name,
    department_name,
    department_id
FROM
    employees JOIN departments
USING (department_id,manager_id);

--esto causa un error, la parte de columna de la cl�usula USING no puede tener un cualificador 
SELECT
    e.last_name,
    d.department_name,
    e.manager_id
FROM
    employees e JOIN departments d
USING (d.department_id,manager_id);

--esto no, porque no se especifica la columna del using, que puede estar en ambas
--tablas
SELECT
    e.last_name,
    d.department_name,
    e.manager_id
FROM
    employees e JOIN departments d
USING (department_id);

--JOIN WITH ON CLAUSE (no hay problema con los alias)

SELECT
    e.last_name,
    d.department_name,
    e.manager_id
FROM
    employees e JOIN departments d
ON e.department_id=d.department_id
AND e.manager_id=d.manager_id;

--CREATING 3 WAY JOINS( SE PUEDEN TENER MAS DE 3 TABLAS EN UN JOIN,
--tambien podemos usar sentencias (clauses) where y and, despues de ON)

SELECT
    e.last_name,
    d.department_name,
    l.city
FROM employees e
JOIN departments d 
ON e.department_id = d.department_id
JOIN locations l 
ON d.location_id=l.location_id;

--SELF JOIN
SELECT
    e.last_name emp,
    m.last_name mang
FROM employees e JOIN employees m
ON e.manager_id=m.employee_id;

SELECT
    e.last_name emp,
    m.last_name mang
FROM employees e , employees m
WHERE e.manager_id=m.employee_id;

--NONEQUIJOINS (YA NO USAMOS EL = SI NO QUE TENEMOS EN CUENTA UN RANGO)

--no sirve(?)
SELECT
    e.last_name,
    e.salary,
    j.grade_level
FROM employees e JOIN  job_grades j
ON e.salary
BETWEEN j.lowest_sal  AND j.highest_sal;


-----------OUTER JOINS
--LEFT |[OUTER] JOIN, NOS TRAE TODOS LOS REGISTROS (IZQUIERDA) QUE INCLUSO NO COINCIDEN
--EN EL JOIN CON LA OTRA TABLA
SELECT
    e.last_name,
    d.department_name,
    e.manager_id
FROM
    employees e LEFT JOIN departments d
ON e.department_id=d.department_id;

--RIGHT |[OUTER] JOIN, , NOS TRAE TODOS LOS REGISTROS (DERECHA) QUE INCLUSO NO COINCIDEN
--EN EL JOIN CON LA OTRA TABLA (ES DECIR, DEPARTAMENTOS SIN GENTE QUE TRABAJE EN ELLOS)
SELECT
    e.last_name,
    d.department_name,
    e.manager_id
FROM
    employees e RIGHT JOIN departments d
ON e.department_id=d.department_id;

--FULL |[OUTER] JOIN, NOS TRAE TODOS LOS REGISTROS (DER E IZQ) QUE INCLUSO NO COINCIDEN
--EN EL JOIN CON LA OTRA TABLA (ES DECIR, DEPARTAMENTOS SIN GENTE QUE TRABAJE EN ELLOS
-- Y GENTE QUE NO TIENE ASIGNADO UN DEPARTAMENTO)
SELECT
    e.last_name,
    d.department_name,
    e.manager_id
FROM
    employees e FULL JOIN departments d
ON e.department_id=d.department_id;

--CROSS JOIN (PRODUCTO CARTESIANO)

SELECT
    e.last_name,
    d.department_name
FROM
    employees e CROSS JOIN departments d;
    
--LOS ANTERIORES JOINS SON LOS ANSI JOIN
--EN ORACLE, UN INNER JOIN SERIA ASI (TIENEN EL MISMO RESULTADO)

SELECT
    e.last_name,
    d.department_name
FROM
    employees e, departments d
WHERE e.department_id=d.department_id;

--ANSI INNER JOIN
SELECT
    e.last_name,
    d.department_name
FROM
    employees e JOIN departments d
ON e.department_id=d.department_id;

--ORACLE LEFT OUTER JOIN
SELECT
    e.last_name,
    d.department_name
FROM
    employees e, departments d
WHERE e.department_id=d.department_id(+);

--ORACLE RIGHT OUTER JOIN
SELECT
    e.last_name,
    d.department_name
FROM
    employees e, departments d
WHERE e.department_id(+)=d.department_id;

---------------
---PRACTICE 7-1
---------------


SELECT
    b.location_id,
    b.street_address,
    b.city,
    b.state_province,
    a.country_name
FROM
    locations  b NATURAL JOIN
    countries  a;


SELECT
    last_name,
    department_id,
    department_name
FROM
    employees  JOIN 
    departments  
USING(department_id);

---------------------------NO SON LO MISMO
SELECT
    f.last_name,
    f.job_id,
    e.department_id,
    e.department_name,
    g.city
FROM
    employees    f,
    departments  e,
    locations    g
WHERE
        e.department_id = f.department_id
    AND g.location_id = e.location_id
    AND f.employee_id = e.manager_id
    AND g.city='Toronto';
    
SELECT
    e.last_name,
    e.job_id,
    d.department_id,
    d.department_name,
    l.city
FROM employees e
JOIN departments d 
ON e.department_id = d.department_id
JOIN locations l 
ON d.location_id=l.location_id
and l.city='Toronto';
---------------------------NO SON LO MISMO

SELECT
    emp.last_name "Employee",
    emp.employee_id "Emp",
    mng.last_name "Manager",
    mng.employee_id  "mng"
FROM
    employees emp join employees mng
ON emp.manager_id=mng.employee_id;

SELECT
    emp.last_name "Employee",
    emp.employee_id "Emp",
    mng.last_name "Manager",
    mng.employee_id  "mng"
FROM
    employees emp LEFT join employees mng
ON emp.manager_id=mng.employee_id
ORDER BY "Emp";
    
--6

SELECT
    emp.department_id,
    emp.last_name "Employee",
    mng.last_name "colleage"
FROM
    employees emp join employees mng
ON emp.department_id= mng.department_id
AND  emp.employee_id!=mng.employee_id
order by 1;

select last_name, hire_date from employees where hire_date>(select hire_date from employees where last_name='Davies');

--------------------------------------------------------------------------------
----- 8 -- Using Subqueries to Solve Queries                      --------------
--------------------------------------------------------------------------------
--SINGLE ROW SUBQUERY

SELECT last_name, salary FROM employees WHERE salary >
(SELECT salary from employees where last_name='Abel');

--esto devuelve error porque la subconsulta devuelve m�s de una fila
SELECT last_name, salary FROM employees WHERE salary >
(SELECT salary from employees where department_id=20);

/*OPERADORES SINGLE ROW
=,>,<,<=,>=,!=
*/
--YOU CAN USE GROUP FUNCTIONS IN A SUBQUERY
SELECT last_name, salary FROM employees WHERE salary >
(SELECT MIN(salary) from employees);

--RECORDAR NO USAR WHERE CON GROUP FUNCTIONS
SELECT last_name, salary FROM employees 
GROUP BY last_name,salary 
HAVING min(salary) = (SELECT MIN(salary) from employees);

--MULTIPLE ROW SUBQUERY (IN) (ANY)

SELECT last_name, salary FROM employees 
GROUP BY last_name,salary 
HAVING min(salary) IN (SELECT MIN(salary) from employees GROUP BY department_id);

SELECT last_name, salary FROM employees 
GROUP BY last_name,salary 
HAVING min(salary) = ANY (SELECT MIN(salary) from employees GROUP BY department_id);

SELECT last_name, salary FROM employees 
GROUP BY last_name,salary 
HAVING min(salary) > ALL (SELECT MIN(salary) from employees GROUP BY department_id);

------- MULTIPLE COLUMN SUBQUERIES
--(display  all the employees  with the lowest salary in each department
SELECT first_name, department_id,salary 
FROM employees
WHERE (salary, department_id) IN 
(SELECT  MIN(salary),  department_id
    FROM employees
    GROUP BY department_id)
ORDER BY department_id;

--KEEP IN MIND ISSUES WITH NULL VALUES IN SUBQUERIES

---------------
---PRACTICE 8-1
---------------
--1
undefine name
SELECT last_name, hire_date
FROM employees
WHERE department_id =
(SELECT department_id 
FROM employees
WHERE last_name='&&name')
AND last_name!='&name';

--2

SELECT
    employee_id,
    last_name,
    salary
FROM
    employees
WHERE salary>(
SELECT AVG(salary) FROM employees)
ORDER BY salary ASC;

--3
SELECT
    employee_id,
    last_name
FROM
    employees
WHERE DEPARTMENT_ID IN (
SELECT DISTINCT DEPARTMENT_ID FROM employees
WHERE last_name LIKE '%u%');

--4

SELECT
    last_name,
    department_id,
    job_id
FROM
    employees
WHERE department_id IN( 
SELECT
    department_id
FROM
    departments
WHERE location_id =1700);

--5
SELECT
    last_name,
    salary
FROM
    employees
WHERE MANAGER_ID IN
(SELECT EMPLOYEE_ID FROM employees WHERE LAST_NAME='King')
and LAST_NAME!='King';

--6
SELECT
    department_id,
    last_name,
    job_id
FROM
    employees
WHERE department_id=(
SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME='Executive');

--7

SELECT
    last_name
FROM
    employees
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID=60 );

--8

SELECT
    employee_id,
    last_name,
    salary
FROM
    employees
WHERE DEPARTMENT_ID IN (
SELECT DISTINCT DEPARTMENT_ID FROM employees
WHERE last_name LIKE '%u%')
and salary > (select avg(salary) from employees);

--------------------------------------------------------------------------------
----- 9 : Using Set Operators                                     --------------
--------------------------------------------------------------------------------

/*SET OPERATOR RULES
EXPRESSION IN SELECT MUST MATCH IN NUMBER
DATA TYPE OF EACH COLUMN MUST MATCH
PARENTHESES  CAN BUE USED  TO ALTER  THE SEQUENCE OF EXECUTION
ORDERBY CLAUSE CAN APPEAR ONLY AT THE VERY END OF THE STATEMENT */


