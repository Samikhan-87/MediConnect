class MedicalCenterModel {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final List<String> services;
  final String location;
  final String phone;
  final Map<String, String> timings; 
  final String email;

  MedicalCenterModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.services,
    required this.location,
    required this.phone,
    required this.timings,
    required this.email,
  });

  static List<MedicalCenterModel> getMedicalCenters() {
    return [
      MedicalCenterModel(
        id: '1',
        name: 'Trusted Healthcare',
        description:
            'Trusted healthcare with skilled doctors and modern facilities, offering checkups, diagnostics, and specialist care.',
        imagePath: 'assets/images/MedicalCenterImages/image 8.png',
        services: ['Checkups', 'Diagnostics', 'Specialists'],
        location: '2140 Westwood Blvd, Los Angeles, CA 90025, USA',
        phone: '+1 (310) 555-4821',
        timings: {
          'Mon-Fri': '8:00 AM – 8:00 PM',
          'Saturday': '9:00 AM – 5:00 PM',
          'Sunday': 'Closed',
        },
        email: 'contact@sunrisehealthcare.us',
      ),
      MedicalCenterModel(
        id: '2',
        name: 'City Health Clinic',
        description:
            'Comprehensive medical services with experienced professionals, providing quality care for all your health needs.',
        imagePath: 'assets/images/MedicalCenterImages/image 5.png',
        services: ['General Medicine', 'Pediatrics', 'Emergency Care'],
        location: '123 Main Street, New York, NY 10001, USA',
        phone: '+1 (212) 555-1234',
        timings: {
          'Mon-Fri': '7:00 AM – 7:00 PM',
          'Saturday': '8:00 AM – 6:00 PM',
          'Sunday': '10:00 AM – 4:00 PM',
        },
        email: 'info@cityhealthclinic.com',
      ),
      MedicalCenterModel(
        id: '3',
        name: 'Wellness Medical Hub',
        description:
            'State-of-the-art facility offering advanced treatments and personalized care for optimal health outcomes.',
        imagePath: 'assets/images/MedicalCenterImages/image 6.png',
        services: ['Cardiology', 'Orthopedics', 'Dermatology'],
        location: '456 Health Avenue, Chicago, IL 60601, USA',
        phone: '+1 (312) 555-5678',
        timings: {
          'Mon-Fri': '9:00 AM – 9:00 PM',
          'Saturday': '9:00 AM – 5:00 PM',
          'Sunday': 'Closed',
        },
        email: 'contact@wellnessmedicalhub.com',
      ),
      MedicalCenterModel(
        id: '4',
        name: 'Community Care Center',
        description:
            'Dedicated to serving the community with affordable healthcare services and compassionate medical professionals.',
        imagePath: 'assets/images/MedicalCenterImages/image 7.png',
        services: ['Family Medicine', 'Mental Health', 'Preventive Care'],
        location: '789 Care Boulevard, Houston, TX 77001, USA',
        phone: '+1 (713) 555-9012',
        timings: {
          'Mon-Fri': '8:00 AM – 6:00 PM',
          'Saturday': '9:00 AM – 3:00 PM',
          'Sunday': 'Closed',
        },
        email: 'info@communitycarecenter.org',
      ),
    ];
  }
}
