												-- INTRODUCTION
                                                
-- This project is about business of hotels at different locations and using basics and subqueries,
-- joins,grouping and aggregate functions   

                                           -- CREATING ALL THE REQUIRED TABLES

CREATE TABLE hotel ( 
hotel_no CHAR(4) NOT NULL primary key,
name VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL
);

CREATE TABLE room (
room_no VARCHAR(4) NOT NULL primary key,
hotel_no CHAR(4) NOT NULL,
type CHAR(1) NOT NULL,  -- room types are S,D,T,Q(single,double,triple,quad)
price DECIMAL(5,2) NOT NULL,
foreign key(hotel_no) references hotel(hotel_no)
);

CREATE TABLE guest (
guest_no CHAR(4) NOT NULL primary key,
name VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL 
);

CREATE TABLE booking (
hotel_no CHAR(4) NOT NULL,
guest_no CHAR(4) NOT NULL,
date_from DATETIME NOT NULL,
date_to DATETIME NULL,
room_no CHAR(4) NOT NULL,
foreign key (guest_no) references guest(guest_no)
);

										  -- INSERTING VALUES INTO THE TABLES

INSERT INTO hotel VALUES ('H111', 'Grosvenor Hotel', 'London'),
('H112', 'Crowne Plaza Hotel', 'Hong Kong'),
('H113', 'Emerald Bay Hotel', 'London'),
('H114', 'Bliss Hotel', 'Dubai'),
('H115', 'The New View Hotel', 'Mexico'),
('H116', 'Ramada Hotel', 'London'),
('H117', 'Sunset  Hotel', 'Macau'),
('H118', 'Lake Place Hotel', 'Dubai'),
('H119', 'Beacon Motel Hotel', 'Kuala Lumpur'),
('H120', 'Comfort B&B Hotel', 'Mexico'),
('H121', 'The Fresco Hotel', 'London'),
('H122', 'Motel Main Hotel', 'Dubai'),
('H123', 'Holly House Hotel', 'Mexico'),
('H124', 'High Desert Hotel', 'Moscow'),
('H125', 'Four Seasons Hotel', 'Porto');

INSERT INTO room VALUES ('501', 'H111', 'S', 72.00),
('502', 'H111', 'D', 82.00),
('503', 'H111', 'T', 92.00),
('504', 'H111', 'D', 82.00),
('505', 'H112', 'S', 18.00),
('506', 'H112', 'T', 28.00),
('507', 'H113', 'S', 25.00),
('508', 'H113', 'Q', 38.00),
('554', 'H111', 'T', 39.00),
('564', 'H111', 'Q', 35.00),
('509', 'H113', 'D', 30.00),
('510', 'H114', 'Q', 30.00),
('511', 'H115', 'S', 72.00),
('512', 'H115', 'T', 92.00),
('513', 'H116', 'Q', 102.00),
('514', 'H117', 'D', 35.00),
('515', 'H118', 'D', 30.00),

('516', 'H118', 'S', 21.00),
('517', 'H118', 'Q', 102.00),
('518', 'H119', 'D', 82.00),
('519', 'H119', 'D', 29.00),
('520', 'H119', 'T', 39.00),
('579', 'H111', 'T', 92.00),
('567', 'H111', 'D', 80.00),
('521', 'H119', 'Q', 35.00),
('522', 'H120', 'D', 40.00),
('592', 'H111', 'D', 40.00),
('586', 'H111', 'T', 60.00),
('523', 'H120', 'T', 60.00),
('524', 'H121', 'T', 92.00),
('525', 'H122', 'D', 80.00),
('526', 'H122', 'Q', 160.00),
('527', 'H123', 'T', 92.00),
('528', 'H124', 'S', 72.00),
('529', 'H125', 'Q', 102.00),
('530', 'H125', 'S', 72.00);






INSERT INTO guest VALUES ('G111', 'John Smith', 'London'),
('G112', 'Oliver', 'Hong Kong'),
('G113', 'Ethan', 'Bangkok'),
('G114', 'Amelia', 'Dubai'),
('G115', 'Mia Leon', 'Singapore'),
('G116', 'Lucas', 'Rome'),
('G117', 'Chloe', 'Macau'),
('G118', 'John Ava', 'Istanbul'),
('G119', 'Noah Smith', 'Kuala Lumpur'),
('G120', 'Enzo', 'Delhi'),
('G121', 'J Lea', 'Antalya'),
('G122', 'Mathias', 'Tokyo'),
('G123', 'Clara', 'Mexico'),
('G124', 'Nathan Ines', 'Moscow'),
('G125', 'Jade Hugo', 'Porto'),

('G126', 'John Gresham', 'London'),
('G127', 'Oliver Had', 'Hong Kong'),
('G128', 'Ethan Jo', 'Bangkok'),
('G129', 'Amelia Ko', 'Dubai'),
('G130', 'Mia Dow', 'Singapore'),
('G131', 'Lucas Happri', 'Rome'),
('G132', 'Chloe Nicol', 'Macau'),
('G133', 'Modon Ava', 'Istanbul'),
('G134', 'Martin Smith', 'Kuala Lumpur'),
('G135', 'Enzo', 'Delhi'),
('G136', 'J Lea', 'Antalya'),
('G137', 'Mathias', 'Tokyo'),
('G138','Clara Methun', 'Mexico'),
('G139', 'Nathan', 'Moscow'),
('G140', 'Randy Orton', 'Porto');

INSERT INTO booking VALUES ('H111', 'G111', DATE'1999-01-01', DATE'1999-01-02', '522'),
('H112', 'G113', DATE'2022-04-24', DATE'2022-04-25', '521'),
('H112', 'G114', DATE'2021-08-26', DATE'2021-08-27', '508'),
('H113', 'G115', DATE'2021-08-29', NULL , '509'),
('H111', 'G116', DATE'2022-01-01', DATE'2022-01-02', '501'),
('H113', 'G116', DATE'2022-06-28', DATE'2022-06-28', '511'),
('H112', 'G113', DATE'2021-08-25', DATE'2021-08-26', '507'),
('H112', 'G112', DATE'1999-04-21', DATE'1999-04-22', '522'),
('H113', 'G116', DATE'2021-02-08', DATE'2021-02-09', '512'),
('H111', 'G111', DATE'1999-01-05', DATE'1999-01-06', '507'),
('H113', 'G117', DATE'2021-02-15', DATE'2021-02-16', '513'),
('H112', 'G113', DATE'1999-04-23', DATE'1999-04-24', '505'),
('H114', 'G117', DATE'2021-02-18', NULL, '514'),
('H116', 'G118', DATE'1999-01-01', DATE'1999-01-02', '530'),
('H116', 'G118', DATE'1999-02-11', DATE'1999-02-12', '511'),
('H116', 'G119', DATE'1999-04-21', DATE'1999-04-22', '504'),
('H115', 'G117', DATE'2022-02-26', DATE'2022-02-27', '523'),
('H116', 'G118', DATE'1999-01-05', DATE'1999-01-06', '502'),
('H117', 'G120', DATE'2021-04-24', DATE'2021-04-25', '506'),
('H111', 'G121', DATE'2021-08-25', DATE'2021-08-26', '502'),
('H118', 'G122', DATE'2021-08-26', NULL, '508'),
('H119', 'G124', DATE'2022-02-08', DATE'2022-02-09', '525'),
('H120', 'G127', DATE'2021-02-26', DATE'2021-02-27', '515'),
('H118', 'G123', DATE'2021-08-29', DATE'2021-08-30', '524'),
('H111', 'G124', DATE'2022-02-04', DATE'2022-02-05', '503'),
('H119', 'G125', DATE'2022-02-15', DATE'2022-02-16', '513'),
('H120', 'G126', DATE'2021-02-18', DATE'2021-02-19', '514'),
('H117', 'G119', DATE'1999-04-23', DATE'1999-04-24', '505'),
('H119', 'G123', DATE'2021-01-01', DATE'2021-01-02', '530'),
('H111', 'G112', DATE'1999-02-11', DATE'1999-02-12', '526'),
('H123', 'G135', DATE'2021-01-01', DATE'2021-01-02', '526'),
('H123', 'G137', DATE'2022-02-08', DATE'2022-02-09', '512'),
('H121', 'G131', DATE'1999-04-21', DATE'1999-04-22', '508'),
('H121', 'G131', DATE'1999-04-23', DATE'1999-04-24', '527'),
('H120', 'G128', DATE'1999-01-01', DATE'1999-01-02', '501'),
('H121', 'G132', DATE'2021-04-24', DATE'2021-04-25', '506'),
('H120', 'G130', DATE'1999-02-11', DATE'1999-02-12', '503'),
('H125', 'G139', DATE'2022-02-18', DATE'2022-02-19', '528'),
('H111', 'G133', DATE'2021-08-26', DATE'2021-08-27', '504'),
('H122', 'G134', DATE'2022-08-29', DATE'2022-08-30', '509'),
('H120', 'G129', DATE'1999-01-05', DATE'1999-01-06', '502'),
('H123', 'G136', DATE'2022-02-04', NULL, '511'),
('H124', 'G138', DATE'2022-02-15', DATE'2022-02-16', '513'),
('H121', 'G133', DATE'2021-08-25', DATE'2021-08-26', '507'),
('H125', 'G140', DATE'2021-02-26', DATE'2021-02-27', '529');

                                               -- UPDATING THE TABLES

select * from room;
update room set price = price *1.05; 

CREATE TABLE booking_old (
hotel_no CHAR(4) NOT NULL,
guest_no CHAR(4) NOT NULL,
date_from DATETIME NOT NULL,
date_to DATETIME NULL, room_no VARCHAR(4) NOT NULL
);

-- seperating the old records from booking table and inserting it into a new table(booking_old)

INSERT INTO booking_old (SELECT * FROM booking WHERE date_to < DATE'2000-01-01'); 

DELETE FROM booking WHERE date_to < '2000-01-01';    

												 -- QUERIES

-- Simple Queries

-- 1. List full details of all hotels.

select * from hotel; 

-- 2. List full details of all hotels in London.

select * from hotel where address = 'London';

-- 3. List the names and addresses of all guests in London, alphabetically ordered by name.

select name, address from guest where address = 'London' order by name;

-- 4. List all double or family rooms with a price below £40.00 per night, in ascending order of price.

select room_no,type,price from room where type = 'Q' or type = 'D' having price < '40' order by price;

-- 5. List the bookings for which no date_to has been specified.

select * from booking where date_to is null;


-- Aggregate Functions

-- 1. How many hotels are there?

select count(name) as hotel_count from hotel; -- count keyword helps to get count of certain things 

-- 2. What is the average price of a room?

select avg(price) as avg_price from room;  -- avg keyword to get average

-- 3. What is the total revenue per night from all double rooms?

select sum(price) from room where type = 'D';  -- D means double room type
-- since the guest data has populated with diff of 1day b/w check in and check out so no need of further date calculation
-- if there is any case like this then we can consider the difference and calculate according to that

-- 4. How many different guests have made bookings for August?

select distinct g.name as guest_name from guest g  -- to make it very clear, going with inner join for 
inner join booking b on g.guest_no = b.guest_no  -- diff guest names instead of getting guest_no's  
where date_format(date_from,'%M') = 'August' ;   -- converting 8th month to august to find easily


-- Subqueries and Joins

-- 1. List the price and type of all rooms at the Grosvenor Hotel.

select r.type,r.price from room r 
inner join hotel h on r.hotel_no = h.hotel_no where name = 'Grosvenor Hotel' order by price;
-- There are 10 rooms available,some types at both lower and higher prices due to quality 
  
-- 2. List all guests currently staying at the Grosvenor Hotel.

select g.guest_no,g.name,g.address,h.name from booking b
inner join hotel h on b.hotel_no = h.hotel_no   -- Considering the guests still staying at hotel 
inner join guest g on b.guest_no = g.guest_no where b.date_to is null; -- where the checkout columns(date_to) aren't mentioned 
-- In above way we found where the guests are currently staying and found no grosvenor hotel  

-- In below way we directly found that there is no guests currently staying
select g.guest_no,g.name,g.address,h.name from booking b
inner join hotel h on b.hotel_no = h.hotel_no   
inner join guest g on b.guest_no = g.guest_no where h.name = 'Grosvenor Hotel' having b.date_to = '2022-06-28'; 

-- 3. List the details of all rooms at the Grosvenor Hotel, including the name of the guest staying in the
-- room, if the room is occupied.

select hotel_no from hotel where name = 'Grosvenor Hotel'; -- To know the hotel_no 

select g.name, r.room_no, r.hotel_no, r.type, r.price from booking b  -- By using hotel_no, no need to join hotel table 
inner join room r on b.room_no = r.room_no 
inner join guest g on b.guest_no = g.guest_no where b.hotel_no = 'H111';

-- only 4 occupied rooms in hotel 'Grosvenor'
  
-- 4. What is the total income from bookings for the Grosvenor Hotel today?

select sum(r.price) as total_income from room r 
inner join booking b on r.hotel_no = b.hotel_no 
inner join hotel h on h.hotel_no = r.hotel_no where h.name = 'Grosvenor Hotel' 
having (select date_from from booking where date_from = '2022-06-28');  

-- 5. List the rooms that are currently unoccupied at the Grosvenor Hotel.

select room_no from room where room_no not in (select room_no from booking); -- considering the unoccupied rooms as non booked
-- selecting the room_no's which doesn't exist in booking 

-- 6. What is the lost income from unoccupied rooms at the Grosvenor Hotel?

select sum(price) from room where room_no not in (select room_no from booking);
-- 838.95 will be the lost income per day 


-- Grouping

-- 1. List the number of rooms in each hotel.

select count(room_no) as rooms_count,hotel_no from room group by hotel_no; -- As stated using group by statement


-- 2. List the number of rooms in each hotel in London.

select count(r.room_no) as no_of_rooms, h.name, h.address  from room r 
inner join hotel h on r.hotel_no = h.hotel_no where h.address ='London' group by h.name;

-- 3. What is the average number of bookings for each hotel in August?

create or replace view group_bookings as select count(guest_no) as guest_count from booking 
where date_format(date_from,'%M') = 'August' group by hotel_no;
select * from group_bookings;
select avg(guest_count) from group_bookings;   -- using views just to make it simple

-- 4. What is the most commonly booked room type for each hotel in London?

create or replace view cbrt as select b.hotel_no, r.type from booking b -- cbrt means commonly booked room type
inner join room r on b.room_no = r.room_no 
where b.hotel_no in (select hotel_no from hotel where address = 'London'); -- using subquery
select * from cbrt order by hotel_no;  -- here there is only h111 hotel which room type is D  

-- 5. What is the lost income from unoccupied rooms at each hotel today?

select sum(r.price) from room r inner join hotel h on r.hotel_no = h.hotel_no
inner join booking b on r.room_no = b.room_no  -- same as previous section answer just added subquery of date_from
where r.room_no in (select room_no from booking where date_from = '2022-06-28');


-- Get the details of the room which generated highest revenue get the detail for hotel wise

select * from booking;
select b.hotel_no,b.room_no,sum(price) from room r
inner join booking b on r.hotel_no = b.hotel_no 
group by b.hotel_no order by b.hotel_no;

select b.hotel_no,r.room_no, sum(r.price) as totalrevenuegenerated from room r
inner join booking b on r.hotel_no = b.hotel_no group By b.room_no order by b.hotel_no;


