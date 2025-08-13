CREATE TABLE requirements (
    id SERIAL PRIMARY KEY,
    degree_id INT NOT NULL,
    requirement TEXT NOT NULL,
    FOREIGN KEY (degree_id) REFERENCES degrees(id) ON DELETE CASCADE
);