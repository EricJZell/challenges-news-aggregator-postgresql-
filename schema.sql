DROP TABLE IF EXISTS articles;

CREATE TABLE articles (title varchar(255), url varchar(255), description varchar(1023));
CREATE UNIQUE INDEX url ON articles (url);
