/*DATABASE EXCERCISE 2*/
-----------
--dbo.ratings:

ALTER TABLE ratings
ADD CONSTRAINT FK_movieid FOREIGN KEY (movie_id) REFERENCES movie(id);
-----------
--dbo.genre:

ALTER TABLE genre 
ADD CONSTRAINT genre_pk
PRIMARY KEY (id);
-----------
--dbo.collection:

ALTER TABLE collection 
ADD CONSTRAINT collection_pk
PRIMARY KEY (id);
-----------
--dbo.hasGenre:

ALTER TABLE hasGenre
ADD CONSTRAINT FK_movieid_hasgenre FOREIGN KEY (movie_id) REFERENCES movie(id);

ALTER TABLE hasGenre
ADD CONSTRAINT FK_genreid_hasgenre FOREIGN KEY (genre_id) REFERENCES genre(id);
-----------
--dbo.hasProductioncompany:

ALTER TABLE hasProductioncompany
ADD CONSTRAINT FK_movieid_hasProductioncompany FOREIGN KEY (movie_id) REFERENCES movie(id);

ALTER TABLE hasProductioncompany
ADD CONSTRAINT FK_pcid_hasProductioncompany FOREIGN KEY (pc_id) REFERENCES productioncompany(id);
-----------
--dbo.movie:

ALTER TABLE movie 
ADD CONSTRAINT movie_pk
PRIMARY KEY (id);
-----------
--dbo.movie_crew:

ALTER TABLE movie_crew 
ADD CONSTRAINT movie_crew_pk
PRIMARY KEY (cid);

ALTER TABLE movie_crew
ADD CONSTRAINT FK_movieid_movie_crew FOREIGN KEY (movie_id) REFERENCES movie(id);
-----------
--dbo.movie_cast:

ALTER TABLE movie_cast 
ADD CONSTRAINT movie_cast_pk
PRIMARY KEY (cid);

ALTER TABLE movie_cast
ADD CONSTRAINT FK_movieid_movie_cast FOREIGN KEY (movie_id) REFERENCES movie(id);
-----------
--dbo.productioncompany:

ALTER TABLE productioncompany 
ADD CONSTRAINT productioncompany_pk
PRIMARY KEY (id);
-----------
--dbo.belongsTocollection:

ALTER TABLE belongsTocollection
ADD CONSTRAINT FK_movieid_belongsTocollection FOREIGN KEY (movie_id) REFERENCES movie(id);

ALTER TABLE belongsTocollection
ADD CONSTRAINT FK_collectionid_belongsTocollection FOREIGN KEY (collection_id) REFERENCES collection(id);
-----------
--dbo.productioncompany:

ALTER TABLE productioncompany 
ADD CONSTRAINT productioncompany_pk
PRIMARY KEY (id);
-----------
--dbo.Keyword:

ALTER TABLE Keyword 
ADD CONSTRAINT Keyword_pk
PRIMARY KEY (id);
-----------
--dbo.haskeyword:

ALTER TABLE haskeyword
ADD CONSTRAINT FK_movieid_hashkeyword FOREIGN KEY (movie_id) REFERENCES movie(id);

ALTER TABLE haskeyword
ADD CONSTRAINT FK_keywordid_hashkeyword FOREIGN KEY (keyword_id) REFERENCES Keyword(id);