-- required queries , views and procedures
use FantasyFootball

-- display all players

create view AllPlayers as
select id, name, position, price 
from Players

-- select*from AllPlayers

-- display only attackers

create view attackers as
select id, name, position, price 
from Players where position = 'Forward'

select* from attackers

-- display only defenders

create view defenders as
select id, name, position, price 
from Players  where position = 'Defender'

select* from defenders

-- display only midfielders

create view midfielders as
select id, name, position, price 
from Players  where position = 'Midfielder'

select* from midfielders

-- display only goalkeepers

create view goalkeepers as
select id, name, position, price 
from Players  where position = 'Goalkeeper'

select* from goalkeepers

-- display leaderboard

create view leaderboard as
select top 3 up.userId , u.username, up.totalPoints
from UserPoints up 
join Users u on u.id = up.userId
order by totalPoints desc

select* from leaderboard


-- display all players in the users team

create procedure GetUserTeamPlayers  
    @userId int  
as begin  
    select p.id, p.name, p.position, p.price, tp.isBenched, tp.pointMultiplier  
    from TeamPlayers tp  
    join Players p on tp.playerId = p.id  
    join Teams t on tp.teamId = t.id  
    where t.userId = @userId
    order by tp.isBenched asc
end;  

exec GetUserTeamPlayers 6
drop procedure GetUserTeamPlayers


-- display best rated players in recent matches

create view bestPlayers as
select top 5 p.name, p.position , pf.rating
from Performance pf
join Players p 
on pf.playerId = p.id
order by pf.rating desc

select* from bestPlayers

-- display user info

create view usersInfo as
select id , username , email , role , createdAt from Users

select* from usersInfo

-- captain a player

create procedure captainPlayer  
    @playerId int  
as  
begin   

    declare @teamId int;
    declare @isBenched bit;

    -- get stuff
    select @teamId = teamId, @isBenched = isBenched  
    from TeamPlayers  
    where playerId = @playerId;  

    -- bench player can not be captain
    if @isBenched = 1  
    begin  
        print 'Cannot captain a benched player';  
        return;  
    end  

    -- previous one gets uncaptained
    update TeamPlayers  
    set pointMultiplier = case when isBenched = 1 then 0.5 else 1 end  
    where teamId = @teamId;  

    -- Set new captain
    update TeamPlayers  
    set pointMultiplier = 2  
    where playerId = @playerId;  
end;  

-- double captain a player

create procedure doubleCaptainPlayer  
    @playerId int  
as  
begin   

    declare @teamId int;
    declare @isBenched bit;
	declare @pointMultiplier decimal(2,1)
    -- get stuff
    select @teamId = teamId, @isBenched = isBenched , @pointMultiplier = pointMultiplier
    from TeamPlayers  
    where playerId = @playerId;  

    -- bench player can not be captain
    if @isBenched = 1  
    begin  
        print 'Cannot double captain a benched player';  
        return
    end  

	if @pointMultiplier = 2
	begin print 'cannot double captain a captain'
	return 
	end

    -- previous one gets uncaptained

	update TeamPlayers  
    set pointMultiplier = case when isBenched = 1 then 0.5 else 1 end  
    where teamId = @teamId and pointMultiplier = 4;

    -- Set new captain
    update TeamPlayers  
    set pointMultiplier = 4  
    where playerId = @playerId;  
end;  

-- add a player to team 

create procedure AddPlayerToTeam  
    @teamId int,  
    @playerId int  
as begin  
    declare @currentPlayerCount int
    declare @position nvarchar(20)
    declare @gkCount int
    declare @defCount int
    declare @midCount int
    declare @fwdCount int  
    declare @isBenched bit = 1  
    declare @playerPrice decimal(10,2)
    declare @budgetRemaining decimal(10,2) 
    declare @userId int
    declare @pointMultiplier decimal(2,1) = 1.0
	declare @totalGkCount int
    declare @totalDefCount int
    declare @totalMidCount int
    declare @totalFwdCount int

    -- getting stuff that is needed
    select @position = position from Players where id = @playerId
	select @playerPrice = price from Players where id = @playerId  
    select @userId = userId from Teams where id = @teamId  
	select @budgetRemaining = budgetRemaining from Teams where id = @teamId  

    -- check budget
    if @playerPrice > @budgetRemaining  
    begin  
        print 'not enough budget to add this player'  
        return  
    end  

    -- current count of positions in starting 11
    set @gkCount = (select count(*) from TeamPlayers tp  
                    join Players p on tp.playerId = p.id  
                    where tp.teamId = @teamId and tp.isBenched = 0 and p.position = 'Goalkeeper')  

    set @defCount = (select count(*) from TeamPlayers tp  
                     join Players p on tp.playerId = p.id  
                     where tp.teamId = @teamId and tp.isBenched = 0 and p.position = 'Defender')  

    set @midCount = (select count(*) from TeamPlayers tp  
                     join Players p on tp.playerId = p.id  
                     where tp.teamId = @teamId and tp.isBenched = 0 and p.position = 'Midfielder')  

    set @fwdCount = (select count(*) from TeamPlayers tp  
                     join Players p on tp.playerId = p.id  
                     where tp.teamId = @teamId and tp.isBenched = 0 and p.position = 'Forward')  

    -- count of all players already in team
    set @currentPlayerCount = (select count(*) from TeamPlayers where teamId = @teamId)  

	-- count of positions in the whole team including subs

	set @totalGkCount = (select count(*) from TeamPlayers tp  
                          join Players p on tp.playerId = p.id  
                          where tp.teamId = @teamId and p.position = 'Goalkeeper')  

    set @totalDefCount = (select count(*) from TeamPlayers tp  
                           join Players p on tp.playerId = p.id  
                           where tp.teamId = @teamId and p.position = 'Defender')  

    set @totalMidCount = (select count(*) from TeamPlayers tp  
                           join Players p on tp.playerId = p.id  
                           where tp.teamId = @teamId and p.position = 'Midfielder')  

    set @totalFwdCount = (select count(*) from TeamPlayers tp  
                           join Players p on tp.playerId = p.id  
                           where tp.teamId = @teamId and p.position = 'Forward') 


    -- 18 players maximum
    if @currentPlayerCount >= 18  
    begin  
        print 'a team cannot have more than 18 players'
        return  
    end  

    -- if player exists already 
    if exists (select 1 from TeamPlayers where teamId = @teamId and playerId = @playerId)  
    begin  
        print 'player is already in the team'  
        return  
    end  

	-- limitations

	if @position = 'Goalkeeper' and @totalGkCount >= 2
    begin
        print 'a team cannot have more than 2 goalkeepers'
        return  
    end  

    if @position = 'Defender' and @totalDefCount >= 6
    begin
        print 'a team cannot have more than 6 defenders'
        return  
    end  

    if @position = 'Midfielder' and @totalMidCount >= 5
    begin
        print 'a team cannot have more than 5 midfielders'
        return  
    end  

    if @position = 'Forward' and @totalFwdCount >= 5
    begin
        print 'a team cannot have more than 5 forwards'
        return  
    end

    -- first eleven are starters
	-- first eleven contains only 1 gk , 4 defenders , 3 midfielders , 3 attackers
    if @currentPlayerCount < 11  
    begin  
        if (@position = 'Goalkeeper' and @gkCount < 1) or  
           (@position = 'Defender' and @defCount < 4) or  
           (@position = 'Midfielder' and @midCount < 3) or  
           (@position = 'Forward' and @fwdCount < 3)  
        begin  
            set @isBenched = 0   
        end  
    end  

    -- half points for subs
    if @isBenched = 1  
        set @pointMultiplier = 0.5  

    -- finally insert
    insert into TeamPlayers (teamId, playerId, pointMultiplier, isBenched)  
    values (@teamId, @playerId, @pointMultiplier, @isBenched)  

    -- subtract price from budget after inserting
    update Teams  
    set budgetRemaining = budgetRemaining - @playerPrice  
    where id = @teamId  

    -- if team has 18 players set isComplete to true in teams table
    if @currentPlayerCount + 1 = 18  
    begin  
        update Teams  
        set isComplete = 1  
        where id = @teamId  
    end  
end;

drop procedure AddPlayerToTeam
exec AddPlayerToTeam 7 , 1 



-- sell a player

create procedure sellTeamPlayer
	
	@teamId int ,
	@playerId int

as begin
	
	declare @playerPrice decimal(10,2)
	declare @budgetRemaining decimal(10,2)

	-- get player price
	select @playerPrice = price from Players where id = @playerId

	-- check if he exists
	if not exists (select 1 from TeamPlayers where teamId = @teamId AND playerId = @playerId)  
    begin  
        print 'Player not found in the team';  
        return;  
    end 

	-- delete
	delete from TeamPlayers where teamId = @teamId AND playerId = @playerId;

	-- add his price back to budget
	update Teams  
    set budgetRemaining = budgetRemaining + @playerPrice  
    where id = @teamId;  

	-- set is complete to 0
	update Teams
	set isComplete = 0
	where id = @teamId

    print 'Player sold successfully';  
end;

select*from Users
select* from Teams
select* from TeamPlayers

exec sellTeamPlayer 7 , 1


-- create user 
create procedure createUser
    @username nvarchar(50),
    @email nvarchar(100),
    @password nvarchar(255),
	@role nvarchar(10)
as  
begin  
    declare @userId int, @teamId int, @isComplete bit, @totalPoints int = 0  
    declare @startingPoints int = 0, @benchPoints int = 0  

    -- insert into the users table  
    insert into users (username, email, password , role)  
    values (@username, @email, @password , @role)  

    -- get id of the user  
    select @userId = id from users where email = @email  

    -- put in userPoints table  
    insert into userPoints (userId, totalPoints)  
    values (@userId, 0)  

    -- get the team id  
    select @teamId = id, @isComplete = isComplete from teams where userId = @userId  

    -- if team is incomplete points stay zero 
    if @teamId is null or @isComplete = 0  
    begin  
        return  
    end  

    --points for starting 11  
    select @startingPoints = sum(  
        (  
            (p.goals * 5) +  
            (p.assists * 3) +  
            (p.cleanSheets * 2) -  
            (p.yellowCards * 1) -  
            (p.redCards * 3)  
        ) * tp.pointMultiplier  
    )  
    from players p  
    inner join teamPlayers tp on p.id = tp.playerId  
    where tp.teamId = @teamId and tp.isBenched = 0  

    -- points for subs
    select @benchPoints = sum(  
        (  
            (p.goals * 5) +  
            (p.assists * 3) +  
            (p.cleanSheets * 2) -  
            (p.yellowCards * 1) -  
            (p.redCards * 3)  
        ) * (tp.pointMultiplier / 2)  
    )  
    from players p  
    inner join teamPlayers tp on p.id = tp.playerId  
    where tp.teamId = @teamId and tp.isBenched = 1  

    --total points  
    set @totalPoints = isnull(@startingPoints, 0) + isnull(@benchPoints, 0)  

    -- update userPoints table  
    update userPoints  
    set totalPoints = @totalPoints  
    where userId = @userId  
end  



-- update user points

create procedure UpdateUserPoints
as begin

    update userPoints  
    set totalPoints = (  
        select sum(  
            (  
                (p.goals * 5) +  
                (p.assists * 3) +  
                (p.cleanSheets * 2) -  
                (p.yellowCards * 1) -  
                (p.redCards * 3)  
            ) * tp.pointMultiplier  
        )  
        from players p  
        inner join teamPlayers tp on p.id = tp.playerId  
        inner join teams t on tp.teamId = t.id  
        where t.userId = userPoints.userId and tp.isBenched = 0  
    ) + (select sum(
	
                (  
                    (p.goals * 5) +  
                    (p.assists * 3) +  
                    (p.cleanSheets * 2) -  
                    (p.yellowCards * 1) -  
                    (p.redCards * 3)  
                ) * (tp.pointMultiplier / 2)  
            )  
            from players p  
            inner join teamPlayers tp on p.id = tp.playerId  
            inner join teams t on tp.teamId = t.id  
            where t.userId = userPoints.userId and tp.isBenched = 1   
    )  
    where userId in (select userId from teams where isComplete = 1);
end;



-- get player by name

Select name
From Players
Where name = 'Harry Kane'

