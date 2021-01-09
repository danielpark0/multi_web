/**********************************************************
*	SQL Query & Function Example1
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

--�μ���ȣ�� 10���� �μ��� ��� �� �����ȣ, �̸�, ������ ����϶�

select employee_id, first_name, salary from employees where department_id = 10;


--�����ȣ�� 7369�� ��� �� �̸�, �Ի���, �μ� ��ȣ�� ����϶�.

select first_name, hire_date, department_id from employees where employee_id = 7369;


--�̸��� Ellen�� ����� ��� ������ ����϶�.


select * from employees where first_name = 'Ellen';


--�Ի����� 08/04/21�� ����� �̸�, �μ���ȣ, ������ ����϶�.

select first_name, department_id, salary from employees where hire_date = to_date('21-APR-08');


--������ SA_MAN �ƴ� ����� ��� ������ ����϶�.

select * from employees where job_id != 'SA_MAN';


--�Ի����� 08/04/21 ���Ŀ� �Ի��� ����� ������ ����϶�.

select * from employees where hire_date > to_date('21-APR-08');


--�μ���ȣ�� 20,30���� ������ ��� ����� �̸�, �����ȣ, �μ���ȣ�� ����϶�.

select first_name, employee_id, department_id from employees where department_id != 20 and department_id != 30;


--�̸��� S�� �����ϴ� ����� �����ȣ, �̸�, �Ի���, �μ���ȣ�� ����϶�.

select employee_id, first_name, hire_date, department_id from employees where first_name like 'S%';


--�̸��� s�� �����ϰ� ������ ���ڰ� t�� ����� ������ ����϶�.

select employee_id, first_name, hire_date, department_id from employees where first_name like 'S%t';


/**
employees ���̺��� �̸�, �޿�, ��, �Ѿ��� ���Ͽ� �Ѿ� ���� ������ ����϶� �� �󿩱��� NULL�� ����� ����

*/

select first_name, salary, (salary*commission_pct) as bonus, (salary+salary*commission_pct) as total from employees;


/**
10�� �μ��� ��� ����鿡�� �޿��� 13%�� ���ʽ��� �����ϱ�� �Ͽ���. �̸�, �޿�, ���ʽ��ݾ�, �μ���ȣ�� ����϶�.
**/

select first_name, salary, (salary*0.13) bonus, department_id from employees;


/**
30�� �μ��� ������ ����Ͽ� �̸�, �μ���ȣ, �޿�, ������ ����϶�. �� ������ �޿��� 150%�� ���ʽ��� �����Ѵ�.
   -- ���� = sal*12+(sal*1.5)
**/

select first_name, department_id, salary, (salary*12+salary*1.5) annual from employees where department_id = 30;


/**
�μ���ȣ�� 20�� �μ��� �ð��� �ӱ��� ����Ͽ� ����϶�. �� 1���� �ٹ��ϼ��� 12���̰� 1�� �ٹ��ð��� 5�ð��̴�.
��¾���� �̸�, �޿�, �ð��� �ӱ�(�Ҽ����� 1��° �ڸ����� �ݿø�)�� ����϶�.
   -- �ñ� = sal/�ϼ�/�ð�  -> sal/ 12/5 
   -- round(m, n) m�� �Ҽ��� n�ڸ����� �ݿø� 
**/

select first_name, salary, round(salary/12/5) sph from employees where department_id = 20;


/**
�޿��� 1500���� 3000������ ����� �޿��� 5%�� ȸ��� �����ϱ�� �Ͽ���. �̸� �̸�, �޿�, ȸ��(-2�ڸ����� �ݿø�)�� ����϶�.
	-- ȸ��  = sal * 0.05	
	-- -2�ڸ����� �ݿø� : ���� 2��° �ڸ����� �ݿø�.. 100������  
**/

select first_name, salary, round((salary*0.05),-2) dues from employees where salary between 1500 and 3000;


/**
�Ի��Ϻ��� ���ݱ����� ��¥���� ����϶�. �μ���ȣ, �̸�, �Ի���, ������, �ٹ��ϼ�(�Ҽ�����������), �ٹ����,
 �ٹ�����(30�� ����)�� ����϶�.
	-- ���� ��¥ : sysdate 
	-- �ٹ� �ϼ� : ���糯¥ - �Ի��� = sysdate - hire_date  -> ��¥ - ��¥ : �ϼ� ����
	-- �ٹ� ��� : to_char(sysdate,'YYYY')-to_char(hiredate,'YYYY')
	-- �ٹ� ���� : �ٹ��ϼ� / 1��(30��)
**/

select department_id, first_name, hire_date, sysdate, 
round(sysdate-hire_date) workingday, 
to_char(sysdate,'yyyy')-to_char(hire_date,'yyyy') workingyear, 
round((sysdate-hire_date)/30) workingmonth
from employees;


/**
�Ի��Ϸκ��� ���ñ����� �ϼ��� ���Ͽ� �̸�, �Ի���, �ٹ��ϼ��� ����϶�.
--round(sysdate-hiredate,0) �ٹ��ϼ�
**/

select first_name, hire_date, round(sysdate - hire_date) workingday from employees;


/**
�Ի����� 2012�� 7�� 5���� ���·� �̸�, �Ի����� ����϶�.
	-- ��¥ ���� �տ� fm �� ���� '0'�� ǥ������ �ʴ´ٴ� ��.. 
	-- 'fmYYYY"��" MM"��" DD"��' 
**/

select first_name, to_char(hire_date,'fmyyyy"��"mm"��"dd"��"') from employees;


/**
�̸�(first_name)�� ���ڼ��� 6���̻��� ����� �̸��� �տ��� 3�ڸ� ���Ͽ� �ҹ��ڷ� �̸����� ����϶�.
	-- substr(str, position, length) : str ���ڸ� positin ���� length���� ��ŭ ǥ��
	-- lower(str)  �ҹ��� ��ȯ
	-- length(str)  str�� ����
**/

select lower(substr(first_name,0,3)) from employees where length(first_name)>=6;


/**
10�� �μ� ������ ��դ� �ְ�, ����, �ο����� ���Ͽ� ����϶�
**/

select avg(salary), max(salary), min(salary), count(*) from employees group by department_id;


/**
�� �μ��� �޿��� ���, �ְ�, ����, �ο����� ���Ͽ� ����϶�.
**/

select avg(salary), max(salary), min(salary), count(*) from employees group by department_id;


/**
�� �μ��� ���� ������ �ϴ� ����� �ο����� ���Ͽ� �μ���ȣ, ������, �ο����� ����϶�.
**/

select department_id, job_id, count(*)
from employees
group by department_id, job_id
order by department_id, job_id;


/**
���� ������ �ϴ� ����� ���� 4�� �̻��� ������ �ο����� ����϶�.
**/

select job_id, count(*) cnt
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

