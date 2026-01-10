class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type; // 'confirmed', 'canceled', etc.
  final DateTime createdAt;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.isRead = false,
  });

  static List<NotificationModel> getNotifications() {
    return [
      NotificationModel(
        id: '1',
        title: 'Appointment Confirmed',
        message:
            "Your appointment request has been approved. You're all set for your visit!",
        type: 'confirmed',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        title: 'Appointment Canceled',
        message:
            "Your appointment has been canceled. Please book a new time that works for you.",
        type: 'canceled',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isRead: false,
      ),
    ];
  }
}
