class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final String description;
  final double rating;
  final String imagePath;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.description,
    required this.rating,
    required this.imagePath,
  });

  static List<DoctorModel> getTopRatedDoctors() {
    return [
      DoctorModel(
        id: '1',
        name: 'Dr. Steward',
        specialty: 'Dentist',
        description:
            'Experienced general physician providing reliable care and helping patients achieve their health goals.',
        rating: 5.0,
        imagePath: 'assets/images/MedicalCenterImages/Rectangle 1512.png', 
      ),
      DoctorModel(
        id: '2',
        name: 'Dr. Zoya',
        specialty: 'Cardiologist',
        description:
            'Dr. Zoya is an experienced cardiologist specializing in heart health and cardiovascular care.',
        rating: 4.0,
        imagePath: 'assets/images/MedicalCenterImages/Rectangle 1512.png', 
      ),
      DoctorModel(
        id: '3',
        name: 'Dr. Andrew Collins',
        specialty: 'Dentist',
        description:
            'Dr. Andrew Collins is a highly skilled Dentist specializing in oral health and dental care.',
        rating: 4.5,
        imagePath: 'assets/images/MedicalCenterImages/Rectangle 1512.png', 
      ),
    ];
  }
}