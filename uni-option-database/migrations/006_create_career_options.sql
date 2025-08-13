CREATE TABLE career_options (
    id SERIAL PRIMARY KEY,
    degree_id INT NOT NULL,
    career_option VARCHAR(255) NOT NULL,
    FOREIGN KEY (degree_id) REFERENCES degrees(id) ON DELETE CASCADE
);