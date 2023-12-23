-- Users Tables
CREATE TABLE users(
    id SERIAL NOT NULL,
    name VARCHAR(50) NOT NULL,
    password VARCHAR(250) NOT NULL,
    created_at date NOT NULL,
    email VARCHAR(250) NOT NULL,
    PRIMARY KEY(id)
);

CREATE UNIQUE INDEX user_email_index ON "users" USING btree ("email");

CREATE TABLE creators(
    user_id integer NOT NULL,
    channel_count integer NOT NULL DEFAULT 0,
    country VARCHAR(4) NOT NULL DEFAULT 'KSA',
    PRIMARY KEY(user_id),
    CONSTRAINT creators_user_id_fkey FOREIGN key(user_id) REFERENCES users(id)
);

CREATE TABLE viewers(
    user_id integer NOT NULL,
    date_of_birth date NOT NULL,
    PRIMARY KEY(user_id),
    CONSTRAINT viewers_user_id_fkey FOREIGN key(user_id) REFERENCES users(id)
);

-- Channel Tables
CREATE TABLE channels(
    id SERIAL NOT NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    avatar_url VARCHAR(250),
    subscribers_count integer NOT NULL DEFAULT 0,
    created_at date NOT NULL,
    creator_uid integer NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT channels_creator_uid_fkey FOREIGN key(creator_uid) REFERENCES creators(user_id)
);

CREATE UNIQUE INDEX channels_name_key ON "channels" USING btree ("name");

CREATE TABLE subscriptions(
    channel_id integer NOT NULL,
    viewer_uid integer NOT NULL,
    PRIMARY KEY(channel_id,viewer_uid),
    CONSTRAINT subscriptions_channel_id_fkey FOREIGN key(channel_id) REFERENCES channels(id),
    CONSTRAINT subscriptions_viewer_uid_fkey FOREIGN key(viewer_uid) REFERENCES viewers(user_id)
);

-- Video Tables
CREATE TABLE videos(
    id SERIAL NOT NULL,
    url VARCHAR(250) NOT NULL,
    title VARCHAR(250) NOT NULL,
    description VARCHAR(500),
    genre VARCHAR(15),
    published_at date NOT NULL,
    channel_id integer NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT videos_channel_id_fkey FOREIGN key(channel_id) REFERENCES channels(id)
);

CREATE UNIQUE INDEX videos_url_key ON "videos" USING btree ("url");

CREATE TABLE views(
    video_id integer NOT NULL,
    viewer_uid integer NOT NULL,
    PRIMARY KEY(video_id,viewer_uid),
    CONSTRAINT views_video_id_fkey FOREIGN key(video_id) REFERENCES videos(id),
    CONSTRAINT views_viewer_uid_fkey FOREIGN key(viewer_uid) REFERENCES viewers(user_id)
);

CREATE TABLE impressions(
    video_id integer NOT NULL,
    viewer_uid integer NOT NULL,
    date_time date NOT NULL,
    liked boolean,
    disliked boolean,
    comment VARCHAR(500),
    PRIMARY KEY(video_id,viewer_uid,date_time),
    CONSTRAINT impressions_video_id_fkey FOREIGN key(video_id) REFERENCES videos(id),
    CONSTRAINT impressions_viewer_uid_fkey FOREIGN key(viewer_uid) REFERENCES viewers(user_id)
);