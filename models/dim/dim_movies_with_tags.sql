{{ config(materialized = 'ephemeral') }}

WITH movies AS(
    SELECT * FROM {{ ref('dim_movies') }}
),
tags AS(
    SELECT * FROM {{ ref('dim_genome_tags') }}
),
scores AS(
    SELECT * FROM {{ ref('fct_genome_scores') }}
)
SELECT
    m.movie_id,
    m.movie_title,
    m.genres,
    t.tag_id,
    t.tag,
    s.relevance_score
FROM movies m
LEFT JOIN scores s
    ON m.movie_id = s.movie_id
LEFT JOIN tags t
    ON s.tag_id = t.tag_id
