use Practice;

select* from Product;

select* from Users;

create table Product (
    Id int primary key auto_increment,
    Name varchar(255),
    Price float,
    Image varchar(255)
);