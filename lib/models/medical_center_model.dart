class MedicalCenterModel {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final List<String> services;

  MedicalCenterModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.services,
  });

  static List<MedicalCenterModel> getMedicalCenters() {
    return [
      MedicalCenterModel(
        id: '1',
        name: 'Sunrise Medical Center',
        description:
            'Trusted healthcare with skilled doctors and modern facilities, offering checkups, diagnostics, and specialist care.',
        imagePath: '',
        services: ['Checkups', 'Diagnostics', 'Specialists'],
      ),
      MedicalCenterModel(
        id: '2',
        name: 'City Health Clinic',
        description:
            'Comprehensive medical services with experienced professionals, providing quality care for all your health needs.',
        imagePath: '',
        services: ['General Medicine', 'Pediatrics', 'Emergency Care'],
      ),
      MedicalCenterModel(
        id: '3',
        name: 'Wellness Medical Hub',
        description:
            'State-of-the-art facility offering advanced treatments and personalized care for optimal health outcomes.',
        imagePath: '',
        services: ['Cardiology', 'Orthopedics', 'Dermatology'],
      ),
      MedicalCenterModel(
        id: '4',
        name: 'Community Care Center',
        description:
            'Dedicated to serving the community with affordable healthcare services and compassionate medical professionals.',
        imagePath: '',
        services: ['Family Medicine', 'Mental Health', 'Preventive Care'],
      ),
    ];
  }
}
