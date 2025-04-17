create database FantasyFootball

use FantasyFootball

-- Drop tables if they already exits
DROP TABLE IF EXISTS UserPoints;
DROP TABLE IF EXISTS TeamPlayers;
DROP TABLE IF EXISTS Teams;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Performance;


-- Stores user accounts

CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) UNIQUE NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL,
    role NVARCHAR(10) DEFAULT 'user' CHECK (role IN ('user', 'admin')),
    createdAt DATETIME DEFAULT GETDATE()
);

-- Stores football players and stats
CREATE TABLE Players (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    position NVARCHAR(20) CHECK (position IN ('Forward', 'Midfielder', 'Defender', 'Goalkeeper')),
    club NVARCHAR(100),
    goals INT DEFAULT 0,
    assists INT DEFAULT 0,
    yellowCards INT DEFAULT 0,
    redCards INT DEFAULT 0,
    cleanSheets INT DEFAULT 0,
    price DECIMAL(10,2) NOT NULL
);

-- Stores user-created teams
CREATE TABLE Teams (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    teamName NVARCHAR(50) NOT NULL,
    budgetRemaining DECIMAL(10,2) NOT NULL DEFAULT 1000.00, -- Initial budget
    FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE
);
ALTER TABLE Teams ADD isComplete BIT DEFAULT 0

-- Tracks players assigned to teams
CREATE TABLE TeamPlayers (
    teamId INT NOT NULL,
    playerId INT NOT NULL,
    pointMultiplier DECIMAL(2,1) DEFAULT 1 NOT NULL CHECK(pointMultiplier in (0.5 , 1 , 2  , 4)),
	isBenched bit not null ,
    PRIMARY KEY (teamId, playerId),
    FOREIGN KEY (teamId) REFERENCES Teams(id) ON DELETE CASCADE,
    FOREIGN KEY (playerId) REFERENCES Players(id) ON DELETE CASCADE
);

-- Tracks player performance per match
CREATE TABLE Performance (
    id INT IDENTITY(1,1) PRIMARY KEY,
    playerId INT NOT NULL,
    matchDate DATETIME NOT NULL,
    goals INT DEFAULT 0,
    assists INT DEFAULT 0,
    yellowCards INT DEFAULT 0,
    redCards INT DEFAULT 0,
    cleanSheets INT DEFAULT 0,
    rating DECIMAL(3,1) CHECK (rating BETWEEN 0 AND 10),
	matchesPlayed INT DEFAULT 0,
    FOREIGN KEY (playerId) REFERENCES Players(id) ON DELETE CASCADE
);

-- Stores accumulated points per user
CREATE TABLE UserPoints (
    userId INT PRIMARY KEY,
    totalPoints INT DEFAULT 0,
    FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
	
);

