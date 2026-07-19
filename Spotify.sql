select * from users;
desc users;

select * from tracks;
DESC tracks;

select * from artists;
desc artists;


ALTER TABLE users
ADD COLUMN daily_listening_minutes INT;

UPDATE users
SET daily_listening_minutes =
    CAST(SUBSTRING_INDEX(daily_listening_time, 'h', 1) AS UNSIGNED) * 60 +
    CAST(
        REPLACE(
            TRIM(SUBSTRING_INDEX(daily_listening_time, 'h', -1)),
            'm',
            ''
        ) AS UNSIGNED
    );

alter table users 
modify column first_name varchar(20),
modify column last_name varchar(20),
modify column signup_date date,
modify column daily_streams int;


-- KPIs --


-- Total Streams --
CREATE VIEW Total_Streams as 
select sum(daily_streams) as Total_Streams
from Users;

-- average listening time --
CREATE VIEW Avg_Listenting_Time AS
select round(sum(daily_listening_minutes) / count(distinct user_id),2) as avg_listening_time
from users ;

-- most popular artist --
CREATE VIEW Most_Popular_Artist AS
WITH all_artists as (select distinct t.artist_id, a.artist_name, t.track_name, 
sum(t.play_count) as total_play_count,
SUM(SUM(t.play_count)) OVER (PARTITION BY t.artist_id) AS total_artist_play_count
from tracks as t
join artists as a
on t.artist_id = a.artist_id
group by t.artist_id, a.artist_name, t.track_name
order by t.artist_id)
select distinct artist_name
from all_artists
where total_artist_play_count = (select max(total_artist_play_count) from all_artists);

-- Total Unique Tracks --
CREATE VIEW Total_Unique_Tracks as 
select count(distinct track_id) as total_unique_tracks
from tracks;


-- Trends --


-- Month Over Month Stream Growth -- 
CREATE VIEW Month_over_Month_Growth as 
With Monthly_streams AS(Select month(activity_date) as month_number,
monthname(activity_date) as `Month`, sum(daily_streams) as current_month_streams
from users
group by month(activity_date), monthname(activity_date)),
previous_month AS(select *, lag(current_month_streams) over() as previous_month_streams
from Monthly_streams)
select *, (current_month_streams - previous_month_streams) as growth
from previous_month;

-- Top 5 States With Most Streams --
CREATE VIEW Top_5_Geolocations AS 
with playCount as(select user_id, sum(play_count) AS user_total_play_count
from tracks
group by user_id),
unique_users as(select distinct user_id, state
from users)
select distinct u.state,
sum(p.user_total_play_count) over(partition by state) as state_total_play_count
from playCount as p
join unique_users as u
on p.user_id = u.user_id
order by state_total_play_count DESC
limit 5;

-- Total Streaming Minutes for each Day -- 
CREATE VIEW Total_Streaming_Minutes AS
select 
case 
	when day_name = 'Monday' then 1
    when day_name = 'Tuesday' then 2
    when day_name = 'Wednesday' then 3
	when day_name = 'Thursday' then 4
    when day_name = 'Friday' then 5
    when day_name = 'Saturday' then 6
    when day_name = 'Sunday' then 7
end as day_number,
day_name, sum(daily_listening_minutes) as total_minutes
from users
group by day_name
order by day_number;

-- Top 5 People with Highest Average listening time --
CREATE VIEW Ranked_People AS
WITH listening_time AS(select user_id, first_name, round(avg(daily_listening_minutes),2) as avg_listening_time
from users
group by user_id, first_name),
Ranking AS(select *, dense_rank() over(order by avg_listening_time DESC) as rk
from listening_time
)
select user_id, first_name, avg_listening_time
from Ranking
where rk <= 5;

-- Subscription Distribution --
CREATE VIEW Subscription_Distribution AS 
select 
round(count(case when subscription = 'free' then subscription end) * 100/count(subscription),2) as Free_Sub,
round(count(case when subscription = 'premium' then subscription end) * 100/count(subscription),2) as premium_Sub,
round(count(case when subscription = 'family' then subscription end) * 100/count(subscription),2) as family_Sub,
round(count(case when subscription = 'student' then subscription end) * 100/count(subscription),2) as student_Sub
from users;

-- Top 5 Most Played Tracks --
CREATE VIEW Top_5_Most_Played_Tracks AS
select track_id, track_name, sum(play_count) as total_times_track_played
from tracks 
group by track_id, track_name
order by total_times_track_played DESC;

-- Top 5 most popular genre -- 
CREATE VIEW Top_5_Most_Popular_Genre AS 
select distinct genre,
sum(play_count) over(partition by genre) as genre_play_count
from tracks
order by genre_play_count DESC
limit 5;
