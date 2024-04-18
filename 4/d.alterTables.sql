-- hasGenre
ALTER TABLE hasGenre
ADD CONSTRAINT hasgenre_pk PRIMARY KEY (movie_id, genre_id);

-- hasKeyword
ALTER TABLE haskeyword
ADD CONSTRAINT hashkeyword_pk PRIMARY KEY (movie_id, keyword_id);

-- belongsTocollection
ALTER TABLE belongsTocollection
ADD CONSTRAINT belongsTocollection_pk PRIMARY KEY (movie_id, collection_id);

-- hasProductioncompany
ALTER TABLE hasProductioncompany
ADD CONSTRAINT hasProductioncompany_pk PRIMARY KEY (movie_id, pc_id);

-- ratings
ALTER TABLE ratings
ADD CONSTRAINT ratings_pk PRIMARY KEY (movie_id, user_id);

