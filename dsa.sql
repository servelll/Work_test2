SELECT Name, Active, Sum(Salary)
FROM work.employee INNER JOIN work.salary On work.employee.Id = work.salary.employee_Id
WHERE DATE_FORMAT(Datetime, '%Y %m') = '2011 04'
GROUP BY Name
ORDER BY Sum(Salary) DESC;

(SELECT Name, 0 FROM work.employee)


