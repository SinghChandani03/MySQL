create database Blogging;
use Blogging;


-- Create tables for blogging

create table Users (
    UserId int auto_increment primary key,
    Username varchar(100) unique not null,
	Email varchar(100) unique not null
);

create table Blog_Post (
    PostId int auto_increment primary key,
    Title varchar(250) not null,
    Content text not null,
    Create_date timestamp default current_timestamp,
    AuthorId int unique not null,
    foreign key (AuthorId) references Users (UserId)
);

create table Comments (
    CommentId int auto_increment primary key,
	Content text not null,
    Create_date timestamp default current_timestamp,
    AuthorId int,
	PostId int,
    foreign key (PostId) references Blog_Post(PostId),
    foreign key (AuthorId) references Users(UserId)
);

create table Likes (
    LikeId int auto_increment primary key,
    UserId int,
    PostId int,
	foreign key (PostId) references Blog_Post(PostId),
    foreign key (UserId) references Users(UserId),
	unique (UserId, PostId)
);

-- Insert data in above created table
insert into Users (Username, Email) values 
('chandani', 'chandani@gmail.com'), 
('nandani', 'nandani@gmail.com') ;

describe Users;
select* from Users;
									
insert into Blog_Post ( Title, Content, AuthorId) 
values ( 'Education' , 'Education teach us discipline' , 1), 
( 'Management' , 'Mangement is about to manage time' , 2);       

insert into Blog_Post ( Title, Content, AuthorId) 
values ( 'Youtube' , 'Youtube is the video application' , 1), 
( 'Google' , 'Hello Google' , 1);       

describe Blog_Post;
select* from Blog_Post;

insert into Comments (Content, AuthorId, PostId) values
('I like your page', 1, 2),
('Nice', 1, 1);

describe Comments;
select* from Comments;

insert into Likes (UserId, PostId) values
(2,1);

describe Likes;
select* from Likes;

-- Select Data

-- Retrieve all post with their respective comments

select* from 
Blog_Post bp1
left join Comments c1 on bp1.PostId = c1.PostId;

select bp1.*, c1.Content, c1.AuthorId from 
Blog_Post bp1
left join Comments c1 on bp1.PostId = c1.PostId;

-- Retrieve all post with their total number of likes

-- join
select bp1.*, 
       COUNT(distinct l1.LikeId) AS like_count,
       GROUP_CONCAT(distinct l2.UserId) AS liked_users
from Blog_Post bp1
left join Likes l1 on bp1.PostId = l1.PostId
left join Likes l2 on bp1.PostId = l2.PostId
group by bp1.PostId;

-- SubQuery
select bp1.*, 
       (select COUNT(LikeId) from Likes l where l.PostId = bp1.PostId) AS like_count,
       (select GROUP_CONCAT(UserId) from Likes l where l.PostId = bp1.PostId) AS liked_users
from Blog_Post bp1;

-- Retrieve all recent blog post
select*
from Blog_Post
order by Create_date DESC
LIMIT 2; 


-- Retrieve all the user who liked specific post
select u1.Username, l1.PostId AS liked_post
from Users u1
join Likes l1 on u1.UserId = l1.UserId
where l1.PostId = PostId;


-- Retrieve all comments made by a user
SELECT c1.PostId, c1.Content As Comments, u1.Username AS Commenter_username
FROM Comments c1
JOIN Users u1 ON c1.AuthorId = u1.UserId;





/*
describe Post;
drop table Post;
ALTER TABLE Post
ADD COLUMN AuthorId int unique not null;

ALTER TABLE Post
ADD CONSTRAINT FK_AuthorID
FOREIGN KEY (AuthorID) REFERENCES Users(UserID);

SHOW TABLE STATUS LIKE 'Post';
TRUNCATE TABLE Post;
ALTER TABLE Post AUTO_INCREMENT = 1;
DELETE FROM Post where PostId=7;
DROP TABLE Post;

-- Remove the unique constraint from the AuthorId column
ALTER TABLE Blog_Post MODIFY COLUMN AuthorId INT;

-- Add the foreign key constraint on the AuthorId column
ALTER TABLE Blog_Post ADD CONSTRAINT fk_author FOREIGN KEY (AuthorId) REFERENCES Users(UserId);


-- Remove the UNIQUE constraint from the AuthorId column
ALTER TABLE Blog_Post DROP INDEX AuthorId;

ALTER TABLE Blog_Post MODIFY COLUMN AuthorId INT;

ALTER TABLE Blog_Post DROP FOREIGN KEY blog_post_ibfk_1;

SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'Blog_Post' AND COLUMN_NAME = 'AuthorId';


ALTER TABLE Blog_Post
ADD CONSTRAINT fk_blogpost
foreign key (AuthorId) references Users (UserId)

*/
