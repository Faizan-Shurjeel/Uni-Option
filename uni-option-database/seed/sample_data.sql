INSERT INTO universities (id, name, description, imageUrl, address, latitude, longitude, website, phoneNumber, email, eligibilityCriteria, type) VALUES
('1', 'National University of Computer Science', 'A leading institution specializing in computer science and information technology education.', 'assets/images/university1.png', '123 Tech Avenue, Silicon Valley, CA', 37.7749, -122.4194, 'https://www.nucs.edu', '+1 (555) 123-4567', 'admissions@nucs.edu', 'Minimum 80% in intermediate with Mathematics and Physics as mandatory subjects.', 'Public'),
('2', 'Metropolitan Business School', 'A prestigious business school offering programs in business administration, marketing, and finance.', 'assets/images/university2.png', '456 Business Park, Financial District, NY', 40.7128, -74.0060, 'https://www.metrobusiness.edu', '+1 (555) 987-6543', 'info@metrobusiness.edu', 'Minimum 70% in intermediate, qualification in admission test, and interview performance.', 'Private'),
('3', 'Medical Sciences University', 'A renowned institution for medical education and healthcare studies.', 'assets/images/university3.jpg', '789 Healthcare Blvd, Boston, MA', 42.3601, -71.0589, 'https://www.medicalsciences.edu', '+1 (555) 321-9876', 'admissions@medicalsciences.edu', 'Minimum 85% in intermediate with Biology and Chemistry as mandatory subjects. MCAT qualification required.', 'Public');

INSERT INTO degrees (id, university_id, name, description, duration, fee) VALUES
('101', '1', 'Computer Science', 'Bachelor of Science in Computer Science covering programming, algorithms, databases, and more.', 4, 250000),
('102', '1', 'Software Engineering', 'Bachelor of Engineering in Software focusing on software development lifecycle.', 4, 240000),
('201', '2', 'Business Administration', 'Bachelor of Business Administration covering management, marketing, and finance.', 4, 300000),
('202', '2', 'Finance', 'Bachelor of Science in Finance focusing on financial analysis and investment strategies.', 4, 320000),
('301', '3', 'Medicine', 'Bachelor of Medicine and Surgery (MBBS) program preparing doctors.', 5, 500000),
('302', '3', 'Dentistry', 'Bachelor of Dental Surgery program for aspiring dentists.', 4, 450000);

INSERT INTO application_steps (id, university_id, title, description, deadline) VALUES
('1', '1', 'Online Registration', 'Fill out the online application form on our website.', '2023-08-15'),
('2', '1', 'Entrance Test', 'Appear for the entrance examination at designated centers.', '2023-09-01'),
('3', '1', 'Interview', 'Shortlisted candidates will be called for an interview.', '2023-09-15'),
('4', '2', 'Application Submission', 'Submit your application with necessary documents.', '2023-07-30'),
('5', '2', 'Admission Test', 'Take the business aptitude test.', '2023-08-20'),
('6', '2', 'Personal Interview', 'Face-to-face interview with admission panel.', '2023-09-05'),
('7', '3', 'MCAT Registration', 'Register and take the Medical College Admission Test.', '2023-06-30'),
('8', '3', 'Application Submission', 'Submit your application with MCAT scores and academic records.', '2023-07-15'),
('9', '3', 'Interview and Selection', 'Shortlisted candidates will undergo interview and final selection.', '2023-08-10');

INSERT INTO programs (id, university_id, name) VALUES
('1', '1', 'Computer Science'),
('2', '1', 'Software Engineering'),
('3', '1', 'Data Science'),
('4', '2', 'Business Administration'),
('5', '2', 'Finance'),
('6', '2', 'Marketing'),
('7', '2', 'Accounting'),
('8', '3', 'Medicine'),
('9', '3', 'Dentistry'),
('10', '3', 'Pharmacy'),
('11', '3', 'Nursing');

INSERT INTO requirements (id, degree_id, requirement) VALUES
('1', '101', 'Intermediate with 80% marks'),
('2', '101', 'Mathematics as a major subject'),
('3', '101', 'Entrance test qualification'),
('4', '102', 'Intermediate with 75% marks'),
('5', '102', 'Mathematics as a major subject'),
('6', '102', 'Entrance test qualification'),
('7', '201', 'Intermediate with 70% marks'),
('8', '201', 'Entrance test qualification'),
('9', '201', 'Interview clearance'),
('10', '202', 'Intermediate with 75% marks'),
('11', '202', 'Mathematics as a subject'),
('12', '202', 'Entrance test qualification'),
('13', '301', 'Intermediate with 85% marks'),
('14', '301', 'Biology and Chemistry as major subjects'),
('15', '301', 'MCAT qualification'),
('16', '301', 'Interview clearance'),
('17', '302', 'Intermediate with 80% marks'),
('18', '302', 'Biology and Chemistry as major subjects'),
('19', '302', 'Entrance test qualification');

INSERT INTO career_options (id, degree_id, career_option) VALUES
('1', '101', 'Software Engineer'),
('2', '101', 'Data Scientist'),
('3', '101', 'AI Specialist'),
('4', '102', 'Software Developer'),
('5', '102', 'System Analyst'),
('6', '102', 'QA Engineer'),
('7', '201', 'Business Manager'),
('8', '201', 'Marketing Executive'),
('9', '201', 'Entrepreneur'),
('10', '202', 'Financial Analyst'),
('11', '202', 'Investment Banker'),
('12', '202', 'Portfolio Manager'),
('13', '301', 'Physician'),
('14', '301', 'Surgeon'),
('15', '301', 'Medical Researcher'),
('16', '302', 'Dentist'),
('17', '302', 'Orthodontist'),
('18', '302', 'Oral Surgeon');