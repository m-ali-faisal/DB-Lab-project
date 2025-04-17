use FantasyFootball

-- Insert data into Players table
INSERT INTO Players (name, position, club, goals, assists, yellowCards, redCards, cleanSheets, price)
VALUES 
-- Forwards
('Harry Kane', 'Forward', 'Bayern Munich', 32, 8, 4, 0, 0, 95.50),
('Erling Haaland', 'Forward', 'Manchester City', 36, 5, 2, 0, 0, 120.00),
('Kylian Mbappe', 'Forward', 'Real Madrid', 28, 12, 3, 0, 0, 115.75),
('Mohamed Salah', 'Forward', 'Liverpool', 24, 14, 1, 0, 0, 90.25),
('Robert Lewandowski', 'Forward', 'Barcelona', 26, 7, 2, 0, 0, 85.00),
('Marcus Rashford', 'Forward', 'Manchester United', 14, 8, 5, 0, 0, 70.50),
('Victor Osimhen', 'Forward', 'Chelsea', 22, 4, 7, 1, 0, 82.75),
('Lautaro Martinez', 'Forward', 'Inter Milan', 25, 6, 8, 0, 0, 78.25),
('Vinicius Jr', 'Forward', 'Real Madrid', 18, 16, 6, 0, 0, 105.00),
('Julian Alvarez', 'Forward', 'Atletico Madrid', 16, 9, 3, 0, 0, 65.75),
('Alexander Isak', 'Forward', 'Newcastle', 20, 5, 2, 0, 0, 72.50),
('Ollie Watkins', 'Forward', 'Aston Villa', 19, 11, 4, 0, 0, 67.25),
('Darwin Nunez', 'Forward', 'Liverpool', 15, 7, 9, 1, 0, 68.00),

-- Midfielders
('Kevin De Bruyne', 'Midfielder', 'Manchester City', 10, 20, 3, 0, 0, 89.50),
('Bruno Fernandes', 'Midfielder', 'Manchester United', 12, 17, 6, 0, 0, 82.00),
('Rodri', 'Midfielder', 'Manchester City', 5, 8, 10, 0, 0, 85.50),
('Jude Bellingham', 'Midfielder', 'Real Madrid', 17, 10, 5, 0, 0, 105.25),
('Martin Odegaard', 'Midfielder', 'Arsenal', 9, 13, 2, 0, 0, 75.75),
('Phil Foden', 'Midfielder', 'Manchester City', 14, 11, 1, 0, 0, 88.25),
('Declan Rice', 'Midfielder', 'Arsenal', 4, 7, 7, 0, 0, 80.00),
('Florian Wirtz', 'Midfielder', 'Bayer Leverkusen', 11, 15, 3, 0, 0, 84.50),
('Federico Valverde', 'Midfielder', 'Real Madrid', 6, 9, 8, 0, 0, 79.75),
('Bernardo Silva', 'Midfielder', 'Manchester City', 8, 12, 2, 0, 0, 77.50),
('Toni Kroos', 'Midfielder', 'Real Madrid', 3, 16, 4, 0, 0, 60.00),
('Cole Palmer', 'Midfielder', 'Chelsea', 16, 14, 5, 0, 0, 82.25),
('James Maddison', 'Midfielder', 'Tottenham', 7, 11, 3, 0, 0, 66.50),

-- Defenders
('Virgil van Dijk', 'Defender', 'Liverpool', 3, 1, 5, 0, 16, 82.00),
('Ruben Dias', 'Defender', 'Manchester City', 1, 2, 6, 0, 18, 80.50),
('Antonio Rudiger', 'Defender', 'Real Madrid', 2, 0, 8, 1, 14, 75.25),
('William Saliba', 'Defender', 'Arsenal', 1, 0, 4, 0, 15, 78.75),
('Theo Hernandez', 'Defender', 'AC Milan', 4, 7, 9, 1, 10, 72.00),
('Trent Alexander-Arnold', 'Defender', 'Liverpool', 2, 12, 3, 0, 12, 77.50),
('Josko Gvardiol', 'Defender', 'Manchester City', 3, 5, 7, 0, 14, 74.25),
('Matthijs de Ligt', 'Defender', 'Bayern Munich', 3, 1, 10, 0, 12, 70.50),
('Achraf Hakimi', 'Defender', 'PSG', 5, 8, 5, 0, 11, 72.75),
('Marquinhos', 'Defender', 'PSG', 2, 1, 4, 0, 13, 68.00),
('Lisandro Martinez', 'Defender', 'Manchester United', 1, 3, 11, 1, 9, 65.25),
('Jules Kounde', 'Defender', 'Barcelona', 0, 4, 6, 0, 12, 67.50),

-- Goalkeepers
('Alisson Becker', 'Goalkeeper', 'Liverpool', 0, 1, 2, 0, 18, 65.00),
('Ederson', 'Goalkeeper', 'Manchester City', 0, 3, 3, 0, 17, 62.50),
('Thibaut Courtois', 'Goalkeeper', 'Real Madrid', 0, 0, 1, 0, 19, 67.25),
('Emiliano Martinez', 'Goalkeeper', 'Aston Villa', 0, 0, 5, 1, 14, 55.00),
('Andre Onana', 'Goalkeeper', 'Manchester United', 0, 0, 2, 0, 10, 48.75),
('Mike Maignan', 'Goalkeeper', 'AC Milan', 0, 0, 3, 0, 15, 53.25),
('Jordan Pickford', 'Goalkeeper', 'Everton', 0, 0, 4, 0, 12, 45.50),
('Jan Oblak', 'Goalkeeper', 'Atletico Madrid', 0, 0, 1, 0, 16, 58.75),
('Aaron Ramsdale', 'Goalkeeper', 'Arsenal', 0, 0, 2, 0, 13, 42.00),
('Marc-Andre ter Stegen', 'Goalkeeper', 'Barcelona', 0, 0, 1, 0, 15, 57.25),
('David Raya', 'Goalkeeper', 'Arsenal', 0, 0, 3, 0, 14, 50.75),
('Gianluigi Donnarumma', 'Goalkeeper', 'PSG', 0, 0, 2, 0, 17, 60.00);

-- Insert data into Performance table with matches played between 10 and 20
INSERT INTO Performance (playerId, matchDate, goals, assists, yellowCards, redCards, cleanSheets, rating, matchesPlayed)
VALUES
-- Forwards
(1, '2024-08-24', 6, 2, 1, 0, 0, 8.8, 12),  -- Harry Kane
(2, '2024-08-17', 8, 1, 0, 0, 0, 9.4, 14),  -- Erling Haaland
(3, '2024-09-02', 5, 3, 1, 0, 0, 8.9, 11),  -- Kylian Mbappe
(4, '2024-09-15', 7, 4, 0, 0, 0, 9.1, 13),  -- Mohamed Salah
(5, '2024-08-21', 6, 1, 1, 0, 0, 8.7, 12),  -- Robert Lewandowski
(6, '2024-09-07', 4, 2, 2, 0, 0, 7.8, 10),  -- Marcus Rashford
(7, '2024-09-23', 5, 1, 2, 0, 0, 8.2, 12),  -- Victor Osimhen
(8, '2024-08-30', 6, 2, 3, 0, 0, 8.5, 15),  -- Lautaro Martinez
(9, '2024-09-05', 4, 5, 2, 0, 0, 8.6, 11),  -- Vinicius Jr
(10, '2024-08-19', 5, 3, 1, 0, 0, 8.3, 14),  -- Julian Alvarez
(11, '2024-09-18', 6, 1, 0, 0, 0, 8.7, 13),  -- Alexander Isak
(12, '2024-08-27', 5, 3, 1, 0, 0, 8.4, 12),  -- Ollie Watkins
(13, '2024-09-14', 4, 2, 3, 1, 0, 7.6, 11),  -- Darwin Nunez

-- Midfielders
(14, '2024-08-22', 3, 6, 1, 0, 0, 8.8, 14),  -- Kevin De Bruyne
(15, '2024-09-11', 3, 5, 2, 0, 0, 8.5, 13),  -- Bruno Fernandes
(16, '2024-08-18', 1, 2, 3, 0, 0, 7.9, 16),  -- Rodri
(17, '2024-09-25', 4, 3, 1, 0, 0, 8.7, 12),  -- Jude Bellingham
(18, '2024-08-29', 2, 4, 0, 0, 0, 8.4, 11),  -- Martin Odegaard
(19, '2024-09-03', 3, 3, 0, 0, 0, 8.6, 15),  -- Phil Foden
(20, '2024-08-25', 1, 2, 2, 0, 0, 7.8, 18),  -- Declan Rice
(21, '2024-09-16', 3, 4, 1, 0, 0, 8.5, 12),  -- Florian Wirtz
(22, '2024-08-31', 2, 3, 2, 0, 0, 8.1, 14),  -- Federico Valverde
(23, '2024-09-08', 2, 3, 0, 0, 0, 8.3, 13),  -- Bernardo Silva
(24, '2024-08-20', 1, 5, 1, 0, 0, 8.2, 15),  -- Toni Kroos
(25, '2024-09-27', 4, 4, 2, 0, 0, 8.6, 12),  -- Cole Palmer
(26, '2024-08-23', 2, 3, 1, 0, 0, 7.9, 11),  -- James Maddison

-- Defenders
(27, '2024-09-01', 1, 0, 1, 0, 5, 8.3, 17),  -- Virgil van Dijk
(28, '2024-08-26', 0, 1, 2, 0, 6, 8.1, 18),  -- Ruben Dias
(29, '2024-09-09', 1, 0, 3, 0, 4, 7.8, 16),  -- Antonio Rudiger
(30, '2024-08-16', 0, 0, 1, 0, 5, 8.2, 15),  -- William Saliba
(31, '2024-09-22', 1, 2, 3, 0, 3, 7.9, 13),  -- Theo Hernandez
(32, '2024-08-28', 0, 4, 1, 0, 4, 8.4, 17),  -- Trent Alexander-Arnold
(33, '2024-09-06', 1, 1, 2, 0, 5, 8.0, 14),  -- Josko Gvardiol
(34, '2024-08-19', 1, 0, 3, 0, 4, 7.7, 16),  -- Matthijs de Ligt
(35, '2024-09-17', 2, 3, 1, 0, 4, 8.2, 15),  -- Achraf Hakimi
(36, '2024-08-24', 1, 0, 1, 0, 5, 8.0, 17),  -- Marquinhos
(37, '2024-09-20', 0, 1, 4, 1, 3, 7.5, 13),  -- Lisandro Martinez
(38, '2024-08-27', 0, 1, 2, 0, 4, 7.9, 16),  -- Jules Kounde

-- Goalkeepers
(39, '2024-09-12', 0, 0, 1, 0, 7, 8.5, 18),  -- Alisson Becker
(40, '2024-08-21', 0, 1, 1, 0, 6, 8.3, 17),  -- Ederson
(41, '2024-09-04', 0, 0, 0, 0, 8, 8.7, 19),  -- Thibaut Courtois
(42, '2024-08-30', 0, 0, 2, 0, 5, 8.1, 15),  -- Emiliano Martinez
(43, '2024-09-19', 0, 0, 1, 0, 4, 7.7, 14),  -- Andre Onana
(44, '2024-08-23', 0, 0, 1, 0, 6, 8.2, 17),  -- Mike Maignan
(45, '2024-09-10', 0, 0, 2, 0, 4, 7.8, 14),  -- Jordan Pickford
(46, '2024-08-17', 0, 0, 0, 0, 6, 8.4, 16),  -- Jan Oblak
(47, '2024-09-28', 0, 0, 1, 0, 5, 7.9, 15),  -- Aaron Ramsdale
(48, '2024-08-25', 0, 0, 0, 0, 6, 8.3, 16),  -- Marc-Andre ter Stegen
(49, '2024-09-13', 0, 0, 1, 0, 5, 8.0, 15),  -- David Raya
(50, '2024-08-29', 0, 0, 1, 0, 7, 8.6, 17);  -- Gianluigi Donnarumma


INSERT INTO Players (name, position, club, goals, assists, yellowCards, redCards, cleanSheets, price)
VALUES 
-- Forwards
('Dusan Vlahovic', 'Forward', 'Juventus', 21, 6, 5, 0, 0, 75.50),
('Christopher Nkunku', 'Forward', 'Chelsea', 18, 10, 2, 0, 0, 79.00),
('Nicolas Jackson', 'Forward', 'Villarreal', 17, 7, 6, 0, 0, 65.25),
('Serhou Guirassy', 'Forward', 'Borussia Dortmund', 23, 3, 4, 1, 0, 71.75),
('Joshua Zirkzee', 'Forward', 'Manchester United', 15, 9, 3, 0, 0, 67.50),
('Dominic Solanke', 'Forward', 'Tottenham', 20, 6, 4, 0, 0, 69.00),
('Jonathan David', 'Forward', 'Arsenal', 22, 4, 3, 0, 0, 73.25),
('Benjamin Sesko', 'Forward', 'RB Leipzig', 19, 5, 5, 0, 0, 68.75),
('Borja Iglesias', 'Forward', 'Betis', 14, 8, 7, 0, 0, 58.50),
('Rasmus Hojlund', 'Forward', 'Atalanta', 16, 5, 6, 1, 0, 62.75),
('Eddie Nketiah', 'Forward', 'Crystal Palace', 13, 4, 3, 0, 0, 55.25),
('Tammy Abraham', 'Forward', 'Roma', 15, 7, 5, 0, 0, 61.00),
('Giovanni Simeone', 'Forward', 'Napoli', 12, 6, 8, 0, 0, 53.50),

-- Midfielders
('Ederson', 'Midfielder', 'Atalanta', 6, 11, 7, 0, 0, 66.25),
('Ryan Gravenberch', 'Midfielder', 'Liverpool', 5, 9, 4, 0, 0, 71.50),
('Conor Gallagher', 'Midfielder', 'Atletico Madrid', 7, 12, 9, 0, 0, 69.75),
('Enzo Fernandez', 'Midfielder', 'Chelsea', 4, 14, 8, 0, 0, 75.25),
('Nicolo Barella', 'Midfielder', 'Inter Milan', 8, 15, 10, 0, 0, 78.50),
('Pedri', 'Midfielder', 'Barcelona', 9, 16, 3, 0, 0, 80.75),
('Christian Eriksen', 'Midfielder', 'Brentford', 6, 13, 2, 0, 0, 58.25),
('Alexis Mac Allister', 'Midfielder', 'Liverpool', 7, 10, 6, 0, 0, 72.00),
('Guido Rodriguez', 'Midfielder', 'Betis', 3, 8, 12, 1, 0, 57.50),
('Fabian Ruiz', 'Midfielder', 'PSG', 5, 11, 5, 0, 0, 63.25),
('Houssem Aouar', 'Midfielder', 'Roma', 7, 9, 4, 0, 0, 60.00),
('Orkun Kokcu', 'Midfielder', 'Benfica', 10, 13, 7, 0, 0, 68.25),
('Youri Tielemans', 'Midfielder', 'Aston Villa', 6, 12, 5, 0, 0, 65.00),

-- Defenders
('Cristian Romero', 'Defender', 'Tottenham', 2, 1, 11, 1, 11, 71.25),
('Fikayo Tomori', 'Defender', 'AC Milan', 0, 2, 7, 0, 13, 67.50),
('Dayot Upamecano', 'Defender', 'Bayern Munich', 1, 0, 9, 0, 14, 69.75),
('David Alaba', 'Defender', 'Real Madrid', 2, 3, 5, 0, 12, 65.00),
('Nuno Mendes', 'Defender', 'PSG', 3, 6, 4, 0, 10, 70.25),
('Ben White', 'Defender', 'Arsenal', 1, 5, 6, 0, 13, 66.50),
('Ronald Araujo', 'Defender', 'Barcelona', 3, 0, 8, 1, 12, 73.00),
('Robin Le Normand', 'Defender', 'Atletico Madrid', 2, 1, 7, 0, 11, 64.25),
('Micky van de Ven', 'Defender', 'Tottenham', 1, 2, 5, 0, 12, 68.75),
('Alessandro Bastoni', 'Defender', 'Inter Milan', 0, 4, 6, 0, 14, 72.50),
('Wesley Fofana', 'Defender', 'Chelsea', 1, 0, 4, 0, 9, 63.00),
('Castello Lukeba', 'Defender', 'RB Leipzig', 0, 2, 5, 0, 11, 61.75),

-- Goalkeepers
('Gregor Kobel', 'Goalkeeper', 'Borussia Dortmund', 0, 0, 1, 0, 16, 56.25),
('Diogo Costa', 'Goalkeeper', 'Porto', 0, 0, 2, 0, 15, 53.50),
('Unai Simon', 'Goalkeeper', 'Athletic Bilbao', 0, 0, 3, 0, 14, 51.75),
('Alex Remiro', 'Goalkeeper', 'Real Sociedad', 0, 0, 2, 0, 17, 54.00),
('Robert Sanchez', 'Goalkeeper', 'Chelsea', 0, 1, 3, 0, 12, 46.25),
('Yann Sommer', 'Goalkeeper', 'Inter Milan', 0, 0, 1, 0, 15, 49.50),
('Dominik Livakovic', 'Goalkeeper', 'Fenerbahce', 0, 0, 2, 1, 13, 47.75),
('Edouard Mendy', 'Goalkeeper', 'Al-Ahli', 0, 0, 1, 0, 14, 45.00),
('Guglielmo Vicario', 'Goalkeeper', 'Tottenham', 0, 0, 2, 0, 13, 52.25),
('Justin Bijlow', 'Goalkeeper', 'Feyenoord', 0, 0, 1, 0, 12, 43.50),
('Nick Pope', 'Goalkeeper', 'Newcastle', 0, 0, 2, 0, 15, 51.00),
('Geronimo Rulli', 'Goalkeeper', 'Ajax', 0, 0, 3, 0, 11, 44.75);

-- Insert data into Performance table with matches played between 10 and 20
INSERT INTO Performance (playerId, matchDate, goals, assists, yellowCards, redCards, cleanSheets, rating, matchesPlayed)
VALUES
-- Forwards
(51, '2024-08-18', 5, 1, 2, 0, 0, 8.1, 11),  -- Dusan Vlahovic
(52, '2024-09-01', 4, 3, 1, 0, 0, 8.3, 12),  -- Christopher Nkunku
(53, '2024-08-25', 4, 2, 2, 0, 0, 7.9, 13),  -- Nicolas Jackson
(54, '2024-09-08', 6, 1, 1, 0, 0, 8.4, 14),  -- Serhou Guirassy
(55, '2024-08-22', 4, 3, 1, 0, 0, 8.0, 11),  -- Joshua Zirkzee
(56, '2024-09-12', 5, 2, 1, 0, 0, 8.2, 13),  -- Dominic Solanke
(57, '2024-08-30', 6, 1, 1, 0, 0, 8.5, 14),  -- Jonathan David
(58, '2024-09-05', 5, 1, 2, 0, 0, 8.1, 12),  -- Benjamin Sesko
(59, '2024-08-19', 3, 2, 3, 0, 0, 7.7, 10),  -- Borja Iglesias
(60, '2024-09-14', 4, 2, 2, 0, 0, 7.9, 12),  -- Rasmus Hojlund
(61, '2024-08-27', 3, 1, 1, 0, 0, 7.6, 11),  -- Eddie Nketiah
(62, '2024-09-03', 4, 2, 2, 0, 0, 7.8, 13),  -- Tammy Abraham
(63, '2024-08-21', 3, 2, 3, 0, 0, 7.5, 10),  -- Giovanni Simeone

-- Midfielders
(64, '2024-09-11', 2, 3, 2, 0, 0, 7.9, 15),  -- Ederson
(65, '2024-08-23', 1, 3, 1, 0, 0, 8.0, 14),  -- Ryan Gravenberch
(66, '2024-09-06', 2, 4, 3, 0, 0, 7.8, 13),  -- Conor Gallagher
(67, '2024-08-28', 1, 4, 2, 0, 0, 8.1, 16),  -- Enzo Fernandez
(68, '2024-09-15', 2, 5, 4, 0, 0, 8.2, 15),  -- Nicolo Barella
(69, '2024-08-20', 3, 5, 1, 0, 0, 8.4, 13),  -- Pedri
(70, '2024-09-09', 2, 4, 1, 0, 0, 7.9, 12),  -- Christian Eriksen
(71, '2024-08-31', 2, 3, 2, 0, 0, 8.0, 14),  -- Alexis Mac Allister
(72, '2024-09-16', 1, 2, 4, 0, 0, 7.6, 16),  -- Guido Rodriguez
(73, '2024-08-26', 1, 3, 2, 0, 0, 7.8, 13),  -- Fabian Ruiz
(74, '2024-09-02', 2, 3, 1, 0, 0, 7.7, 12),  -- Houssem Aouar
(75, '2024-08-24', 3, 4, 2, 0, 0, 8.1, 14),  -- Orkun Kokcu
(76, '2024-09-13', 2, 4, 2, 0, 0, 7.9, 13),  -- Youri Tielemans

-- Defenders
(77, '2024-08-29', 1, 0, 4, 0, 4, 7.7, 15),  -- Cristian Romero
(78, '2024-09-04', 0, 1, 2, 0, 5, 7.9, 16),  -- Fikayo Tomori
(79, '2024-08-17', 0, 0, 3, 0, 5, 7.8, 14),  -- Dayot Upamecano
(80, '2024-09-10', 1, 1, 2, 0, 4, 7.9, 15),  -- David Alaba
(81, '2024-08-22', 1, 2, 1, 0, 3, 8.0, 14),  -- Nuno Mendes
(82, '2024-09-07', 0, 2, 2, 0, 5, 7.9, 16),  -- Ben White
(83, '2024-08-15', 1, 0, 3, 1, 4, 7.6, 13),  -- Ronald Araujo
(84, '2024-09-18', 1, 0, 2, 0, 4, 7.7, 15),  -- Robin Le Normand
(85, '2024-08-25', 0, 1, 2, 0, 5, 7.8, 14),  -- Micky van de Ven
(86, '2024-09-01', 0, 1, 2, 0, 5, 8.1, 16),  -- Alessandro Bastoni
(87, '2024-08-19', 0, 0, 1, 0, 3, 7.5, 12),  -- Wesley Fofana
(88, '2024-09-14', 0, 1, 2, 0, 4, 7.6, 14),  -- Castello Lukeba

-- Goalkeepers
(89, '2024-08-16', 0, 0, 0, 0, 6, 8.2, 16),  -- Gregor Kobel
(90, '2024-09-03', 0, 0, 1, 0, 5, 8.0, 15),  -- Diogo Costa
(91, '2024-08-20', 0, 0, 1, 0, 5, 7.9, 14),  -- Unai Simon
(92, '2024-09-11', 0, 0, 1, 0, 7, 8.3, 17),  -- Alex Remiro
(93, '2024-08-28', 0, 0, 1, 0, 4, 7.6, 12),  -- Robert Sanchez
(94, '2024-09-05', 0, 0, 0, 0, 6, 8.1, 15),  -- Yann Sommer
(95, '2024-08-23', 0, 0, 1, 1, 5, 7.8, 14),  -- Dominik Livakovic
(96, '2024-09-17', 0, 0, 0, 0, 5, 7.9, 14),  -- Edouard Mendy
(97, '2024-08-31', 0, 0, 1, 0, 5, 8.0, 13),  -- Guglielmo Vicario
(98, '2024-09-08', 0, 0, 0, 0, 4, 7.7, 12),  -- Justin Bijlow
(99, '2024-08-27', 0, 0, 1, 0, 6, 8.1, 15),  -- Nick Pope
(100, '2024-09-20', 0, 0, 1, 0, 4, 7.5, 13);  -- Geronimo Rulli


