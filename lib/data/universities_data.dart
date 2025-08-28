import '../models/university.dart';
import '../models/degree.dart';
import '../models/application_step.dart';

List<University> getUniversitiesData() {
  return [
    // 1) FAST NUCES – Lahore (corrected)
    University(
      id: '1',
      name: 'FAST (NUCES) - Lahore Campus',
      description:
          'National University of Computer & Emerging Sciences (FAST-NUCES) Lahore Campus; leading private university in computing and engineering.',
      imageUrl: 'assets/images/fast_lahore.png',
      address: 'Block B, Faisal Town, Lahore 54000, Pakistan',
      latitude: 31.4802,
      longitude: 74.3153,
      website: 'https://lhr.nu.edu.pk/',
      phoneNumber: '(042) 111-128-128',
      email: 'admissions.lhr@nu.edu.pk',
      eligibilityCriteria:
          'HSSC or equivalent as per NU policy + NU Entry Test or SAT (program-specific).',
      type: 'Private',
      degrees: [
        Degree(
          id: '101',
          name: 'BS Computer Science',
          description:
              'Programming, algorithms, databases, operating systems, software engineering.',
          duration: 4,
          requirements: [
            'HSSC or equivalent (Maths required)',
            'NU Entry Test / SAT (as per policy)',
          ],
          careerOptions: [
            'Software Engineer',
            'Data Scientist',
            'AI/ML Engineer',
          ],
          fee: 0,
        ),
        Degree(
          id: '102',
          name: 'BS Software Engineering',
          description:
              'Software design, development lifecycle, quality assurance, project management.',
          duration: 4,
          requirements: [
            'HSSC or equivalent (Maths required)',
            'NU Entry Test / SAT',
          ],
          careerOptions: [
            'Software Developer',
            'QA Engineer',
            'Product/Project Manager',
          ],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Online Application',
          description:
              'Create profile and submit application on admissions portal.',
          deadline: DateTime(2025, 6, 15),
        ),
        ApplicationStep(
          title: 'Entry Test / SAT',
          description: 'Appear in NU Entry Test or submit SAT (if applicable).',
          deadline: DateTime(2025, 7, 5),
        ),
        ApplicationStep(
          title: 'Merit & Enrollment',
          description: 'Merit list, document verification, and fee submission.',
          deadline: DateTime(2025, 8, 1),
        ),
      ],
      programs: [
        'Computer Science',
        'Software Engineering',
        'Electrical Engineering'
      ],
    ),

    // 2) University of the Punjab – Lahore (corrected)
    University(
      id: '2',
      name: 'University of the Punjab (PU), Lahore',
      description:
          'Oldest and one of the largest public universities in Pakistan with diverse programmes.',
      imageUrl: 'assets/images/pu_lahore.png',
      address: 'Quaid-i-Azam Campus, Canal Road, Lahore 54590, Pakistan',
      latitude: 31.5095,
      longitude: 74.3086,
      website: 'https://www.pu.edu.pk/',
      phoneNumber: '+92-42-99231099',
      email: 'info@pu.edu.pk',
      eligibilityCriteria:
          'HSSC or equivalent with programme-specific requirements; PU/departmental tests where applicable.',
      type: 'Public',
      degrees: [
        Degree(
          id: '201',
          name: 'BBA',
          description:
              'Core management, finance, marketing, operations, and organizational behaviour.',
          duration: 4,
          requirements: [
            'HSSC or equivalent',
            'Department/admissions test (if applicable)',
          ],
          careerOptions: [
            'Business Analyst',
            'Marketing Executive',
            'Finance Associate'
          ],
          fee: 0,
        ),
        Degree(
          id: '202',
          name: 'BS Accounting & Finance',
          description:
              'Financial reporting, corporate finance, taxation, investments.',
          duration: 4,
          requirements: [
            'HSSC or equivalent (Maths preferred)',
            'Department/admissions test (if applicable)',
          ],
          careerOptions: ['Financial Analyst', 'Audit Associate', 'Banking'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Apply Online',
          description: 'Departmental/centralised admissions portal.',
          deadline: DateTime(2025, 7, 20),
        ),
        ApplicationStep(
          title: 'Test/Interview',
          description: 'Programme-specific test and/or interview.',
          deadline: DateTime(2025, 8, 5),
        ),
        ApplicationStep(
          title: 'Merit & Admission',
          description: 'Merit list, fee challan, and enrollment.',
          deadline: DateTime(2025, 8, 25),
        ),
      ],
      programs: [
        'BBA',
        'Accounting & Finance',
        'Economics',
        'Computer Science'
      ],
    ),

    // 3) University of Health Sciences – Lahore (corrected)
    University(
      id: '3',
      name: 'University of Health Sciences (UHS), Lahore',
      description:
          'Public sector university overseeing medical & dental education in Punjab and offering health sciences programmes.',
      imageUrl: 'assets/images/uhs_lahore.jpg',
      address: 'Khayaban-e-Jamia Punjab, Lahore 54600, Pakistan',
      latitude: 31.4952,
      longitude: 74.3051,
      website: 'https://www.uhs.edu.pk/',
      phoneNumber: '111-33-33-66 / 042-99231304-09',
      email: 'info@uhs.edu.pk',
      eligibilityCriteria:
          'For MBBS/BDS: HSSC (Pre-Medical) + MDCAT, as per PMC/Provincial policy. Programme-specific for others.',
      type: 'Public',
      degrees: [
        Degree(
          id: '301',
          name: 'MBBS (Affiliated Colleges)',
          description:
              'Bachelor of Medicine & Bachelor of Surgery as per national curriculum; admissions via provincial authority.',
          duration: 5,
          requirements: ['HSSC (Pre-Medical)', 'MDCAT as per policy'],
          careerOptions: ['Physician', 'Surgeon', 'Medical Research'],
          fee: 0,
        ),
        Degree(
          id: '302',
          name: 'BDS (Affiliated Colleges)',
          description:
              'Bachelor of Dental Surgery; admissions via provincial authority.',
          duration: 4,
          requirements: ['HSSC (Pre-Medical)', 'MDCAT as per policy'],
          careerOptions: ['Dentist', 'Orthodontist', 'Oral Surgeon'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'MDCAT',
          description: 'Register/appear in MDCAT as per regulator’s schedule.',
          deadline: DateTime(2025, 7, 10),
        ),
        ApplicationStep(
          title: 'Provincial Application',
          description:
              'Submit online application with MDCAT score and credentials.',
          deadline: DateTime(2025, 8, 1),
        ),
        ApplicationStep(
          title: 'College Allocation',
          description:
              'Merit list and college allocation; document verification.',
          deadline: DateTime(2025, 9, 1),
        ),
      ],
      programs: [
        'Medicine',
        'Dentistry',
        'Allied Health',
        'Nursing',
        'Public Health'
      ],
    ),

    // 4) LUMS – Lahore (new)
    University(
      id: '4',
      name: 'Lahore University of Management Sciences (LUMS)',
      description:
          'Top private research university offering management, computing, social sciences, humanities, and law.',
      imageUrl: 'assets/images/lums.png',
      address: 'Sector U, DHA, Lahore Cantt. 54792, Pakistan',
      latitude: 31.4710,
      longitude: 74.4089,
      website: 'https://admission.lums.edu.pk/',
      phoneNumber: '+92-42-3560-8000 (Ext. 2177)',
      email: 'admissions@lums.edu.pk',
      eligibilityCriteria:
          'HSSC/A-Levels or equivalent; SAT/LMAT/subject tests as per programme.',
      type: 'Private',
      degrees: [
        Degree(
          id: '401',
          name: 'BS Computer Science',
          description: 'Core CS with strong theory and systems foundation.',
          duration: 4,
          requirements: ['HSSC/A-Levels', 'LUMS test/SAT (policy-based)'],
          careerOptions: ['Software Engineer', 'Data Scientist', 'Research'],
          fee: 0,
        ),
        Degree(
          id: '402',
          name: 'BSc (Honours) Management Sciences',
          description: 'Quantitative and analytical management education.',
          duration: 4,
          requirements: ['HSSC/A-Levels', 'Admissions test'],
          careerOptions: ['Consulting', 'Finance', 'Operations'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Apply Online',
          description: 'Create account and submit documents on LUMS portal.',
          deadline: DateTime(2025, 1, 31),
        ),
        ApplicationStep(
          title: 'Admission Test/SAT',
          description: 'Complete required standardized tests.',
          deadline: DateTime(2025, 3, 15),
        ),
        ApplicationStep(
          title: 'Decisions',
          description: 'Merit evaluation and offer acceptance.',
          deadline: DateTime(2025, 6, 1),
        ),
      ],
      programs: ['Computer Science', 'Management Sciences', 'Economics', 'Law'],
    ),

    // // 6) UET Lahore (new)
    University(
      id: '6',
      name: 'University of Engineering & Technology (UET) Lahore',
      description:
          'Historic public engineering university; main campus on G.T. Road, Lahore.',
      imageUrl: 'assets/images/UET.png',
      address: 'G.T. Road, Lahore 54890, Pakistan',
      latitude: 31.5790,
      longitude: 74.3559,
      website: 'https://uet.edu.pk/',
      phoneNumber: '+92-42-99029452',
      email: 'info@uet.edu.pk',
      eligibilityCriteria:
          'HSSC (Pre-Engineering/Maths) + ECAT/centralised test as per Punjab policy.',
      type: 'Public',
      degrees: [
        Degree(
          id: '601',
          name: 'BSc Electrical Engineering',
          description: 'Power, electronics, communications, control.',
          duration: 4,
          requirements: ['HSSC (Pre-Engg)', 'ECAT/central test'],
          careerOptions: ['Electrical Engineer', 'Power Systems Engineer'],
          fee: 0,
        ),
        Degree(
          id: '602',
          name: 'BSc Mechanical Engineering',
          description: 'Thermal, design, manufacturing and robotics.',
          duration: 4,
          requirements: ['HSSC (Pre-Engg)', 'ECAT/central test'],
          careerOptions: ['Mechanical Engineer', 'Manufacturing Engineer'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Test Registration',
          description: 'Register for ECAT/centralised engineering test.',
          deadline: DateTime(2025, 6, 15),
        ),
        ApplicationStep(
          title: 'Preferences & Documents',
          description: 'Submit application and programme preferences.',
          deadline: DateTime(2025, 7, 20),
        ),
        ApplicationStep(
          title: 'Merit & Enrolment',
          description: 'Merit lists, challan and course registration.',
          deadline: DateTime(2025, 8, 20),
        ),
      ],
      programs: [
        'Electrical Engineering',
        'Mechanical Engineering',
        'Civil Engineering'
      ],
    ),
    // — New Additions — //

    // 7) University of Central Punjab – Lahore
    University(
      id: '7',
      name: 'University of Central Punjab (UCP), Lahore',
      description:
          'Private university with a wide range of programmes in arts, sciences, business and IT.',
      imageUrl: 'assets/images/ucp.jpg',
      address: 'Gulberg, Lahore, Pakistan',
      latitude: 31.5204,
      longitude: 74.3587,
      website: 'https://www.ucp.edu.pk/',
      phoneNumber: '+92-42-5755314-7',
      email: 'info@ucp.edu.pk',
      eligibilityCriteria:
          'HSSC or equivalent + UCP test / SAT as per programme.',
      type: 'Private',
      degrees: [
        Degree(
          id: '701',
          name: 'BS Computer Science',
          description: 'Computing fundamentals, programming, web technologies.',
          duration: 4,
          requirements: ['HSSC (Maths)', 'UCP admission test/SAT'],
          careerOptions: ['Software Developer', 'Web Developer'],
          fee: 0,
        ),
        Degree(
          id: '702',
          name: 'BBA',
          description:
              'Business fundamentals including management, finance and marketing.',
          duration: 4,
          requirements: ['HSSC or equivalent', 'UCP test'],
          careerOptions: ['Business Analyst', 'Marketing Executive'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Online Application',
          description: 'Apply via UCP admission portal.',
          deadline: DateTime(2025, 7, 30),
        ),
        ApplicationStep(
          title: 'Admission Test',
          description: 'Appear for UCP test or provide SAT/ACT.',
          deadline: DateTime(2025, 8, 15),
        ),
        ApplicationStep(
          title: 'Merit List & Enrollment',
          description: 'Merit list published, complete admission formalities.',
          deadline: DateTime(2025, 9, 5),
        ),
      ],
      programs: ['Computer Science', 'Business Administration'],
    ),

    // 8) Bahria University – Lahore
    University(
      id: '8',
      name: 'Bahria University, Lahore Campus',
      description:
          'Public sector university offering engineering, social sciences, business, IT.',
      imageUrl: 'assets/images/bahria_u.png',
      address: 'Lahore Cantt, Lahore, Pakistan',
      latitude: 31.4878,
      longitude: 74.3220,
      website: 'https://lahore.bahria.edu.pk/',
      phoneNumber: '+92-42-111-188-188',
      email: 'info@bahria.edu.pk',
      eligibilityCriteria: 'HSSC or equivalent + Bahria admission test / SAT.',
      type: 'Public',
      degrees: [
        Degree(
          id: '801',
          name: 'BS Computer Science',
          description:
              'Foundations of computing, software development and data.',
          duration: 4,
          requirements: ['HSSC (Maths)', 'Admission test'],
          careerOptions: ['Software Engineer', 'Data Analyst'],
          fee: 0,
        ),
        Degree(
          id: '802',
          name: 'BS Business Administration',
          description: 'Business fundamentals, management, finance.',
          duration: 4,
          requirements: ['HSSC or equivalent', 'Admission test'],
          careerOptions: ['Managerial roles', 'Entrepreneur'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Apply Online',
          description: 'Submit application via Bahria portal.',
          deadline: DateTime(2025, 7, 1),
        ),
        ApplicationStep(
          title: 'Entrance Test',
          description: 'Appear in Bahria admission test.',
          deadline: DateTime(2025, 7, 20),
        ),
        ApplicationStep(
          title: 'Merit & Admission',
          description: 'Merit announced, complete enrollment.',
          deadline: DateTime(2025, 8, 10),
        ),
      ],
      programs: ['Computer Science', 'Business Administration'],
    ),

    // 9) Information Technology University – Lahore
    University(
      id: '9',
      name: 'Information Technology University (ITU), Lahore',
      description:
          'Tech‑focused public university emphasizing IT, data science and design.',
      imageUrl: 'assets/images/itu.png',
      address: 'A‑Block, Faisal Town, Lahore, Pakistan',
      latitude: 31.4802,
      longitude: 74.3153,
      website: 'https://itu.edu.pk/',
      phoneNumber: '+92-42-111-483-111',
      email: 'info@itu.edu.pk',
      eligibilityCriteria: 'HSSC or equivalent + ITU entrance exam / SAT.',
      type: 'Public',
      degrees: [
        Degree(
          id: '901',
          name: 'BS Computer Science',
          description:
              'Advanced computing, AI, data science and software systems.',
          duration: 4,
          requirements: ['HSSC (Maths)', 'Entrance exam/SAT'],
          careerOptions: ['AI Engineer', 'Software Engineer', 'Data Scientist'],
          fee: 0,
        ),
        Degree(
          id: '902',
          name: 'BS Data Science',
          description: 'Statistics, machine learning, data analysis, big data.',
          duration: 4,
          requirements: ['HSSC (Maths)', 'Entrance exam/SAT'],
          careerOptions: ['Data Scientist', 'Business Intelligence Analyst'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Apply Online',
          description: 'Apply via ITU admissions portal with documents.',
          deadline: DateTime(2025, 7, 15),
        ),
        ApplicationStep(
          title: 'Admission Test',
          description: 'Sit for the ITU entrance exam / submit SAT.',
          deadline: DateTime(2025, 8, 1),
        ),
        ApplicationStep(
          title: 'Merit & Enrollment',
          description: 'Admission finalized; submit fees and enroll.',
          deadline: DateTime(2025, 8, 25),
        ),
      ],
      programs: ['Computer Science', 'Data Science', 'Design'],
    ),

    // 10) Lahore College for Women University (LCWU) – Lahore
    University(
      id: '10',
      name: 'Lahore College for Women University (LCWU)',
      description:
          'Public women’s university offering arts, sciences, and software engineering.',
      imageUrl: 'assets/images/lcwu.jpg',
      address: 'Jail Road, Lahore, Pakistan',
      latitude: 31.5138,
      longitude: 74.3360,
      website: 'https://www.lcwu.edu.pk/',
      phoneNumber: '042-99203088',
      email: 'info@lcwu.edu.pk',
      eligibilityCriteria:
          'HSSC or equivalent; programme-specific entry tests where applicable.',
      type: 'Public',
      degrees: [
        Degree(
          id: '1001',
          name: 'BS Software Engineering',
          description: 'Software development, design, engineering principles.',
          duration: 4,
          requirements: ['HSSC (Maths)', 'Entry test'],
          careerOptions: ['Software Developer', 'QA Engineer'],
          fee: 0,
        ),
        Degree(
          id: '1002',
          name: 'BS English',
          description: 'Literature, linguistics, language studies.',
          duration: 4,
          requirements: ['HSSC (Second division)'],
          careerOptions: ['Writer', 'Educator', 'Editor'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Submit Application',
          description: 'Apply via LCWU portal.',
          deadline: DateTime(2025, 7, 10),
        ),
        ApplicationStep(
          title: 'Entry Test (if required)',
          description: 'Sit for programme‑specific test.',
          deadline: DateTime(2025, 7, 25),
        ),
        ApplicationStep(
          title: 'Merit Lists',
          description: 'Merit announced, complete admission.',
          deadline: DateTime(2025, 8, 15),
        ),
      ],
      programs: ['Software Engineering', 'English', 'Psychology'],
    ),

    // 11) Lahore Garrison University (LGU) – Lahore
    University(
      id: '11',
      name: 'Lahore Garrison University (LGU)',
      description:
          'Pakistan Army-operated private university offering diverse programs.',
      imageUrl: 'assets/images/lgu.png',
      address: 'Lahore, Punjab, Pakistan',
      latitude: 31.5200,
      longitude: 74.3200,
      website: 'https://lgu.edu.pk/',
      phoneNumber: '042-XXXXXXX',
      email: 'info@lgu.edu.pk',
      eligibilityCriteria:
          'HSSC or equivalent + LGU entrance test as per programme.',
      type: 'Private',
      degrees: [
        Degree(
          id: '1101',
          name: 'BS Management Sciences',
          description: 'Business administration, management principles.',
          duration: 4,
          requirements: ['HSSC', 'Entrance test'],
          careerOptions: ['Manager', 'Operations Analyst'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Admission Form',
          description: 'Apply via LGU admissions portal.',
          deadline: DateTime(2025, 7, 20),
        ),
        ApplicationStep(
          title: 'Entrance Test',
          description: 'Sit for LGU entry test.',
          deadline: DateTime(2025, 8, 5),
        ),
        ApplicationStep(
          title: 'Merit List',
          description: 'Admission finalized, enroll.',
          deadline: DateTime(2025, 8, 25),
        ),
      ],
      programs: ['Management Sciences'],
    ),

    // 12) Minhaj University Lahore (MUL)
    University(
      id: '12',
      name: 'Minhaj University Lahore',
      description: 'Private multidisciplinary university established in 1986.',
      imageUrl: 'assets/images/minhaj.png',
      address: 'Model Town, Lahore, Pakistan',
      latitude: 31.5200,
      longitude: 74.3700,
      website: 'https://www.mul.edu.pk/',
      phoneNumber: '042-5169120',
      email: 'info@mul.edu.pk',
      eligibilityCriteria:
          'HSSC or equivalent + MUL admission test / as per programme.',
      type: 'Private',
      degrees: [
        Degree(
          id: '1201',
          name: 'BS Electrical Engineering',
          description: 'Engineering fundamentals in electrical systems.',
          duration: 4,
          requirements: ['HSSC (Pre‑Engineering)', 'Admission test'],
          careerOptions: ['Electrical Engineer'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Apply Online',
          description: 'Submit application via MUL portal.',
          deadline: DateTime(2025, 7, 5),
        ),
        ApplicationStep(
          title: 'Entrance Test',
          description: 'Sit for MUL entrance test.',
          deadline: DateTime(2025, 7, 20),
        ),
        ApplicationStep(
          title: 'Merit List & Enrollment',
          description: 'Complete admission on merit.',
          deadline: DateTime(2025, 8, 10),
        ),
      ],
      programs: ['Electrical Engineering'],
    ),

    // 13) Beaconhouse National University (BNU)
    University(
      id: '13',
      name: 'Beaconhouse National University (BNU), Lahore',
      description:
          'Private liberal arts and arts university with arts, design, IT, media.',
      imageUrl: 'assets/images/bnu.png',
      address: 'Raiwind Rd, Lahore, Pakistan',
      latitude: 31.3250,
      longitude: 74.3140,
      website: 'https://www.bnu.edu.pk/',
      phoneNumber: '042-XXXXXXX',
      email: 'info@bnu.edu.pk',
      eligibilityCriteria:
          'HSSC or equivalent; programme-specific admission tests where applicable.',
      type: 'Private',
      degrees: [
        Degree(
          id: '1301',
          name: 'Bachelor of Visual Design',
          description: 'Visual arts, media, design principles and practice.',
          duration: 4,
          requirements: ['HSSC', 'Design test/audition'],
          careerOptions: ['Graphic Designer', 'Art Director'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Apply Online',
          description: 'Submit application via BNU portal.',
          deadline: DateTime(2025, 7, 15),
        ),
        ApplicationStep(
          title: 'Design Test/Audition',
          description: 'Appear for programme‑specific entrance test.',
          deadline: DateTime(2025, 8, 1),
        ),
        ApplicationStep(
          title: 'Merit & Enrollment',
          description: 'Admission confirmed; enroll and submit fees.',
          deadline: DateTime(2025, 8, 20),
        ),
      ],
      programs: ['Visual Design', 'Architecture', 'Media & Communication'],
    ),

    // 14) National Institute of Technology (NIT), Lahore – established 2025
    University(
      id: '14',
      name: 'National Institute of Technology (NIT), Lahore',
      description:
          'Private university established in January 2025 in partnership with Arizona State University.',
      imageUrl: 'assets/images/nit_lahore.png',
      address: 'Lahore, Punjab, Pakistan',
      latitude: 31.5200,
      longitude: 74.3600,
      website: 'https://www.nit.edu.pk/',
      phoneNumber: '042-XXXXXXX',
      email: 'info@nit.edu.pk',
      eligibilityCriteria:
          'HSSC or equivalent + NIT admission test / SAT, as per policy.',
      type: 'Private',
      degrees: [
        Degree(
          id: '1401',
          name: 'BS Engineering (ASU-Mirrored)',
          description:
              'Engineering curriculum modeled after Arizona State University.',
          duration: 4,
          requirements: ['HSSC (Pre-Engineering)', 'Admission test/SAT'],
          careerOptions: ['Engineer (various specializations)'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Apply Online',
          description: 'Admissions through NIT portal.',
          deadline: DateTime(2025, 8, 1),
        ),
        ApplicationStep(
          title: 'Entrance Test / SAT',
          description: 'Take NIT test or submit SAT, per programme policy.',
          deadline: DateTime(2025, 8, 20),
        ),
        ApplicationStep(
          title: 'Merit & Enrollment',
          description: 'Admission finalized; enroll and submit fees.',
          deadline: DateTime(2025, 9, 10),
        ),
      ],
      programs: ['Engineering (ASU‑Mirrored)'],
    ),
  ];
}
