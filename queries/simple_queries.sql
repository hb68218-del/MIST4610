-- SIMPLE QUERY 1
-- Show all referees with more than 10 years of experience
SELECT refereename, experience, role
FROM Referee
WHERE experience > 10;
-- Managerial Reasoning:
-- A manager may want to see which referees are veterans to assign them to high-stakes games like bowl or championship matches.


-- SIMPLE QUERY 2
-- Count the total number of referees by their role
SELECT role, COUNT(*) AS NumReferees
FROM Referee
GROUP BY role;
-- Managerial Reasoning:
-- Helps managers understand staffing balance across referee roles and identify hiring or promotion needs.


-- SIMPLE QUERY 3
-- Show the points allowed by each team starting with the team with the most points allowed
SELECT Team_idTeam, pointsallowed
FROM Team_Season_Performance
ORDER BY pointsallowed DESC;
-- Managerial Reasoning:
-- Helps managers identify weak defensive teams that may need new strategies, additional training, or staff adjustments.


-- SIMPLE QUERY 4
-- Show each team and their win-loss ratio (descending order)
SELECT Team_idTeam, wins, losses, (wins * 1.0 / losses) AS win_loss_ratio
FROM Team_Season_Performance
ORDER BY win_loss_ratio DESC;
-- Managerial Reasoning:
-- Helps managers rank teams by efficiency and performance success for future scheduling and recognition.
