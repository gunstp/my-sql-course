-- Build the English Premier League results table from the match record
    SELECT
    m.[Date]
    ,m.HomeTeam
    ,m.AwayTeam
    ,m.FTHG
    ,m.FTAG
    ,FTR
FROM
    FootballMatch m
    order by m.[Date] DESC;

-- Premier League Table: Team, Played, Won, Drawn, Lost, GF, GA, GD, Points
SELECT
    Team,
    COUNT(*) AS Played,
    SUM(Won) AS Won,
    SUM(Drawn) AS Drawn,
    SUM(Lost) AS Lost,
    SUM(GF) AS GF,
    SUM(GA) AS GA,
    SUM(GF) - SUM(GA) AS GD,
    SUM(Points) AS Points
FROM (
    SELECT
        HomeTeam AS Team,
        1 AS Played,
        CASE WHEN FTR = 'H' THEN 1 ELSE 0 END AS Won,
        CASE WHEN FTR = 'D' THEN 1 ELSE 0 END AS Drawn,
        CASE WHEN FTR = 'A' THEN 1 ELSE 0 END AS Lost,
        FTHG AS GF,
        FTAG AS GA,
        CASE WHEN FTR = 'H' THEN 3 WHEN FTR = 'D' THEN 1 ELSE 0 END AS Points
    FROM FootballMatch
    UNION ALL
    SELECT
        AwayTeam AS Team,
        1 AS Played,
        CASE WHEN FTR = 'A' THEN 1 ELSE 0 END AS Won,
        CASE WHEN FTR = 'D' THEN 1 ELSE 0 END AS Drawn,
        CASE WHEN FTR = 'H' THEN 1 ELSE 0 END AS Lost,
        FTAG AS GF,
        FTHG AS GA,
        CASE WHEN FTR = 'A' THEN 3 WHEN FTR = 'D' THEN 1 ELSE 0 END AS Points
    FROM FootballMatch
) AS Results
GROUP BY Team
ORDER BY Points DESC, GD DESC, GF DESC;

---
DROP TABLE IF EXISTS #EPL_Results;
SELECT      
    m.HomeTeam  as Team
    ,m.FTHG AS GoalsFor
    ,m.FTAG  AS GoalsAgainst
--    ,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' WHEN 'A' THEN 'L' END As Result
    --,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' ELSE 'L' END As Result
    ,CASE when m.FTHG > m.FTAG then 'W' when M.FTHG = M.FTAG then 'D' else 'L' end as Result
INTO #EPL_Results
FROM
    FootballMatch m

union ALL
    -- results from AWAY team perspective
SELECT      
    m.AwayTeam  as Team
    ,m.FTAG AS GoalsFor
    ,m.FTHG  AS GoalsAgainst
--    ,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' WHEN 'A' THEN 'L' END As Result
    --,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' ELSE 'L' END As Result
    ,CASE when m.FTAG > m.FTHG then 'W' when M.FTAG = M.FTHG then 'D' else 'L' end as Result
FROM
    FootballMatch m

Select* FROM #EPL_Results

SELECT 
    r.Team
    ,COUNT (*) AS Played
   , SUM(r.GoalsFor) AS GoalsFor
   , SUM(r.GoalsAgainst) AS GoalsAgainst
   , SUM(r.GoalsFor) - SUM(r.GoalsAgainst) AS GD
   ,SUM(CASE WHEN r.result = 'W' THEN 1 ELSE 0 END) AS Won
    ,SUM(CASE WHEN r.result = 'D' THEN 1 ELSE 0 END) AS Drawn
    ,SUM(CASE WHEN r.result = 'L' THEN 1 ELSE 0 END) AS Lost
    ,sum (Case r.result WHEN 'W' THEN 3 WHEN 'D' THEN 1 ELSE 0 END) as Points
  
   FROM #EPL_Results r
   Group by r.Team
   Order By r.team;        

SELECT
    r.Team
    , COUNT(*) as Played
    , sum(r.GoalsFor) as GoalsFor
    , sum(r.GoalsAgainst) as GoalsAgainst
    , sum(r.GoalsFor) - sum(r.GoalsAgainst) as GD
    , sum(CASE WHEN r.Result = 'W' THEN 1 ELSE 0 END) aS Won
    , sum(CASE WHEN r.Result = 'D' THEN 1 ELSE 0 END) aS Drawn
    , sum(CASE WHEN r.Result = 'L' THEN 1 ELSE 0 END) aS Lost
    , SUM(CASE r.Result WHEN 'W' THEN 3 WHEN 'D' THEN 1 ELSE 0 END ) as Points
from #EPLResults r
GROUP BY r.Team
ORDER BY r.Team;
 
 
   
 


        
