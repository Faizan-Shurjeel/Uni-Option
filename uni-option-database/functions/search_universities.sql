CREATE OR REPLACE FUNCTION search_universities(search_term TEXT)
RETURNS TABLE (
    id UUID,
    name TEXT,
    description TEXT,
    imageUrl TEXT,
    address TEXT,
    latitude FLOAT,
    longitude FLOAT,
    website TEXT,
    phoneNumber TEXT,
    email TEXT,
    eligibilityCriteria TEXT,
    type TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT u.id, u.name, u.description, u.imageUrl, u.address, u.latitude, u.longitude, u.website, u.phoneNumber, u.email, u.eligibilityCriteria, u.type
    FROM universities u
    WHERE LOWER(u.name) LIKE LOWER('%' || search_term || '%')
       OR LOWER(u.description) LIKE LOWER('%' || search_term || '%')
       OR LOWER(u.address) LIKE LOWER('%' || search_term || '%');
END;
$$ LANGUAGE plpgsql;