CREATE TABLE universities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    imageUrl VARCHAR(255),
    address VARCHAR(255),
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6),
    website VARCHAR(255),
    phoneNumber VARCHAR(20),
    email VARCHAR(255),
    eligibilityCriteria TEXT,
    type VARCHAR(50) CHECK (type IN ('Public', 'Private'))
);