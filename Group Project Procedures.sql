/*
This Procedure Takes in nothing and returns a quary with AllTeams
*/
-----------------------------------------------------------
--DROP PROCEDURE League.AllTeams
CREATE PROCEDURE League.AllTeams
AS

SELECT T.TeamName, C.FirstName AS CoachFirstName, C.LastName AS CoachLastName, COUNT(P.PlayerID) AS PlayerCount, T.Mascot
FROM League.Team T
	INNER JOIN League.Coaches C ON C.CoachID = T.CoachID
	INNER JOIN League.Player P ON P.TeamID = T.TeamID
GROUP BY T.TeamName, C.FirstName, C.LastName, T.Mascot
GO
--EXEC League.AllTeams
-----------------------------------------------------------


/*
This Procedure Takes in a Team name as @UserInput and returns a quary with a roster of players for that team and all their pertinant information.
*/
-----------------------------------------------------------
--DROP PROCEDURE League.TeamRoster
CREATE PROCEDURE League.TeamRoster
	@TeamName Nvarchar(32)
AS

SELECT T.TeamName, P.FirstName, P.LastName, P.position, ISNULL(P.Number, 0) AS Number, P.Height
FROM League.Team T
	INNER JOIN League.Player P ON P.TeamID = T.TeamID
WHERE T.TeamName = @TeamName
Go
--EXEC League.TeamRoster
-----------------------------------------------------------



/*
This Procedure Takes in a Team name as @UserInput and returns a quary with all pertinent information of the searched team name.
*/
-----------------------------------------------------------
--DROP PROCEDURE League.SearchedTeam
CREATE PROCEDURE League.SearchedTeam
	@TeamName NVARCHAR(32)
AS

SELECT T.TeamName, T.Mascot, C.FirstName AS CoachFirstName, C.LastName AS CoachLastName, COUNT(P.PlayerID) AS PlayerCount
FROM League.Team T	
	INNER JOIN League.Coaches C ON C.CoachID = T.CoachID
	INNER JOIN League.Player P ON P.TeamID = T.TeamID
WHERE T.TeamName = @TeamName
GROUP BY T.TeamName, C.FirstName, C.LastName, T.Mascot

Go
--EXEC League.SearchedTeam
-----------------------------------------------------------



/*
This Procedure Takes in nothing and returns a quary with All Coaches and their pertinent information.
*/
-----------------------------------------------------------
--DROP PROCEDURE League.AllCoaches
CREATE PROCEDURE League.AllCoaches
AS

SELECT C.FirstName, C.LastName, T.TeamName, C.StartYear, C.DateOfBirth, COUNT(P.PlayerID) AS PlayerCount
FROM League.Coaches C
	INNER JOIN League.Team T ON T.CoachID = C.CoachID
	INNER JOIN League.Player P ON P.TeamID = T.TeamID
WHERE C.StartYear IS NOT NULL
GROUP BY C.FirstName, C.LastName, T.TeamName, C.StartYear, C.DateOfBirth
ORDER BY T.TeamName ASC
GO
EXEC League.AllCoaches
------------------------------------------------------------



/*
 This Procedure Takes in a Coach's last name as @UserInput and returns a quary with all pertinent information of the searched coach.
*/
-----------------------------------------------------------------
--DROP PROCEDURE League.SearchedCoach
CREATE PROCEDURE League.SearchedCoach
	@UserInput NVARCHAR(32)
AS

SELECT C.FirstName, C.LastName, T.TeamName, C.StartYear, C.DateOfBirth, COUNT(P.PlayerID) AS PlayerCount
FROM League.Coaches C
	INNER JOIN League.Team T ON T.CoachID = C.CoachID
	INNER JOIN League.Player P ON P.TeamID = T.TeamID
WHERE C.StartYear IS NOT NULL AND
	 C.LastName = @UserInput
GROUP BY C.FirstName, C.LastName, T.TeamName, C.StartYear, C.DateOfBirth
ORDER BY T.TeamName ASC
GO
--EXEC League.SearchedCoach
-----------------------------------------------------------------




/*
This Procedure Takes in nothing and returns a quary with AllGames and their pertinent information.
*/
-----------------------------------------------------------
CREATE PROCEDURE League.AllGames
AS

SELECT 
	(
		SELECT T.TeamName
		FROM League.Team T
		WHERE T.TeamID = G.HomeTeamID
	) AS HomeTeam,
	(
		SELECT T.TeamName
		FROM League.Team T
		WHERE T.TeamID = G.AwayTeamID
	) AS AwayTeam, 
	(
		SELECT T.TeamName
		FROM League.Team T
		WHERE T.TeamID = G.WinnerID
	) AS WinningTeam, G.Date, G.StartTime, G.[Home Score], G.[Away Score], A.Venue, G.Attendence 
	
FROM League.Game G
	INNER JOIN League.Arena A ON A.ArenaID = G.ArenaID
ORDER BY G.GameID DESC
Go
--EXEC League.AllGames
-----------------------------------------------------------

 

 /*
 This Procedure Takes in a team name as @UserInput and returns a quary of games that the team played in and their pertinent information.
*/
----------------------------------------------------------------
--DROP PROCEDURE League.GamesByTeam
CREATE PROCEDURE League.GamesByTeam
	@UserInput NVARCHAR(32)
AS

DECLARE @TeamNameIdentifier INT =
	(
		SELECT T.TeamID
		FROM League.Team T
		WHERE T.TeamName = @UserInput
	);
SELECT 
	(
		SELECT T.TeamName
		FROM League.Team T
		WHERE T.TeamID = G.HomeTeamID
	) AS HomeTeam,
	(
		SELECT T.TeamName
		FROM League.Team T
		WHERE T.TeamID = G.AwayTeamID
	) AS AwayTeam, 
	(
		SELECT T.TeamName
		FROM League.Team T
		WHERE T.TeamID = G.WinnerID
	) AS WinningTeam,
	 G.Date, G.StartTime, G.[Home Score], G.[Away Score],A.Venue, G.Attendence
FROM League.Game G
	INNER JOIN League.Arena A ON A.ArenaID = G.ArenaID
WHERE G.HomeTeamID = @TeamNameIdentifier OR G.AwayTeamID = @TeamNameIdentifier
ORDER BY G.GameID DESC
Go
--EXEC League.GamesByArena
----------------------------------------------------------------




/*
This Procedure Takes in a Venue name as @UserInput and returns a quary of games at the searched Arena and its pertinent information.
*/
----------------------------------------------------------------
DROP PROCEDURE League.GamesByArena
CREATE PROCEDURE League.GamesByArena
	@UserInput NVARCHAR(32)
AS

DECLARE @ArenaNameIdentifier INT =
	(
		SELECT A.ArenaID
		FROM League.Arena A
		WHERE A.Venue = @UserInput
	);
SELECT 
	(
		SELECT T.TeamName
		FROM League.Team T
		WHERE T.TeamID = G.HomeTeamID
	) AS HomeTeam,
	(
		SELECT T.TeamName
		FROM League.Team T
		WHERE T.TeamID = G.AwayTeamID
	) AS AwayTeam, G.Date, G.StartTime, G.[Home Score], G.[Away Score], A.Venue,G.Attendence
FROM League.Game G
	INNER JOIN League.Arena A ON A.ArenaID = G.ArenaID
WHERE G.ArenaID = @ArenaNameIdentifier
ORDER BY G.GameID DESC
Go
--EXEC League.GamesByArena
-------------------------------------------------------------------




------------------------------------------------------------------
/*
This Procedure Takes in a Venue name as @ArenaName and team name as @TeamName and returns a quary of games by the searched Arena and team and their pertinent information.
*/
----------------------------------------------------------------
DROP PROCEDURE League.GamesByBoth
CREATE PROCEDURE League.GamesByBoth
	@ArenaName NVARCHAR(32),
	@TeamName NVARCHAR(32)
AS
DECLARE @TeamNameIdentifier INT =
	(
		SELECT T.TeamID
		FROM League.Team T
		WHERE T.TeamName = @TeamName
	);
DECLARE @ArenaNameIdentifier INT =
	(
		SELECT A.ArenaID
		FROM League.Arena A
		WHERE A.Venue = @ArenaName
	);
SELECT 
	(
		SELECT T.TeamName
		FROM League.Team T
		WHERE T.TeamID = G.HomeTeamID
	) AS HomeTeam,
	(
		SELECT T.TeamName
		FROM League.Team T
		WHERE T.TeamID = G.AwayTeamID
	) AS AwayTeam, G.Date, G.StartTime, G.[Home Score], G.[Away Score], A.Venue,G.Attendence
FROM League.Game G
	INNER JOIN League.Arena A ON A.ArenaID = G.ArenaID
WHERE G.ArenaID = @ArenaNameIdentifier  and (G.HomeTeamID = @TeamNameIdentifier OR G.AwayTeamID = @TeamNameIdentifier)
ORDER BY G.GameID DESC
Go
----------------------------------------------------------------




/*
This Procedure Takes in nothing and returns a quary with AllArenas
*/
----------------------------------------------------------------
--DROP PROCEDURE League.AllArenas
CREATE PROCEDURE League.AllArenas
AS
SELECT A.Venue, A.Name AS Team, A.City, A.State, COUNT(G.GameId) AS GameCount, MAX(G.Attendence) AS Capacity --assuming each the max attendance for a game = capacity 
FROM League.Arena A
	INNER JOIN League.Game G ON G.ArenaID = A.ArenaID
GROUP BY A.Venue, A.Name, A.City, A.State
ORDER BY A.Venue ASC
Go
----------------------------------------------------------------




/*
This Procedure Takes in a Venue name as @UserInput and returns a quary of the searched Arena and its pertinent information.
*/
----------------------------------------------------------------
--DROP PROCEDURE League.SearchedArena
CREATE PROCEDURE League.SearchedArena
	 @UserInput NVARCHAR(32)
AS

SELECT A.Venue, A.Name AS Team, A.City, A.State, COUNT(G.GameId) AS GameCount, MAX(G.Attendence) AS Capacity
FROM League.Arena A
	INNER JOIN League.Game G ON G.ArenaID = A.ArenaID
WHERE A.Venue = @UserInput
GROUP BY A.Venue, A.Name, A.City, A.State
Go
--EXEC League.SearchedArena
----------------------------------------------------------------




/*
This Procedure Takes in nothing and returns a quary with AllPlayers
*/
----------------------------------------------------------------
DROP PROCEDURE League.AllPlayer
CREATE PROCEDURE League.AllPlayer
AS

	Select P.FirstName, P.LastName,
	(
		Select T.TeamName
		From League.Team T
 		Where T.TeamID = P.TeamID
	) AS TeamName,  P.age AS Age, P.position AS Position, P.Height, PSG.Points AS PointsPerGame, PSG.TotalReboundPGame AS ReboundsPerGame,
			 PSG.Assists AS AssistsPerGame, PSG.FreeThrowPercentage, PST.GamesPlayed
	From League.Player P
		INNER JOIN League.PlayerStatPerGame PSG ON PSG.PlayerID = P.PlayerID
		INNER JOIN League.PlayerStatSeasonTotal PST ON PST.PlayerID = P.PlayerID
ORDER BY TeamName ASC
GO



--EXEC League.AllPlayer
----------------------------------------------------------------


/*
This Procedure Takes in A players full name and returns a quary with Firstname, Last name, Team name, age, position, height, points per game, assist per game, Freethrowpercent
*/
----------------------------------------------------------------
--DROP PROCEDURE League.SearchedPlayer
CREATE PROCEDURE League.SearchedPlayer
	@PlayerName Nvarchar(32)
AS
	Select P.FirstName, P.LastName,
	(
		Select T.TeamName
		From League.Team T
 		Where T.TeamID = P.TeamID
	) AS TeamName,  P.age AS Age, P.position AS Position, P.Height, PSG.Points AS PointsPerGame, PSG.TotalReboundPGame AS ReboundsPerGame,
			 PSG.Assists AS AssistsPerGame, PSG.FreeThrowPercentage, PST.GamesPlayed
	From League.Player P
		INNER JOIN League.PlayerStatPerGame PSG ON PSG.PlayerID = P.PlayerID
		INNER JOIN League.PlayerStatSeasonTotal PST ON PST.PlayerID = P.PlayerID
	WHERE (concat(P.FirstName, P.LastName) = @PlayerName or concat(p.FIrstName, ' ', p.lastname) = @PlayerName) AND P.TeamID != 4
Go

--EXEC League.SearchedPLayer @PlayerFName = N'Lebron', @PlayerLName = N'James' --@PlayerFName = INPUTARGS, @PlayerLName = INPUTARGS 
----------------------------------------------------------------------------------------

select * from League.Player
Where firstname = 'Bill'
/*
This Procedure Takes all needed information of a new player and enters the information in to the database Players
*/
----------------------------------------------------------------------------------------
--DROP PROCEDURE League.AddPlayer 
CREATE PROCEDURE League.AddPlayer
	@FirstName NVARCHAR(64),
	@LastName NVARCHAR(64),
	@TeamName NVARCHAR(64),
	@height NVARCHAR(64),
	@PlayerNumber INT,
	@PlayerPosition  NVARCHAR(64),
	@PlayerAge INT
AS
INSERT League.Player 
Values
	((
		SELECT T.TeamID
		FROM League.Team T
		WHERE T.TeamName = @TeamName
	),@FirstName, @LastName, @height, @PlayerNumber, @PlayerPosition, @PlayerAge)

insert into League.PlayerStatPerGame
Values(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,(Select P.PlayerID
		from League.Player P 
		where FirstName = @FirstName and LastName = @LastName))

insert into League.PlayerStatSeasonTotal
Values(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,(Select P.PlayerID
		from League.Player P 
		where FirstName = @FirstName and LastName = @LastName))
GO
-----------------------------------------------------------------------------------

/*
This Procedure Takes in All necassary data to make a Game and adds it to the Game database a quary with AllTeams
*/
-----------------------------------------------------------------------------------
--DROP PROCEDURE League.AddGame
CREATE PROCEDURE League.AddGame
	@HomeTeam NVARCHAR(64),
	@AwayTeam NVARCHAR(64),
	@Arena NVARCHAR(64),
	@HomeScore INT,
	@AwayScore INT,
	@WinningTeam  NVARCHAR(64),
	@Attendance INT,
	@Date NVARCHAR(64),
	@StartTime NVARCHAR(64)
AS
INSERT League.Game 
Values
	(
		(
			SELECT T.TeamID
			FROM League.Team T
			WHERE T.TeamName = @HomeTeam
		),
		(
			SELECT T.TeamID
			FROM League.Team T
			WHERE T.TeamName = @AwayTeam
		), 
		(
			SELECT A.ArenaID
			FROM League.Arena A
			WHERE A.Venue = @Arena
		),
		@HomeScore,
		@AwayScore,
		(
		SELECT T.TeamID
		FROM League.Team T
		WHERE T.TeamName = @WinningTeam
		), @Attendance, @Date, @StartTime)
	
Go

