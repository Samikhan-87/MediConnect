class AppointmentModel {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImagePath;
  final String day;
  final String time;
  final String location;
  final DateTime appointmentDate;
  final bool isCompleted;

  AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImagePath,
    required this.day,
    required this.time,
    required this.location,
    required this.appointmentDate,
    this.isCompleted = false,
  });

  // Check if appointment is current (upcoming) or previous
  bool get isCurrent => appointmentDate.isAfter(DateTime.now()) && !isCompleted;
  bool get isPrevious =>
      appointmentDate.isBefore(DateTime.now()) || isCompleted;

  // Sample appointments data
  static List<AppointmentModel> getAppointments() {
    return [
      AppointmentModel(
        id: '1',
        doctorId: '1',
        doctorName: 'Dr. Steward',
        doctorSpecialty: 'Dentist',
        doctorImagePath: 'assets/images/MedicalCenterImages/Rectangle 1512.png',
        day: 'Sun',
        time: '10:00PM - 12:00PM',
        location: '2140 Westwood Blvd, Los Angeles, CA 90025, USA',
        appointmentDate: DateTime.now().add(const Duration(days: 2)),
        isCompleted: false,
      ),
      AppointmentModel(
        id: '2',
        doctorId: '2',
        doctorName: 'Dr. Zoya',
        doctorSpecialty: 'Cardiologist',
        doctorImagePath: 'assets/images/MedicalCenterImages/Rectangle 1513.png',
        day: 'Sun',
        time: '10:00PM - 12:00PM',
        location: '2140 Westwood Blvd, Los Angeles, CA 90025, USA',
        appointmentDate: DateTime.now().add(const Duration(days: 5)),
        isCompleted: false,
      ),
      AppointmentModel(
        id: '3',
        doctorId: '3',
        doctorName: 'Dr. Andrew Collins',
        doctorSpecialty: 'Orthopedic Surgeon',
        doctorImagePath: 'assets/images/MedicalCenterImages/Rectangle 1494.png',
        day: 'Sun',
        time: '10:00PM - 12:00PM',
        location: '2140 Westwood Blvd, Los Angeles, CA 90025, USA',
        appointmentDate: DateTime.now().add(const Duration(days: 7)),
        isCompleted: false,
      ),
      // Previous appointments
      AppointmentModel(
        id: '4',
        doctorId: '4',
        doctorName: 'Dr. Maria Khan',
        doctorSpecialty: 'Dentist',
        doctorImagePath: 'assets/images/DoctorImages/doctor1.png',
        day: 'Mon',
        time: '09:00AM - 10:00AM',
        location: '2140 Westwood Blvd, Los Angeles, CA 90025, USA',
        appointmentDate: DateTime.now().subtract(const Duration(days: 5)),
        isCompleted: true,
      ),
      AppointmentModel(
        id: '5',
        doctorId: '5',
        doctorName: 'Dr. Ahmed Ali',
        doctorSpecialty: 'Surgeon',
        doctorImagePath: 'assets/images/DoctorImages/doctor2.png',
        day: 'Tue',
        time: '02:00PM - 03:00PM',
        location: '2140 Westwood Blvd, Los Angeles, CA 90025, USA',
        appointmentDate: DateTime.now().subtract(const Duration(days: 10)),
        isCompleted: true,
      ),
    ];
  }
}
