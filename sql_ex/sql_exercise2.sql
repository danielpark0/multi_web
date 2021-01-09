/**********************************************************
*	SQL Query & Function Example2
**********************************************************/
/**
-- Employees Table Columns
-- EMPLOYEE_ID
-- FIRST_NAME
-- LAST_NAME
-- EMAIL
-- PHONE_NUMBER
-- HIRE_DATE
-- JOB_ID
-- SALARY
-- COMMISSION_PCT
-- MANAGER_ID
-- DEPARTMENT_ID
**/

/**
--Departments Table Columns
--DEPARTMENT_ID
--DEPARTMENT_NAME
--MANAGER_ID
--LOCATION_ID
**/

/**
50�� �μ� ������ ��դ� �ְ�, ����, �ο����� ���Ͽ� ����϶�
**/

select avg(salary), max(salary), min(salary), count(*)
from employees
where department_id = 50;



/**
�� �μ��� �޿��� ���, �ְ�, ����, �ο����� ���Ͽ� ����϶�.
**/

select avg(salary), max(salary), min(salary), count(*)
from employees
group by department_id;




/**
�� �μ��� ���� ������ �ϴ� ����� �ο����� ���Ͽ� �μ���ȣ, ������, �ο����� ����϶�.
**/

select department_id, job_id, count(*)
from employees
group by department_id, job_id;



/**
���� ������ �ϴ� ����� ���� 4�� �̻��� ������ �ο����� ����϶�.
**/

select job_id, count(*)
from employees
group by job_id
having count(*) >= 4;



/**
�� �μ��� ��տ���, ��ü����, �ְ����, ��������,�� ���Ͽ� ��տ����� ���������� ����϶�.
**/

select avg(salary), sum(salary), max(salary), min(salary)
from employees
group by department_id
order by avg(salary) desc;



/**
 �μ���ȣ, �μ���, �̸�, �޿��� ����϶�.
**/

select e.department_id, d.department_name, e.first_name, e.salary
from employees e, departments d
where e.department_id = d.department_id;

/**
�̸��� adam�� ����� �μ����� ����϶�.
**/

select d.department_name
from employees e, departments d
where e.department_id = d.department_id and e.first_name = 'Adam';


/**
employees���̺� �ִ� employee_id�� manager_id�� �̿��Ͽ� ������ ���踦 ������ ���� ����϶�
'smith'�� �Ŵ����� 'ford'�̴�.
**/

select e.first_name ||' �� �Ŵ����� '|| m.first_name ||' �̴�.'
from employees e, employees m
where e.manager_id = m.employee_id(+);


/**
adam�� ������ ���� ������ ���� ����� �̸�, �μ���, �޿�, ������ ����϶�.
**/

select e.first_name, d.department_name, e.salary, e.job_id
from employees e, departments d
where e.department_id = d.department_id and e.job_id = (select job_id 
                                                        from employees
                                                        where first_name = 'Adam');


/**
��ü ����� ��� �ӱݺ��� ���� ����� �����ȣ, �̸�, �μ���, �Ի���, ����, �޿��� ����϶�.
**/

select e.employee_id, e.first_name, d.department_name, e.hire_date, d.location_id, e.salary
from departments d, employees e
where d.department_id = e.department_id and e.salary > (select avg(salary) from employees);


/**
50�� �μ������ �߿��� 30�� �μ��� ����� ���� ������ �ϴ� ����� �����ȣ, �̸�, �μ���, �Ի����� ����϶�.
**/

select e.employee_id, e.first_name, d.department_name, e.hire_date
from employees e, departments d
where e.department_id = d.department_id and e.job_id in (select job_id 
                                                         from employees 
                                                         where department_id = 30) and e.department_id = 50;


/**
�޿��� 30�� �μ��� �ְ� �޿����� ���� ����� �����ȣ, �̸�, �޿��� ����϶�.
**/

select employee_id, first_name, salary
from employees
where salary > (select max(salary)
                from employees
                where department_id = 30);
