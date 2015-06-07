select * from Users;
select * from Friends;
select * from NoticeBoard;
select * from BulletinBoard;
select * from Stages;
select * from Ranking;
select * from Ghost;
show tables;

delete from Friends;

create table Users (
	userNumber int primary key not null,
	userID varchar(40) not null,
	userEmail varchar(40) not null,
	userPassword varchar(60)
);
create table Friends (
	userNumber int not null,
	friendNumber int not null,
	primary key (userNumber, friendNumber),
	foreign key (userNumber) references Users(userNumber) ON DELETE cascade ON UPDATE cascade,
	foreign key (friendNumber) references Users(userNumber) ON DELETE cascade ON UPDATE cascade
);
create table NoticeBoard (
	num int primary key not null,
	subject varchar(30) not null,
	registrationDate Timestamp not null,
	content Text not null
);
create table BulletinBoard (
	num int not null,
	userNumber int not null,
	subject varchar(30) not null,
	registrationDate Timestamp not null,
	readCount int not null default 0,
	content Text not null,
	primary key (num, userNumber),
	foreign key (userNumber) references Users(userNumber) ON DELETE cascade ON UPDATE cascade
);
create table Stages (
	stage smallint primary key not null
);
create table Ranking (
	userNumber int not null,
	stage smallint not null,
	recording int not null,
	primary key (userNumber, stage),
	foreign key (userNumber) references Users(userNumber) ON DELETE cascade ON UPDATE cascade,
	foreign key (stage) references Stages(stage) ON DELETE cascade ON UPDATE cascade
);
create table Ghost (
	userNumber int not null,
	stage smallint not null,
	registrationDate Timestamp not null,
	filePath varchar(40) unique not null,
	primary key (userNumber, stage),
	foreign key (userNumber) references Users(userNumber) ON DELETE cascade ON UPDATE cascade,
	foreign key (stage) references Stages(stage) ON DELETE cascade ON UPDATE cascade
);
insert into Users values (0, 'initID', 'initEmail', 'initPassword');
insert into Stages values (1),(2),(3),(4),(5);
insert into Ranking values (1, 1, 203450),(1, 2, 245671),(1, 3, 178450),(1, 4, 343321),(2, 1, 245668),(2, 2, 313485),(2, 3, 146323);
insert into Ghost values (1, 2, '2015-06-06 15:24:37.0', '/ghost/1-1.txt')
							(1, 2, '2015-06-07 18:25:30.0', '/ghost/1-2.txt')
							(2, 1, '2015-06-07 18:25:30.0', '/ghost/2-1.txt'),;
insert into NoticeBoard value (1, '�������� �׽�Ʈ', '2015-06-07 16:28:30.0', '��ȣ!');

----Ghost----
--get ghost path
select filePath from Ghost where stage = 1 and Ghost.userNumber = (select Users.userNumber from Users where userEmail = '123');
--get ghost of one
select * from Ghost where userNumber=1;

----Ranking----
--add
insert into Ranking values (1, 1, 203450);
--update
update Ranking set recording = 203455 where userNumber = 1 and stage = 1;
--check
select * from Ranking where userNumber = 1 and stage = 1;
--get list
select * from Ranking order by stage asc, recording asc;
--get list of one
select * from Ranking where Ranking.userNumber = (select Users.userNumber from Users where Users.userEmail = '123') order by stage asc;

----Friends----
--add
insert into Friends values (1, (select userNumber from Users where userEmail = 'test'));
--delete
delete from Friends where Friends.userNumber = 1 and friendNumber = (select Users.userNumber from Users where Users.userEmail = 'test');
--listing
select Users.userEmail from Users where Users.userNumber in (select Friends.friendNumber from Friends where Friends.userNumber = '1');