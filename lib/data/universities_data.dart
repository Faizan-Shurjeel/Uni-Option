import '../models/university.dart';
import '../models/degree.dart';
import '../models/application_step.dart';

List<University> getUniversitiesData() {
  return [
    // 1) FAST NUCES – Lahore (corrected)
    University(
      id: '1',
      name: 'FAST (NUCES) – Lahore Campus',
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

    // 5) NUST – Islamabad (new)
    University(
      id: '5',
      name: 'National University of Sciences & Technology (NUST), Islamabad',
      description:
          'Leading public university in engineering, computing, natural & social sciences.',
      imageUrl: 'assets/images/nust.png',
      address: 'Sector H-12, Islamabad, Pakistan',
      latitude: 33.6423,
      longitude: 72.9904,
      website: 'https://nust.edu.pk/',
      phoneNumber: '+92-51-111-11-6878',
      email: 'pa.dadmissions@nust.edu.pk',
      eligibilityCriteria:
          'HSSC or equivalent + NUST Entry Test (NET) / SAT (as per policy).',
      type: 'Public',
      degrees: [
        Degree(
          id: '501',
          name: 'BS Computer Science',
          description: 'Computing fundamentals, systems, AI, and software.',
          duration: 4,
          requirements: ['HSSC (Maths)', 'NET/SAT'],
          careerOptions: [
            'Software Engineer',
            'Systems Engineer',
            'AI Engineer'
          ],
          fee: 0,
        ),
        Degree(
          id: '502',
          name: 'BE Electrical Engineering',
          description: 'Electronics, communications, power, and control.',
          duration: 4,
          requirements: ['HSSC (Pre-Engg)', 'NET/SAT'],
          careerOptions: ['Electrical Engineer', 'Telecom Engineer'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'NET Registration',
          description:
              'Register for NUST Entry Test / provide SAT (if applicable).',
          deadline: DateTime(2025, 5, 31),
        ),
        ApplicationStep(
          title: 'Testing Window',
          description: 'Appear in NET on selected date.',
          deadline: DateTime(2025, 6, 30),
        ),
        ApplicationStep(
          title: 'Merit & Admission',
          description: 'Merit list and joining formalities.',
          deadline: DateTime(2025, 8, 10),
        ),
      ],
      programs: [
        'Computer Science',
        'Electrical Engineering',
        'Mechanical Engineering'
      ],
    ),

    // 6) UET Lahore (new)
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

    // 7) COMSATS University Islamabad (new)
    University(
      id: '7',
      name: 'COMSATS University Islamabad (CUI) – Lahore Campus',
      description:
          'Public sector university known for computing, engineering and management programmes.',
      imageUrl: 'assets/images/comsats_lhr.jpg',
      address: 'Defence Road, Lahore 55550, Pakistan',
      latitude: 33.6765,
      longitude: 73.1612,
      website: 'https://lahore.comsats.edu.pk/',
      phoneNumber: '+92-42-111-001-007',
      email: 'info@lahore.comsats.edu.pk',
      eligibilityCriteria:
          'HSSC or equivalent + NTS/NTS-NAT or CUI test as per programme policy.',
      type: 'Public',
      degrees: [
        Degree(
          id: '701',
          name: 'BS Computer Science',
          description: 'Programming, systems, data, and AI fundamentals.',
          duration: 4,
          requirements: ['HSSC (Maths)', 'NAT/Admission test'],
          careerOptions: ['Software Engineer', 'Data Engineer'],
          fee: 0,
        ),
        Degree(
          id: '702',
          name: 'BS Software Engineering',
          description: 'Software lifecycle, quality and project management.',
          duration: 4,
          requirements: ['HSSC (Maths)', 'NAT/Admission test'],
          careerOptions: ['Software Developer', 'QA Engineer'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Online Application',
          description: 'Submit application on CUI portal with test choice.',
          deadline: DateTime(2025, 7, 5),
        ),
        ApplicationStep(
          title: 'NAT/Admission Test',
          description: 'Attempt the required test.',
          deadline: DateTime(2025, 7, 25),
        ),
        ApplicationStep(
          title: 'Merit Processing',
          description: 'Merit list and fee submission.',
          deadline: DateTime(2025, 8, 15),
        ),
      ],
      programs: [
        'Computer Science',
        'Software Engineering',
        'Electrical Engineering'
      ],
    ),

    // 8) IBA Karachi (new)
    University(
      id: '8',
      name: 'IBA Karachi – Institute of Business Administration',
      description:
          'Premier public sector business school with strong computing and economics programmes.',
      imageUrl: 'assets/images/iba_karachi.png',
      address: 'Main Campus, University Road, Karachi 75270, Pakistan',
      latitude: 24.9447,
      longitude: 67.1133,
      website: 'https://admissions.iba.edu.pk/',
      phoneNumber: '+92-21-38104700',
      email: 'admission@iba.edu.pk',
      eligibilityCriteria:
          'HSSC/A-Levels or equivalent + IBA Aptitude Test or SAT/ACT (as per policy).',
      type: 'Public',
      degrees: [
        Degree(
          id: '801',
          name: 'BBA',
          description:
              'Comprehensive business education with quantitative rigor.',
          duration: 4,
          requirements: ['HSSC/A-Levels', 'IBA Aptitude Test/SAT'],
          careerOptions: ['Business Analyst', 'Marketing/Finance Associate'],
          fee: 0,
        ),
        Degree(
          id: '802',
          name: 'BS Computer Science',
          description: 'Core CS, software and data-focused curriculum.',
          duration: 4,
          requirements: ['HSSC (Maths)/A-Levels', 'Aptitude Test/SAT'],
          careerOptions: ['Software Engineer', 'Data Analyst'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Online Form',
          description: 'Apply on IBA Admissions portal and select test center.',
          deadline: DateTime(2025, 6, 10),
        ),
        ApplicationStep(
          title: 'Aptitude Test/Exemptions',
          description:
              'Attempt test or submit SAT/ACT for exemption if eligible.',
          deadline: DateTime(2025, 7, 10),
        ),
        ApplicationStep(
          title: 'Interview & Offer',
          description:
              'Interview (if required), merit list and fee submission.',
          deadline: DateTime(2025, 8, 10),
        ),
      ],
      programs: [
        'BBA',
        'Computer Science',
        'Accounting & Finance',
        'Economics'
      ],
    ),

    // 9) GIKI – Topi, Khyber Pakhtunkhwa (new)
    University(
      id: '9',
      name: 'Ghulam Ishaq Khan Institute (GIKI), Topi',
      description:
          'Selective private institute renowned for engineering and computing.',
      imageUrl: 'assets/images/giki.jpeg',
      address: 'Topi 23640, District Swabi, Khyber Pakhtunkhwa, Pakistan',
      latitude: 34.0640,
      longitude: 72.6480,
      website: 'https://giki.edu.pk/',
      phoneNumber: '+92-938-271858',
      email: 'oric@giki.edu.pk',
      eligibilityCriteria:
          'HSSC (Pre-Engineering/Maths) or equivalent + GIKI admission test/SAT.',
      type: 'Private',
      degrees: [
        Degree(
          id: '901',
          name: 'BS Computer Engineering',
          description: 'Embedded systems, computer architecture, and software.',
          duration: 4,
          requirements: ['HSSC (Maths)', 'GIKI test/SAT'],
          careerOptions: ['Embedded Engineer', 'Systems Engineer'],
          fee: 0,
        ),
        Degree(
          id: '902',
          name: 'BS Computer Science',
          description: 'Algorithms, systems, AI and software practice.',
          duration: 4,
          requirements: ['HSSC (Maths)', 'GIKI test/SAT'],
          careerOptions: ['Software Engineer', 'Data Engineer'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Online Application',
          description: 'Apply on GIKI admissions portal.',
          deadline: DateTime(2025, 6, 1),
        ),
        ApplicationStep(
          title: 'Admission Test/SAT',
          description: 'Attempt GIKI test or provide SAT score.',
          deadline: DateTime(2025, 6, 25),
        ),
        ApplicationStep(
          title: 'Merit Lists',
          description: 'Merit processing and enrollment.',
          deadline: DateTime(2025, 7, 20),
        ),
      ],
      programs: [
        'Computer Engineering',
        'Computer Science',
        'Mechanical Engineering'
      ],
    ),

    // 10) PIEAS – Islamabad (new)
    University(
      id: '10',
      name:
          'Pakistan Institute of Engineering & Applied Sciences (PIEAS), Islamabad',
      description:
          'Public sector research university recognized for nuclear, electrical and materials engineering.',
      imageUrl: 'assets/images/pieas.jpeg',
      address: 'Lehtrar Road, Nilore, Islamabad, Pakistan',
      latitude: 33.6277,
      longitude: 73.1570,
      website: 'https://www.pieas.edu.pk/',
      phoneNumber: '+92-51-1111-74327',
      email: 'registrar@pieas.edu.pk',
      eligibilityCriteria:
          'HSSC (Pre-Engineering/Maths) or equivalent + PIEAS admission test (or as per policy).',
      type: 'Public',
      degrees: [
        Degree(
          id: '1001',
          name: 'BS Electrical Engineering',
          description: 'Electronics, power, control and communications.',
          duration: 4,
          requirements: ['HSSC (Pre-Engg)', 'PIEAS test'],
          careerOptions: ['Electrical Engineer', 'Control Engineer'],
          fee: 0,
        ),
        Degree(
          id: '1002',
          name: 'BS Computer & Information Sciences',
          description: 'Core computing with applied research focus.',
          duration: 4,
          requirements: ['HSSC (Maths)', 'PIEAS test'],
          careerOptions: ['Software Engineer', 'Research Engineer'],
          fee: 0,
        ),
      ],
      applicationSteps: [
        ApplicationStep(
          title: 'Apply Online',
          description: 'Submit application on PIEAS portal.',
          deadline: DateTime(2025, 5, 31),
        ),
        ApplicationStep(
          title: 'Admission Test',
          description: 'Attempt PIEAS test at designated center.',
          deadline: DateTime(2025, 6, 30),
        ),
        ApplicationStep(
          title: 'Selection & Joining',
          description:
              'Merit list, medicals (if any) and joining instructions.',
          deadline: DateTime(2025, 8, 5),
        ),
      ],
      programs: [
        'Electrical Engineering',
        'Computer & Information Sciences',
        'Mechanical Engineering'
      ],
    ),
  ];
}
