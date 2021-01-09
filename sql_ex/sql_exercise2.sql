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
50번 부서 월급의 평균ㅡ 최고, 최저, 인원수를 구하여 출력하라
**/

select avg(salary), max(salary), min(salary), count(*)
from employees
where department_id = 50;



/**
각 부서별 급여의 평균, 최고, 최저, 인원수를 구하여 출력하라.
**/

select avg(salary), max(salary), min(salary), count(*)
from employees
group by department_id;




/**
각 부서별 같은 업무를 하는 사람의 인원수를 구하여 부서번호, 업무명, 인원수를 출력하라.
**/

select department_id, job_id, count(*)
from employees
group by department_id, job_id;



/**
같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수를 출력하라.
**/

select job_id, count(*)
from employees
group by job_id
having count(*) >= 4;



/**
각 부서별 평균월급, 전체월급, 최고월급, 최저월급,을 구하여 평균월급이 많은순으로 출력하라.
**/

select avg(salary), sum(salary), max(salary), min(salary)
from employees
group by department_id
order by avg(salary) desc;



/**
 부서번호, 부서명, 이름, 급여를 출력하라.
**/

select e.department_id, d.department_name, e.first_name, e.salary
from employees e, departments d
where e.department_id = d.department_id;

/**
이름이 adam인 사원의 부서명을 출력하라.
**/

select d.department_name
from employees e, departments d
where e.department_id = d.department_id and e.first_name = 'Adam';


/**
employees테이블에 있는 employee_id와 manager_id를 이용하여 서로의 관계를 다음과 같이 출력하라
'smith'의 매니저는 'ford'이다.
**/

select e.first_name ||' 의 매니저는 '|| m.first_name ||' 이다.'
from employees e, employees m
where e.manager_id = m.employee_id(+);


/**
adam의 직무와 같은 직무를 갖는 사람의 이름, 부서명, 급여, 직무를 출력하라.
**/

select e.first_name, d.department_name, e.salary, e.job_id
from employees e, departments d
where e.department_id = d.department_id and e.job_id = (select job_id 
                                                        from employees
                                                        where first_name = 'Adam');


/**
전체 사원의 평균 임금보다 많은 사원의 사원번호, 이름, 부서명, 입사일, 지역, 급여를 출력하라.
**/

select e.employee_id, e.first_name, d.department_name, e.hire_date, d.location_id, e.salary
from departments d, employees e
where d.department_id = e.department_id and e.salary > (select avg(salary) from employees);


/**
50번 부서사람들 중에서 30번 부서의 사원과 같은 업무를 하는 사원의 사원번호, 이름, 부서명, 입사일을 출력하라.
**/

select e.employee_id, e.first_name, d.department_name, e.hire_date
from employees e, departments d
where e.department_id = d.department_id and e.job_id in (select job_id 
                                                         from employees 
                                                         where department_id = 30) and e.department_id = 50;


/**
급여가 30번 부서의 최고 급여보다 높은 사원의 사원번호, 이름, 급여를 출력하라.
**/

select employee_id, first_name, salary
from employees
where salary > (select max(salary)
                from employees
                where department_id = 30);
