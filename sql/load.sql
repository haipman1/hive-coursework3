CREATE DATABASE IF NOT EXISTS coursework;

CREATE EXTERNAL TABLE IF NOT EXISTS coursework.events (
    event_id INT,
    service STRING,
    message STRING
)
PARTITIONED BY (event_date STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/opt/hive/data/warehouse/coursework_events';

LOAD DATA LOCAL INPATH '/opt/hive/data/input/events_2026-10-22.csv'
OVERWRITE INTO TABLE coursework.events
PARTITION (event_date='2026-10-22');

LOAD DATA LOCAL INPATH '/opt/hive/data/input/events_2026-10-23.csv'
OVERWRITE INTO TABLE coursework.events
PARTITION (event_date='2026-10-23');
