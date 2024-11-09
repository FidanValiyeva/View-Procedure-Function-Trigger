Create Database BlogDbcd
Use BlogDbcd

create table Categories
(
Id int primary key,
[Name] nvarchar(100) not null unique
)
insert into Categories
values(5,'think')

create table Tags
(
Id int primary key,
[Name] nvarchar(100) not null unique
)

create table Users
(
Id int primary key,
UserName nvarchar(100) not null unique,
FullName nvarchar(100) not null,
Age int check (Age>0 and Age<150)
)

insert into Users
Values(3,'fidan','fidanvali','19')

create table Comments
(
Id int primary key,
Content nvarchar(250) not null ,

UserId int,
BlogId int,

Foreign key (UserId) references Users(id),
Foreign key (BlogId) references Blogs(id)

)



create table Blogs
(
Id int primary key,
Title nvarchar(50) not null,
Description nvarchar(50) not null,

UserId int,
CategoryId int,

Foreign key (UserId) references Users(Id),
Foreign key (CategoryId) references Categories(Id)
)
create table BlogTag
(
BlogId int,
TagId int,

Foreign Key (BlogId) references Blogs(Id),
Foreign Key (TagId) references Tags(Id)
)
insert into Blogs (Id,Title,[Description])
Values(1,'life','life is beatiful'),(2,'science and religion war','what is meaning of life'),(3,'icecream','delicious taste')


insert into Tags
Values(1,'philosophy'),(2,'argument'),(3,'food')

insert into BlogTag
Values(1,1),(1,2),(2,1),(2,2),(3,3)

select Blogs.Title,
Tags.Name
FROM 
BlogTag
Join Blogs on BlogTag.BlogId=Blogs.Id
Join Tags on BlogTag.TagID=Tags.Id

select Blogs.Id,Blogs.Title,Blogs.description,Tags.id,Tags.name
From
Blogs
cross join Tags


create view
interestingBlogs
AS
SELECT UserName, FullName,title
FROM Users
Inner join  Blogs
on Users.Id=Blogs.Id

create view 
titlename
as
select title,Name
From Blogs
inner join Categories
on Blogs.id=Categories.Id

CREATE PROCEDURE AllComments
(
   @userId int
)
 As
 Begin
 select Id 
 from Comments
 WHERE Id = @userId
 end

CREATE PROCEDURE AllBlogs @userId int
As
select*from Blogs
Where Id = @userId


create Function GetBlogCountByCategoryId(@categoryId int)
Returns int
as 
Begin
declare @blogCount int
select @blogCount=Count(*)
from Blogs
where Id = @categoryId
return  @blogCount
End

SELECT dbo.GetBlogCountByCategoryId(1)

create Function GetBlogsbyUserId(@userId int)
Returns Table 
as 
return
select id
from Blogs
Where Id=@userId



