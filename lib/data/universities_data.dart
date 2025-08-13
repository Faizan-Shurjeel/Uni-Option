import '../models/university.dart';
import '../models/degree.dart';
import '../models/application_step.dart';

List<University> getUniversitiesData() {
  return [
    University(
      id: '1',
      name: 'FAST NUCES Lahore',
      description:
          'A leading institution specializing in computer science and information technology education.',
      imageUrl: 'assets/images/university1.png',
      address: '852-B Milaad St, Block B Faisal Town, Lahore, 54770, Pakistan',
      latitude: 37.7749,
      longitude: -122.4194,
      website: 'https://lhr.nu.edu.pk/',
      phoneNumber: '+1 (555) 123-4567',
      email: 'admissions@nucs.edu',
      eligibilityCriteria:
          'Minimum 80% in intermediate with Mathematics and Physics as mandatory subjects.',
      type: 'Public',
      degrees: [
        Degree(
          id: '101',
          name: 'Computer Science',
          description:
              'Bachelor of Science in Computer Science covering programming, algorithms, databases, and more.',
          duration: 4,
          requirements: [
            'Intermediate with 80% marks',
            'Mathematics as a major subject',
            'Entrance test qualification'
          ],
          careerOptions: [
            'Software Engineer',
            'Data Scientist',
            'AI Specialist'
          ],
          fee: 250000,
        ),
        Degree(
          id: '102',
          name: 'Software Engineering',
          description:
              'Bachelor of Engineering in Software focusing on software development lifecycle.',
          duration: 4,
          requirements: [
            'Intermediate with 75% marks',
            'Mathematics as a major subject',
            'Entrance test qualification'
          ],
          careerOptions: [
            'Software Developer',
            'System Analyst',
            'QA Engineer'
          ],
          fee: 240000,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Online Registration',
          description: 'Fill out the online application form on our website.',
          deadline: DateTime(2023, 8, 15),
        ),
        ApplicationStep(
          title: 'Entrance Test',
          description:
              'Appear for the entrance examination at designated centers.',
          deadline: DateTime(2023, 9, 1),
        ),
        ApplicationStep(
          title: 'Interview',
          description:
              'Shortlisted candidates will be called for an interview.',
          deadline: DateTime(2023, 9, 15),
        ),
      ],
      programs: ['Computer Science', 'Software Engineering', 'Data Science'],
    ),
    University(
      id: '2',
      name: 'University of the Punjab, Lahore',
      description:
          'The University of the Punjab is a public research university in Lahore, Punjab, Pakistan. Founded in 1882, its international influence has made it one of the most prestigious universities in South Asia; being the oldest and largest public sector one in the wider Punjab region, as well as in Pakistan.',
      imageUrl: 'assets/images/university2.png',
      address: 'F7H8+HFV, Canal Rd, Quaid-i-Azam Campus, Lahore',
      latitude: 40.7128,
      longitude: -74.0060,
      website: 'https://www.pu.edu.pk/',
      phoneNumber: '+1 (555) 987-6543',
      email: 'info@metrobusiness.edu',
      eligibilityCriteria:
          'Minimum 70% in intermediate, qualification in admission test, and interview performance.',
      type: 'Private',
      degrees: [
        Degree(
          id: '201',
          name: 'Business Administration',
          description:
              'Bachelor of Business Administration covering management, marketing, and finance.',
          duration: 4,
          requirements: [
            'Intermediate with 70% marks',
            'Entrance test qualification',
            'Interview clearance'
          ],
          careerOptions: [
            'Business Manager',
            'Marketing Executive',
            'Entrepreneur'
          ],
          fee: 300000,
        ),
        Degree(
          id: '202',
          name: 'Finance',
          description:
              'Bachelor of Science in Finance focusing on financial analysis and investment strategies.',
          duration: 4,
          requirements: [
            'Intermediate with 75% marks',
            'Mathematics as a subject',
            'Entrance test qualification'
          ],
          careerOptions: [
            'Financial Analyst',
            'Investment Banker',
            'Portfolio Manager'
          ],
          fee: 320000,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Application Submission',
          description: 'Submit your application with necessary documents.',
          deadline: DateTime(2023, 7, 30),
        ),
        ApplicationStep(
          title: 'Admission Test',
          description: 'Take the business aptitude test.',
          deadline: DateTime(2023, 8, 20),
        ),
        ApplicationStep(
          title: 'Personal Interview',
          description: 'Face-to-face interview with admission panel.',
          deadline: DateTime(2023, 9, 5),
        ),
      ],
      programs: [
        'Business Administration',
        'Finance',
        'Marketing',
        'Accounting'
      ],
    ),
    University(
      id: '3',
      name: 'University of Health Sciences Lahore',
      description:
          'A renowned institution for medical education and healthcare studies.',
      imageUrl: 'assets/images/university3.jpg',
      address: 'Khayaban-e-Jamia Punjab, Block D Muslim Town, Lahore, 54600',
      latitude: 42.3601,
      longitude: -71.0589,
      website: 'https://www.uhs.edu.pk/',
      phoneNumber: '(042) 111 333 366',
      email: 'admissions@medicalsciences.edu',
      eligibilityCriteria:
          'Minimum 85% in intermediate with Biology and Chemistry as mandatory subjects. MCAT qualification required.',
      type: 'Public',
      degrees: [
        Degree(
          id: '301',
          name: 'Medicine',
          description:
              'Bachelor of Medicine and Surgery (MBBS) program preparing doctors.',
          duration: 5,
          requirements: [
            'Intermediate with 85% marks',
            'Biology and Chemistry as major subjects',
            'MCAT qualification',
            'Interview clearance'
          ],
          careerOptions: ['Physician', 'Surgeon', 'Medical Researcher'],
          fee: 500000,
        ),
        Degree(
          id: '302',
          name: 'Dentistry',
          description:
              'Bachelor of Dental Surgery program for aspiring dentists.',
          duration: 4,
          requirements: [
            'Intermediate with 80% marks',
            'Biology and Chemistry as major subjects',
            'Entrance test qualification'
          ],
          careerOptions: ['Dentist', 'Orthodontist', 'Oral Surgeon'],
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
              'Submit your application with MCAT scores and academic records.',
          deadline: DateTime(2023, 7, 15),
        ),
        ApplicationStep(
          title: 'Interview and Selection',
          description:
              'Shortlisted candidates will undergo interview and final selection.',
          deadline: DateTime(2023, 8, 10),
        ),
      ],
      programs: ['Medicine', 'Dentistry', 'Pharmacy', 'Nursing'],
    ),
  ];
}
