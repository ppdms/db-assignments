-- hasGenre
ALTER TABLE hasGenre
ADD CONSTRAINT FK_movieid_hasgenre FOREIGN KEY (movie_id) REFERENCES movie(id);

ALTER TABLE hasGenre
ADD CONSTRAINT FK_genreid_hasgenre FOREIGN KEY (genre_id) REFERENCES genre(id);

-- hasKeyword
ALTER TABLE haskeyword
ADD CONSTRAINT FK_movieid_hashkeyword FOREIGN KEY (movie_id) REFERENCES movie(id);

ALTER TABLE haskeyword
ADD CONSTRAINT FK_keywordid_hashkeyword FOREIGN KEY (keyword_id) REFERENCES Keyword(id);

-- belongsTocollection
ALTER TABLE belongsTocollection
ADD CONSTRAINT FK_movieid_belongsTocollection FOREIGN KEY (movie_id) REFERENCES movie(id);

ALTER TABLE belongsTocollection
ADD CONSTRAINT FK_collectionid_belongsTocollection FOREIGN KEY (collection_id) REFERENCES collection(id);


-- hasProductioncompany
ALTER TABLE hasProductioncompany
ADD CONSTRAINT FK_movieid_hasProductioncompany FOREIGN KEY (movie_id) REFERENCES movie(id);

ALTER TABLE hasProductioncompany
ADD CONSTRAINT FK_pcid_hasProductioncompany FOREIGN KEY (pc_id) REFERENCES productioncompany(id);

-- ratings
ALTER TABLE ratings
ADD CONSTRAINT FK_movieid FOREIGN KEY (movie_id) REFERENCES movie(id);
