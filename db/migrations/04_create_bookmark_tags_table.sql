CREATE TABLE bookmark_tags(
    id SERIAL PRIMARY KEY,
    bookmark_id INTEGER REFERENCES bookmarks(id) ON DELETE CASCADE,
    tag_id INTEGER REFERENCES tags(id) ON DELETE CASCADE
);