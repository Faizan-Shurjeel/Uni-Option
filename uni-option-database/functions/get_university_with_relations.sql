CREATE OR REPLACE FUNCTION get_university_with_relations(university_id UUID)
RETURNS TABLE (
    university_id UUID,
    university_name TEXT,
    university_description TEXT,
    university_image_url TEXT,
    university_address TEXT,
    university_latitude FLOAT8,
    university_longitude FLOAT8,
    university_website TEXT,
    university_phone_number TEXT,
    university_email TEXT,
    university_eligibility_criteria TEXT,
    university_type TEXT,
    degrees JSONB,
    application_steps JSONB,
    programs JSONB
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        u.id AS university_id,
        u.name AS university_name,
        u.description AS university_description,
        u.imageUrl AS university_image_url,
        u.address AS university_address,
        u.latitude AS university_latitude,
        u.longitude AS university_longitude,
        u.website AS university_website,
        u.phoneNumber AS university_phone_number,
        u.email AS university_email,
        u.eligibilityCriteria AS university_eligibility_criteria,
        u.type AS university_type,
        (SELECT jsonb_agg(d) FROM degrees d WHERE d.university_id = u.id) AS degrees,
        (SELECT jsonb_agg(a) FROM application_steps a WHERE a.university_id = u.id) AS application_steps,
        (SELECT jsonb_agg(p) FROM programs p WHERE p.university_id = u.id) AS programs
    FROM universities u
    WHERE u.id = university_id;
END;
$$ LANGUAGE plpgsql;