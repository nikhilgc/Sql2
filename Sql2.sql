#Rank scores

SELECT s.score, DENSE_RANK() OVER (order by s.score DESC) as 'rank'
FROM SCORES s

#Exchange Seats

SELECT (CASE WHEN MOD(id,2)!=0 AND id = cnts THEN id
             WHEN MOD(id,2)!=0 AND id != cnts then id+1
             ELSE id-1 END) AS id, student
FROM Seat, (Select Count(*) AS cnts from Seat) AS SEAT_COUNT
ORDER BY id ASC;

#Tree Node

SELECT id, (
    CASE WHEN p_id IS NULL THEN 'Root'
         WHEN id NOT IN(Select DISTINCT p_id from Tree where p_id IS NOT NULL) THEN 'Leaf'
         ELSE 'Inner'
    END        
) as 'type' 
from tree;

#Department Top 3 Salaries

WITH CTE AS (SELECT e.*, DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS 'rank' FROM Employee e)

SELECT d.name AS Department, c.name as Employee, c.salary as Salary FROM CTE c
LEFT JOIN Department d on d.id = c.departmentid WHERE c.rank <=3
