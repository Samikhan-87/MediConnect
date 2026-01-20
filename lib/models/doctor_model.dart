class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final String description;
  final double rating;
  final String imagePath;
  final int experienceYears;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.description,
    required this.rating,
    required this.imagePath,
    required this.experienceYears,
  });

  static List<DoctorModel> getTopRatedDoctors() {
    return [
      DoctorModel(
        id: '1',
        name: 'Dr. Steward',
        specialty: 'Dentist',
        description:
            'Experienced dentist providing reliable oral care and helping patients achieve their dental goals.',
        rating: 5.0,
        imagePath: 'assets/images/MedicalCenterImages/Rectangle 1512.png',
        experienceYears: 8,
      ),
      DoctorModel(
        id: '2',
        name: 'Dr. Zoya',
        specialty: 'Cardiologist',
        description:
            'Dr. Zoya is an experienced cardiologist specializing in heart health and cardiovascular care.',
        rating: 4.0,
        imagePath: 'assets/images/MedicalCenterImages/Rectangle 1513.png',
        experienceYears: 5,
      ),
      DoctorModel(
        id: '3',
        name: 'Dr. Andrew Collins',
        specialty: 'Orthopedic Surgeon',
        description:
            'Dr. Andrew Collins is a highly skilled orthopedic surgeon specializing in musculoskeletal care.',
        rating: 5.0,
        imagePath: 'assets/images/MedicalCenterImages/Rectangle 1494.png',
        experienceYears: 12,
      ),
      DoctorModel(
        id: '4',
        name: 'Dr. Maria Khan',
        specialty: 'Dentist',
        description:
            'General dentist focused on preventive care and cosmetic dentistry.',
        rating: 4.2,
        imagePath: 'assets/images/DoctorImages/doctor1.png',
        experienceYears: 4,
      ),
      DoctorModel(
        id: '5',
        name: 'Dr. Ahmed Ali',
        specialty: 'Surgeon',
        description:
            'General surgeon with experience in minimally invasive procedures.',
        rating: 3.8,
        imagePath: 'assets/images/DoctorImages/doctor2.png',
        experienceYears: 9,
      ),
      DoctorModel(
        id: '6',
        name: 'Dr. Sara Lee',
        specialty: 'Cardiologist',
        description:
            'Cardiologist focusing on preventive cardiology and heart failure management.',
        rating: 4.6,
        imagePath: 'assets/images/DoctorImages/doctor3.png',
        experienceYears: 7,
      ),
      DoctorModel(
        id: '7',
        name: 'Dr. Kevin Park',
        specialty: 'Surgeon',
        description:
            'Experienced surgeon with expertise in laparoscopic techniques.',
        rating: 3.3,
        imagePath: 'assets/images/DoctorImages/doctor4.png',
        experienceYears: 6,
      ),
      DoctorModel(
        id: '8',
        name: 'Dr. Nina Patel',
        specialty: 'Dermatologist',
        description:
            'Dermatologist specializing in medical and cosmetic dermatology.',
        rating: 4.1,
        imagePath: 'assets/images/DoctorImages/doctor5.png',
        experienceYears: 3,
      ),
      DoctorModel(
        id: '9',
        name: 'Dr. Omar Rahman',
        specialty: 'Pediatrician',
        description:
            'Compassionate pediatrician providing care for children of all ages.',
        rating: 4.7,
        imagePath: 'assets/images/DoctorImages/doctor6.png',
        experienceYears: 10,
      ),
      DoctorModel(
        id: '10',
        name: 'Dr. Elena Rossi',
        specialty: 'Surgeon',
        description: 'Specialist in reconstructive and cosmetic surgery.',
        rating: 4.9,
        imagePath: 'assets/images/DoctorImages/doctor7.png',
        experienceYears: 11,
      ),
    ];
  }
}