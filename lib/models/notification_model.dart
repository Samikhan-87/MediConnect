class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type; // 'confirmed', 'canceled', 'reminder', etc.
  final DateTime createdAt;
  final bool isRead;
  final String? appointmentId;
  final String? doctorName;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.appointmentId,
    this.doctorName,
  });

  // Convert to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead ? 1 : 0,
      'appointmentId': appointmentId,
      'doctorName': doctorName,
    };
  }

  // Create from Map (SQLite)
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      type: map['type'] ?? 'general',
      createdAt: DateTime.parse(map['createdAt']),
      isRead: map['isRead'] == 1,
      appointmentId: map['appointmentId'],
      doctorName: map['doctorName'],
    );
  }

  // Copy with method
  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    DateTime? createdAt,
    bool? isRead,
    String? appointmentId,
    String? doctorName,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      appointmentId: appointmentId ?? this.appointmentId,
      doctorName: doctorName ?? this.doctorName,
    );
  }

  // Sample notifications (for fallback/testing)
  static List<NotificationModel> getNotifications() {
    return [];
  }
}
