CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    text VARCHAR(200),
    bookmark_id INTEGER REFERENCES bookmarks(id) ON DELETE CASCADE
);