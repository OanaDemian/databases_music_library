-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS albums_id_seq;

-- Table Definition
CREATE TABLE "public"."albums" (
    "id" SERIAL,
    "title" text,
    "release_year" int,
    "artist_id" int,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."artists";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS artists_id_seq;

-- Table Definition
CREATE TABLE "public"."artists" (
    "id" SERIAL,
    "name" text,
    "genre" text,
    PRIMARY KEY ("id")
);
