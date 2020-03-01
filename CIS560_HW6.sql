--CREATE SCHEMA Clubs;



DROP Table IF Exists Clubs.MeetingAttendee;
DROP Table IF Exists Clubs.Attendee;
DROP Table IF Exists Clubs.Meeting;
DROP Table IF Exists Clubs.Club;

--Club Table
CREATE TABLE Clubs.Club
(
   ClubId INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
   [Name] NVARCHAR(64) NOT NULL,
   Purpose NVARCHAR(1024) NOT NULL,
   CreatedOn DATETIMEOFFSET NOT NULL DEFAULT(SYSDATETIMEOFFSET()),
   UpdatedOn DATETIMEOFFSET NOT NULL DEFAULT(SYSDATETIMEOFFSET()),
   

   UNIQUE
   (
      [Name] ASC
   )
);



--Meeting Table
CREATE TABLE Clubs.Meeting
(
   MeetingId INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
   ClubId INT NOT NULL FOREIGN KEY REFERENCES Clubs.Club(ClubId),
   MeetingTime DATETIME2(0) NOT NULL,
   [Location] NVARCHAR(64) NOT NULL,
   CreatedOn DATETIMEOFFSET NOT NULL DEFAULT(SYSDATETIMEOFFSET()),
   UpdatedOn DATETIMEOFFSET NOT NULL DEFAULT(SYSDATETIMEOFFSET()),
   

   UNIQUE
   (
      ClubId ASC,
	  MeetingTime ASC
   )
);


--Attendee Table
CREATE TABLE Clubs.Attendee
(
   AttendeeId INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
   Email NVARCHAR(128) NOT NULL,
   FirstName NVARCHAR(32) NOT NULL,
   LastName NVARCHAR(32) NOT NULL,
   CreatedOn DATETIMEOFFSET NOT NULL DEFAULT(SYSDATETIMEOFFSET()),
   UpdatedOn DATETIMEOFFSET NOT NULL DEFAULT(SYSDATETIMEOFFSET()),
   

   UNIQUE
   (
      Email ASC
   )
);


--MeetingAttendee Table
CREATE TABLE Clubs.MeetingAttendee
(
   MeetingId INT NOT NULL FOREIGN KEY REFERENCES Clubs.Meeting(MeetingId),
   AttendeeId INT NOT NULL FOREIGN KEY REFERENCES Clubs.Attendee(AttendeeId),
   CreatedOn DATETIMEOFFSET NOT NULL DEFAULT(SYSDATETIMEOFFSET()),
);



--Q2
Insert Clubs.Club([Name], Purpose)
Values (N'ACM' , N'The Association for Computing Machinery is the professional organization for computer scientists.'),
(N'MIS Club', N'The Kansas State MIS Club is a student driven organization focused on the management of information systems.');


INSERT CLUBS.Meeting(ClubId, [Location], MeetingTime)
Values ((SELECT ClubID FROM Clubs.Club WHERE [Name] = N'ACM'), N'Engineering Building 1114	', CONVERT(datetime, 'Oct 9 18:30:0 2018')),
((SELECT ClubID FROM Clubs.Club WHERE [Name] = N'ACM'), N'Engineering Building 1114	', CONVERT(datetime, 'Nov 13 18:30:0 2018')),
((SELECT ClubID FROM Clubs.Club WHERE [Name] = N'MIS Club'), N'Business Building 2116	', CONVERT(datetime, 'Nov 6 18:00:0 2018')),
((SELECT ClubID FROM Clubs.Club WHERE [Name] = N'MIS Club'), N'Business Building 2116	', CONVERT(datetime, 'Dec 4 18:00:0 2018'));



--Q3

INSERT Clubs.Attendee(Email, FirstName, LastName)
Values (N'gbwood@ksu.edu', N'Graham', N'Wood');

Insert Clubs.MeetingAttendee(MeetingId, AttendeeId)
Values ((SELECT MeetingId FROM Clubs.Meeting WHERE MeetingTime = CONVERT(datetime,'Oct 9 18:30:0 2018')), (Select AttendeeID FROM Clubs.Attendee WHERE Email = N'gbwood@ksu.edu'));


--Q4
Update Clubs.Meeting
Set [Location] = N'Business Building 4001', UpdatedOn = SYSDATETIMEOFFSET() 
Where MeetingTime =  CONVERT(datetime, 'Dec 4 18:00:0 2018')
AND [Location] != N'Business Building 4001';

--Q5
WITH SourceCte(ClubId, MeetingTime, [Location]) AS
   (
      SELECT M.ClubId,M.MeetingTime, M.[Location]
      FROM
            (
               VALUES
                  ((SELECT ClubID FROM Clubs.Club WHERE [Name] = N'ACM'),CONVERT(datetime,'Nov 13 18:30:0 2018'), N'Engineering Building 1121' ),
                  ((SELECT ClubID FROM Clubs.Club WHERE [Name] = N'ACM'),CONVERT(datetime,'Feb 12 18:30:0 2019'), N'Engineering Building 1121' ),
				  ((SELECT ClubID FROM Clubs.Club WHERE [Name] = N'MIS Club'),CONVERT(datetime,'Dec 13 18:00:0 2018'), N'Business Building 4001' ),
				  ((SELECT ClubID FROM Clubs.Club WHERE [Name] = N'MIS Club'),CONVERT(datetime,'Feb 5 18:00:0 2019'), N'Business Building 4001' )
            ) NA(ClubID, MeetingTime, [Location])
         INNER JOIN CLubs.Meeting M ON M.ClubId = NA.ClubID
            
   )
MERGE Clubs.Meeting M
USING SourceCte S ON S.ClubId = M.ClubId
  
WHEN MATCHED THEN
   UPDATE
   SET
	  M.ClubId = S.ClubId,
      MeetingTime = S.MeetingTime,
	  [Location] = S.[Location],
      UpdatedOn = SYSDATETIMEOFFSET()
WHEN NOT MATCHED THEN
   INSERT(ClubId, MeetingTime, [Location])
   VALUES(S.ClubId, S.MeetingTime, S.[Location]);
GO