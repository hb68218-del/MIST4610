USE cs_hb68218;

select * from games;
select * from game_has_referee;
select * from game_has_teams; 
select * from games;
select * from player_stats;
select * from players;
select * from referee; 
select * from games;
select * from season;
select * from stadium;
select * from team;
select * from team_matchup;
select * from team_season_performance;


#1 Show all referees with more than 10 years of experience.
SELECT refereename, experience, role
FROM Referee
WHERE experience > 10;

#2 Count the total number of referees by their role.
SELECT role, COUNT(*) AS NumReferees
FROM referee
GROUP BY role;

#3 Show the points allowed by each team starting with the team with the most points allowed.
SELECT teamid, pointsallowed
FROM team_season_performance
ORDER BY pointsallowed DESC;

#4 Show the teams and their win-loss ratio and put it in descending order.
SELECT teamid, wins, losses, (wins * 1.0) / losses AS WinLossRatio
FROM team_season_performance
ORDER BY WinLossRatio DESC;

#5 Group referees into their respective experience levels (Beginner, Intermediate, Advanced, Veteran).
SELECT CASE
         WHEN experience BETWEEN 0 AND 3 THEN 'Beginner (0–3 yrs)'
         WHEN experience BETWEEN 4 AND 7 THEN 'Intermediate (4–7 yrs)'
         WHEN experience BETWEEN 8 AND 12 THEN 'Advanced (8–12 yrs)'
         ELSE 'Veteran (13+ yrs)'
       END AS ExperienceLevel,
       COUNT(*) AS NumReferees
FROM referee
GROUP BY ExperienceLevel
ORDER BY NumReferees DESC;

#6 Group each team by their win percentage ranges.
SELECT CASE
         WHEN (wins*1.0)/(wins+losses) BETWEEN 0 AND 0.25 THEN 'Low (0–25%)'
         WHEN (wins*1.0)/(wins+losses) BETWEEN 0.26 AND 0.5 THEN 'Moderate (26–50%)'
         WHEN (wins*1.0)/(wins+losses) BETWEEN 0.51 AND 0.75 THEN 'High (51–75%)'
         ELSE 'Excellent (76–100%)'
       END AS WinCategory,
       COUNT(*) AS NumTeams
FROM team_season_performance
GROUP BY WinCategory
ORDER BY NumTeams DESC;

#7 Show which teams gain the most yards per game.
SELECT T.teamname, COALESCE(AVG(GT.yardsgained), 0) AS AverageYards FROM team AS T LEFT JOIN game_has_teams AS GT ON T.idTeam = GT.Team_idTeam GROUP BY T.teamname ORDER BY AverageYards DESC;

#8 Which stadiums draw above the leagues average in attendance?
SELECT 
    S.stadiumname,
    S.city,
    S.state,
    AVG(G.attendance) AS average_attendance
FROM games AS G
JOIN stadium AS S 
    ON S.stadiumid = G.stadiumid
GROUP BY 
    S.stadiumname, 
    S.city, 
    S.state
HAVING 
    AVG(G.attendance) > (SELECT AVG(attendance) FROM games)
ORDER BY 
    average_attendance DESC;
    
#9 Which teams get more yards per game than the average yards per game by a given team?
SELECT 
    T.teamname,
    AVG(GT.yardsgained) AS yards_per_game
FROM 
    game_has_teams AS GT
JOIN 
    team AS T 
    ON T.idTeam = GT.Team_idTeam
GROUP BY 
    T.teamname
HAVING 
    AVG(GT.yardsgained) > (
        SELECT AVG(yardsgained) FROM game_has_teams
    )
ORDER BY 
    yards_per_game DESC;

#10 Which team(s) is/are undefeated at their home stadium?
SELECT 
    T.teamname,
    AVG(GT.yardsgained) AS yards_per_game
FROM 
    game_has_teams AS GT
JOIN 
    team AS T 
    ON T.idTeam = GT.Team_idTeam
GROUP BY 
    T.teamname
HAVING 
    AVG(GT.yardsgained) > (
        SELECT AVG(yardsgained) FROM game_has_teams
    )
ORDER BY 
    yards_per_game DESC;

