import '../models/university.dart';
import '../models/degree.dart';
import '../models/application_step.dart';

List<University> getUniversitiesData() {
  return [
    University(
      id: '1',
      name: 'FAST NUCES Lahore',
      description:
          'A leading private research university specializing in computer science and emerging technologies with multiple campuses across Pakistan.',
      imageUrl: 'assets/images/university1.png',
      address: '852-B, Block B, Faisal Town, Lahore, 54000, Pakistan',
      latitude: 31.4800,
      longitude: 74.3200,
      website: 'https://lhr.nu.edu.pk/',
      phoneNumber: '(042) 111 128 128',
      email: 'admissions.lhr@nu.edu.pk',
      eligibilityCriteria:
          'Intermediate with at least 70% marks, Mathematics as a mandatory subject, and passing the university’s entrance test.',
      type: 'Private',
      degrees: [
        Degree(
          id: '101',
          name: 'Computer Science',
          description:
              'Bachelor of Science in Computer Science covering programming, algorithms, databases, and software engineering principles.',
          duration: 4,
          requirements: [
            'Intermediate pre-medical or pre-engineering with minimum 70% marks',
            'Mathematics as a major subject',
            'Pass entrance test and interview',
          ],
          careerOptions: [
            'Software Engineer',
            'Data Scientist',
            'AI Specialist',
            'Researcher',
          ],
          fee: 250000,
        ),
        Degree(
          id: '102',
          name: 'Software Engineering',
          description:
              'Bachelor of Engineering focused on software design, development lifecycle, and project management.',
          duration: 4,
          requirements: [
            'Intermediate with minimum 70% marks',
            'Mathematics as a major subject',
            'Pass entrance test and interview',
          ],
          careerOptions: [
            'Software Developer',
            'System Analyst',
            'Quality Assurance Engineer',
            'Project Manager',
          ],
          fee: 240000,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Online Registration',
          description:
              'Fill out the online application form on the official website.',
          deadline: DateTime(2023, 8, 15),
        ),
        ApplicationStep(
          title: 'Entrance Test',
          description:
              'Appear for the university’s entrance examination held nationwide.',
          deadline: DateTime(2023, 9, 1),
        ),
        ApplicationStep(
          title: 'Interview',
          description:
              'Shortlisted candidates are called for an interview before final admission decisions.',
          deadline: DateTime(2023, 9, 15),
        ),
      ],
      programs: ['Computer Science', 'Software Engineering', 'Data Science'],
    ),
    University(
      id: '2',
      name: 'University of the Punjab, Lahore',
      description:
          'The oldest and largest public sector university in Punjab, offering diverse programs in arts, sciences, and professional fields.',
      imageUrl: 'assets/images/university2.png',
      address: 'Quaid-i-Azam Campus, Canal Road, Lahore, 54590, Pakistan',
      latitude: 31.5204,
      longitude: 74.3587,
      website: 'https://www.pu.edu.pk/',
      phoneNumber: '+92 (42) 99231461-99231470',
      email: 'contact@pu.edu.pk',
      eligibilityCriteria:
          'Minimum 70% marks in intermediate with passing relevant admission test and interview performance as required by the program.',
      type: 'Public',
      degrees: [
        Degree(
          id: '201',
          name: 'Business Administration',
          description:
              'Bachelor of Business Administration covering management, marketing, finance, and organizational behavior.',
          duration: 4,
          requirements: [
            'Intermediate with 70% marks',
            'Pass business aptitude test',
            'Interview clearance',
          ],
          careerOptions: [
            'Business Manager',
            'Marketing Executive',
            'Entrepreneur',
            'Financial Analyst',
          ],
          fee: 300000,
        ),
        Degree(
          id: '202',
          name: 'Finance',
          description:
              'Bachelor of Science in Finance focusing on financial analysis, investment strategies, and banking management.',
          duration: 4,
          requirements: [
            'Intermediate with 75% marks',
            'Mathematics as a subject',
            'Pass entrance test',
          ],
          careerOptions: [
            'Financial Analyst',
            'Investment Banker',
            'Portfolio Manager',
            'Bank Manager',
          ],
          fee: 320000,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Application Submission',
          description:
              'Submit application forms with necessary academic documents before deadline.',
          deadline: DateTime(2023, 7, 30),
        ),
        ApplicationStep(
          title: 'Admission Test',
          description: 'Appear for the program-specific admission test.',
          deadline: DateTime(2023, 8, 20),
        ),
        ApplicationStep(
          title: 'Personal Interview',
          description: 'Attend admission panel interview for final selection.',
          deadline: DateTime(2023, 9, 5),
        ),
      ],
      programs: [
        'Business Administration',
        'Finance',
        'Marketing',
        'Accounting',
      ],
    ),
    University(
      id: '3',
      name: 'University of Health Sciences Lahore',
      description:
          'A premier public university specializing in medical education, health sciences, and research.',
      imageUrl: 'assets/images/university3.jpg',
      address:
          'Khayaban-e-Jamia Punjab, Block D Muslim Town, Lahore, 54600, Pakistan',
      latitude: 31.4600,
      longitude: 74.3200,
      website: 'https://www.uhs.edu.pk/',
      phoneNumber: '+92 42 99231061-70',
      email: 'admissions@uhs.edu.pk',
      eligibilityCriteria:
          'Minimum 85% marks in intermediate (Pre-Medical) with Biology and Chemistry, MCAT qualification, and interview clearance.',
      type: 'Public',
      degrees: [
        Degree(
          id: '301',
          name: 'Medicine (MBBS)',
          description:
              'Bachelor of Medicine and Bachelor of Surgery program preparing students for clinical and research careers.',
          duration: 5,
          requirements: [
            'Intermediate Pre-Medical with minimum 85% marks',
            'Biology and Chemistry as major subjects',
            'MCAT qualification',
            'Interview clearance',
          ],
          careerOptions: [
            'Physician',
            'Surgeon',
            'Medical Researcher',
            'Clinical Specialist',
          ],
          fee: 500000,
        ),
        Degree(
          id: '302',
          name: 'Dentistry (BDS)',
          description:
              'Bachelor of Dental Surgery program for preparing dental practitioners.',
          duration: 4,
          requirements: [
            'Intermediate Pre-Medical with minimum 80% marks',
            'Biology and Chemistry as major subjects',
            'Pass entrance test',
          ],
          careerOptions: [
            'Dentist',
            'Orthodontist',
            'Oral Surgeon',
          ],
          fee: 450000,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'MCAT Registration',
          description: 'Register and take the Medical College Admission Test.',
          deadline: DateTime(2023, 6, 30),
        ),
        ApplicationStep(
          title: 'Application Submission',
          description:
              'Submit application with MCAT scores and academic documents.',
          deadline: DateTime(2023, 7, 15),
        ),
        ApplicationStep(
          title: 'Interview and Selection',
          description:
              'Shortlisted candidates undergo interview and final selection.',
          deadline: DateTime(2023, 8, 10),
        ),
      ],
      programs: ['Medicine', 'Dentistry', 'Pharmacy', 'Nursing'],
    ),
  ];
}
