-- COMPLEX QUERY 1
-- Group referees into their respective experience levels
SELECT 
  CASE
    WHEN experience BETWEEN 0 AND 3 THEN 'Beginner (0–3 yrs)'
    WHEN experience BETWEEN 4 AND 7 THEN 'Intermediate (4–7 yrs)'
    WHEN experience BETWEEN 8 AND 12 THEN 'Advanced (8–12 yrs)'
    ELSE 'Veteran (13+ yrs)'
  END AS ExperienceLevel,
  COUNT(*) AS NumReferees
FROM Referee
GROUP BY ExperienceLevel
ORDER BY NumReferees DESC;
-- Managerial Reasoning:
-- Gives management an overview of workforce skill distribution for training or mentorship programs.


-- COMPLEX QUERY 2
-- Group each team by their win percentage range
SELECT 
  CASE
    WHEN (wins * 1.0) / (wins + losses) BETWEEN 0 AND 0.25 THEN 'Low (0–25%)'
    WHEN (wins * 1.0) / (wins + losses) BETWEEN 0.26 AND 0.5 THEN 'Moderate (26–50%)'
    WHEN (wins * 1.0) / (wins + losses) BETWEEN 0.51 AND 0.75 THEN 'High (51–75%)'
    ELSE 'Excellent (76–100%)'
  END AS WinCategory,
  COUNT(*) AS NumTeams
FROM Team_Season_Performance
GROUP BY WinCategory
ORDER BY NumTeams DESC;
-- Managerial Reasoning:
-- Useful to identify underperforming or exceptional teams for resource allocation and marketing strategies.


-- COMPLEX QUERY 3
-- Show which teams gain the most yards per game
SELECT t.teamname,
       AVG(ght.yardsgained) AS average_yards
FROM Game_has_Team ght
JOIN Team t ON t.idTeam = ght.Team_idTeam
GROUP BY t.teamname
ORDER BY average_yards DESC;
-- Managerial Reasoning:
-- Reveals which teams perform strongest offensively and where improvement is needed.


-- COMPLEX QUERY 4
-- Which stadiums draw above the league’s average attendance
SELECT s.stadiumname,
       s.city,
       s.state,
       AVG(g.attendance) AS average_attendance
FROM Game g
JOIN Stadium s ON s.idStadium = g.Stadium_idStadium
GROUP BY s.stadiumname, s.city, s.state
HAVING AVG(g.attendance) > (SELECT AVG(attendance) FROM Game)
ORDER BY average_attendance DESC;
-- Managerial Reasoning:
-- Shows high-demand venues to guide scheduling, marketing, and premium pricing strategies.


-- COMPLEX QUERY 5
-- Which teams average more yards per game than the league average
SELECT t.teamname,
       AVG(ght.yardsgained) AS yards_per_game
FROM Game_has_Team ght
JOIN Team t ON t.idTeam = ght.Team_idTeam
GROUP BY t.teamname
HAVING AVG(ght.yardsgained) > (SELECT AVG(yardsgained) FROM Game_has_Team)
ORDER BY yards_per_game DESC;
-- Managerial Reasoning:
-- Highlights teams performing above league averages for offensive metrics and playoff potential.


-- COMPLEX QUERY 6
-- Which teams are undefeated at their home stadium
SELECT t.teamname
FROM Team t
WHERE NOT EXISTS (
  SELECT *
  FROM Game g
  WHERE g.Stadium_idStadium = t.homestadiumID
    AND g.totalscoreHome < g.totalscoreAway
)
AND EXISTS (
  SELECT *
  FROM Game g
  WHERE g.Stadium_idStadium = t.homestadiumID
)
ORDER BY t.teamname;
-- Managerial Reasoning:
-- Identifies teams dominant at home games — valuable for promotions, ticket pricing, and broadcast scheduling.
