-- 1 - Write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name,
-- last name and role.

select * from movie where mov_title = "Annie hall";  -- Finding the mov_id which is common in both movie and movie cast
																	 -- using alias to make the code look short & crisp
select a.act_fname ,a.act_lname, mc.role from actors as a inner join -- Getting required data using mov_id  
movie_cast as mc on a.act_id = mc.act_id where mov_id= "911";        -- inner joining the tables using act_id 

-- 2 - From the following tables, write a SQL query to find the director who directed a movie that 
-- casted a role for 'Eyes Wide Shut'. Return director first name, last name and movie title.

-- Need dir_id,mov_id to get dir,movie name but movie,movie_direction,director are not interlinked with one column
-- mov_id,dir_id are available in respective tables movie and director whereas movie_direction contains both 

-- step by step procedure

select mov_id from movie where mov_title = 'Eyes Wide Shut'; -- found mov_id = 907
select dir_id from movie_direction where mov_id = 907;   -- found dir_id = 207
select d.dir_fname ,d.dir_lname,m.mov_title from director as d, movie as m  -- Getting the desired result 
where dir_id = 207 having mov_title = 'Eyes Wide Shut'; -- using dir_id and mov_title

-- Getting in oneshot 

select d.dir_fname ,d.dir_lname,m.mov_title from director as d 
inner join movie_direction as md on d.dir_id = md.dir_id  -- in order to get result,innerjoining the 3 required tables  
inner join movie as m on md.mov_id = m.mov_id where mov_title = 'Eyes Wide Shut'; -- filtering with the film name

-- 3 - Write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’. Return director 
-- first name, last name and movie title.

-- same as previous solution adding one more table(movie_cast) to get the required output.
 
select d.dir_fname ,d.dir_lname,m.mov_title from director as d 
inner join movie_direction as md on d.dir_id = md.dir_id  -- in order to get result,innerjoining the 3 required tables  
inner join movie as m on md.mov_id = m.mov_id 
inner join movie_cast as mc on m.mov_id = mc.mov_id where role = 'Sean Maguire'; -- filtering with the role name

-- 4 - Write a SQL query to find the actors who have not acted in any movie between 1990 and 2000 
-- (Begin and end values are included.). Return actor first name, last name, movie title and release year.

-- same as previous solution, here we found that who acted in non mentioned range(Not acted in mentioned range)
select a.act_fname, a.act_lname, m.mov_title, date_format(m.mov_dt_rel,'%Y') as release_year from movie as m 
inner join movie_cast as mc on m.mov_id = mc.mov_id inner join actors as a on mc.act_id = a.act_id 
where mov_dt_rel not between '1989-12-31' and '2001-01-01'; -- to be more accurate entering one day before and after dates 

-- 5 - Write a SQL query to find the directors with the number of genres of movies. Group 
-- the result set on director first name, last name and generic title. Sort the result-set in 
-- ascending order by director first name and last name. Return director first name,
-- last name and number of genres of movies.

select d.dir_fname,d.dir_lname,count(mg.mov_id) 
as number_of_gen_mov from director as d 
inner join movie_direction as md on d.dir_id = md.dir_id -- inner joining all the required tables and grouping with gen_id
inner join movie_genres as mg on md.mov_id = mg.mov_id
group by mg.gen_id order by concat(d.dir_fname,d.dir_lname);    -- gen_id represents unique genre so counting gen_id 

-- 6 - Write a SQL query to find the movies with year and genres. Return movie title, movie year and generic title.

select m.mov_title,m.mov_year,g.gen_title from movie as m -- as simple as that,just innerjoining 
inner join movie_genres as mg on m.mov_id = mg.mov_id -- and getting all those required columns 
inner join genres as g on mg.gen_id = g.gen_id;

-- 7 - Write a SQL query to find the movies released before 1st January 1989. Sort the 
-- result-set in descending order by date of release. Return movie title, release year,
-- date of release, duration, and first and last name of the director.

select m.mov_title, date_format(m.mov_dt_rel,'%Y') as release_year,m.mov_dt_rel,m.mov_time as duration, d.dir_fname,d.dir_lname from movie as m 
inner join movie_direction as md on m.mov_id = md.mov_id -- sorting by release year(by default it's ascending order) 
inner join director as d on md.dir_id = d.dir_id where mov_dt_rel < '1989-01-01' order by mov_dt_rel; -- using where clause to filter 

-- 8 - Write a SQL query to compute the average time and count the number of movies for each genre.
-- Return genre title, average time and the number of movies for each genre.

select g.gen_title,avg(m.mov_time) as avg_time,count(m.mov_id) as nomoeg from genres as g  -- nomoeg means no of movies of each genre
inner join movie_genres as mg on g.gen_id = mg.gen_id 
inner join movie as m on mg.mov_id = m.mov_id group by g.gen_id; --  grouping with gen_id and counting the movies
 
-- 9 - Write a SQL query to find movies with the lowest duration. Return movie title, movie year,
-- director first name, last name, actor first name, last name and role.

-- in this below way we can find movies with lowest duration to high, we can consider the top 

select m.mov_title,m.mov_year,d.dir_fname,d.dir_lname,a.act_fname,a.act_lname,mc.role from movie m 
inner join movie_cast mc on m.mov_id = mc.mov_id
inner join actors a on mc.act_id = a.act_id    -- inner joining all the required tables
inner join movie_direction md on m.mov_id = md.mov_id
inner join director d on md.dir_id = d.dir_id order by m.mov_time desc;  -- sorting in descending order

-- in this below code, I'm considering the lowest duration films
-- which are lower duration than average duration   

select m.mov_title,m.mov_year,d.dir_fname,d.dir_lname,a.act_fname,a.act_lname,mc.role,m.mov_time from movie m 
inner join movie_cast mc on m.mov_id = mc.mov_id
inner join actors a on mc.act_id = a.act_id    -- inner joining all the required tables
inner join movie_direction md on m.mov_id = md.mov_id
inner join director d on md.dir_id = d.dir_id  -- selecting avg of total duration(mov_time) and
where m.mov_time < (select avg(mov_time) from movie) order by mov_time; -- comparing it with each duration
