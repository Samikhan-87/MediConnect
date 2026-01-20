import 'package:flutter/foundation.dart';
import 'package:mediconnect/models/appointment_model.dart';
import 'package:mediconnect/services/database_helper.dart';
import 'package:mediconnect/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentService extends ChangeNotifier {
  static final AppointmentService _instance = AppointmentService._internal();
  factory AppointmentService() => _instance;
  AppointmentService._internal();

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final NotificationService _notificationService = NotificationService();

  List<AppointmentModel> _currentAppointments = [];
  List<AppointmentModel> _previousAppointments = [];
  bool _isLoading = false;

  List<AppointmentModel> get currentAppointments => _currentAppointments;
  List<AppointmentModel> get previousAppointments => _previousAppointments;
  bool get isLoading => _isLoading;

  // Get current user ID from SharedPreferences
  Future<String?> _getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('current_user');
    if (userJson != null) {
      // Extract user ID from stored data
      // Assuming it contains 'uid' field
      return prefs.getString('user_uid') ?? 'default_user';
    }
    return 'default_user';
  }

  // Load all appointments from SQLite
  Future<void> loadAppointments() async {
    _isLoading = true;
    notifyListeners();

    try {
      final userId = await _getCurrentUserId();

      // Load current appointments (upcoming and not completed)
      final currentMaps =
          await _dbHelper.getCurrentAppointments(userId: userId);
      _currentAppointments =
          currentMaps.map((map) => AppointmentModel.fromMap(map)).toList();

      // Load previous appointments (past or cancelled/completed)
      final previousMaps =
          await _dbHelper.getPreviousAppointments(userId: userId);
      _previousAppointments =
          previousMaps.map((map) => AppointmentModel.fromMap(map)).toList();
    } catch (e) {
      debugPrint('Error loading appointments: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Book a new appointment
  Future<bool> bookAppointment(AppointmentModel appointment) async {
    try {
      final userId = await _getCurrentUserId();

      debugPrint('Booking appointment for user: $userId');
      debugPrint('Appointment ID: ${appointment.id}');
      debugPrint('Doctor: ${appointment.doctorName}');

      // Create appointment with user ID
      final appointmentWithUser = AppointmentModel(
        id: appointment.id,
        doctorId: appointment.doctorId,
        doctorName: appointment.doctorName,
        doctorSpecialty: appointment.doctorSpecialty,
        doctorImagePath: appointment.doctorImagePath,
        day: appointment.day,
        time: appointment.time,
        location: appointment.location,
        appointmentDate: appointment.appointmentDate,
        isCompleted: false,
        userId: userId,
      );

      // Insert into SQLite
      final map = appointmentWithUser.toMap();
      debugPrint('Appointment map: $map');

      await _dbHelper.insertAppointment(map);
      debugPrint('Appointment inserted successfully');

      // Create booking notification
      await _notificationService.createBookingNotification(
        doctorName: appointment.doctorName,
        appointmentId: appointment.id,
        appointmentDate: appointment.day ?? 'Scheduled date',
        appointmentTime: appointment.time ?? 'Scheduled time',
        userId: userId,
      );
      debugPrint('Booking notification created');

      // Add to current appointments list
      _currentAppointments.insert(0, appointmentWithUser);

      // Sort by date
      _currentAppointments
          .sort((a, b) => a.appointmentDate.compareTo(b.appointmentDate));

      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      debugPrint('Error booking appointment: $e');
      debugPrint('Stack trace: $stackTrace');
      return false;
    }
  }

  // Cancel an appointment (move to previous)
  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      final userId = await _getCurrentUserId();

      // Find the appointment in current list
      final index =
          _currentAppointments.indexWhere((a) => a.id == appointmentId);

      if (index != -1) {
        final appointment = _currentAppointments[index];

        // Mark as completed/cancelled in SQLite
        await _dbHelper.markAppointmentCompleted(appointmentId);

        // Create cancellation notification
        await _notificationService.createCancellationNotification(
          doctorName: appointment.doctorName,
          appointmentId: appointmentId,
          userId: userId,
        );
        debugPrint('Cancellation notification created');

        // Remove from current list
        _currentAppointments.removeAt(index);

        // Add to previous list with isCompleted = true
        final cancelledAppointment = appointment.copyWith(isCompleted: true);
        _previousAppointments.insert(0, cancelledAppointment);

        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error cancelling appointment: $e');
      return false;
    }
  }

  // Delete appointment permanently (optional)
  Future<bool> deleteAppointment(String appointmentId) async {
    try {
      await _dbHelper.deleteAppointment(appointmentId);

      _currentAppointments.removeWhere((a) => a.id == appointmentId);
      _previousAppointments.removeWhere((a) => a.id == appointmentId);

      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error deleting appointment: $e');
      return false;
    }
  }

  // Get appointment by ID
  AppointmentModel? getAppointmentById(String id) {
    try {
      return _currentAppointments.firstWhere((a) => a.id == id);
    } catch (_) {
      try {
        return _previousAppointments.firstWhere((a) => a.id == id);
      } catch (_) {
        return null;
      }
    }
  }

  // Clear all appointments (for logout)
  Future<void> clearAppointments() async {
    _currentAppointments.clear();
    _previousAppointments.clear();
    notifyListeners();
  }

  // Generate unique appointment ID
  String generateAppointmentId() {
    return 'APT_${DateTime.now().millisecondsSinceEpoch}';
  }
}
