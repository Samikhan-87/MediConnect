import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/notification_model.dart';
import 'database_helper.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final Uuid _uuid = const Uuid();

  // Create a notification when appointment is booked
  Future<NotificationModel> createBookingNotification({
    required String doctorName,
    required String appointmentId,
    required String appointmentDate,
    required String appointmentTime,
    String? userId,
  }) async {
    final notification = NotificationModel(
      id: _uuid.v4(),
      title: 'Appointment Booked',
      message:
          'Your appointment with Dr. $doctorName has been scheduled for $appointmentDate at $appointmentTime.',
      type: 'booking',
      createdAt: DateTime.now(),
      isRead: false,
      appointmentId: appointmentId,
      doctorName: doctorName,
    );

    await _saveNotification(notification, userId);
    return notification;
  }

  // Create a notification when appointment is cancelled
  Future<NotificationModel> createCancellationNotification({
    required String doctorName,
    required String appointmentId,
    String? userId,
  }) async {
    final notification = NotificationModel(
      id: _uuid.v4(),
      title: 'Appointment Cancelled',
      message: 'Your appointment with Dr. $doctorName has been cancelled.',
      type: 'cancellation',
      createdAt: DateTime.now(),
      isRead: false,
      appointmentId: appointmentId,
      doctorName: doctorName,
    );

    await _saveNotification(notification, userId);
    return notification;
  }

  // Create a reminder notification
  Future<NotificationModel> createReminderNotification({
    required String doctorName,
    required String appointmentId,
    required String appointmentDate,
    required String appointmentTime,
    String? userId,
  }) async {
    final notification = NotificationModel(
      id: _uuid.v4(),
      title: 'Appointment Reminder',
      message:
          'Reminder: You have an appointment with Dr. $doctorName tomorrow at $appointmentTime.',
      type: 'reminder',
      createdAt: DateTime.now(),
      isRead: false,
      appointmentId: appointmentId,
      doctorName: doctorName,
    );

    await _saveNotification(notification, userId);
    return notification;
  }

  // Save notification to database
  Future<void> _saveNotification(
      NotificationModel notification, String? userId) async {
    try {
      final db = await _dbHelper.database;
      final data = notification.toMap();
      data['userId'] = userId;

      await db.insert('notifications', data);
      debugPrint('Notification saved: ${notification.title}');
    } catch (e) {
      debugPrint('Error saving notification: $e');
      rethrow;
    }
  }

  // Get all notifications for a user
  Future<List<NotificationModel>> getNotifications({String? userId}) async {
    try {
      final db = await _dbHelper.database;

      List<Map<String, dynamic>> results;
      if (userId != null) {
        results = await db.query(
          'notifications',
          where: 'userId = ?',
          whereArgs: [userId],
          orderBy: 'createdAt DESC',
        );
      } else {
        results = await db.query(
          'notifications',
          orderBy: 'createdAt DESC',
        );
      }

      return results.map((map) => NotificationModel.fromMap(map)).toList();
    } catch (e) {
      debugPrint('Error getting notifications: $e');
      return [];
    }
  }

  // Get unread notifications count
  Future<int> getUnreadCount({String? userId}) async {
    try {
      final db = await _dbHelper.database;

      List<Map<String, dynamic>> results;
      if (userId != null) {
        results = await db.rawQuery(
          'SELECT COUNT(*) as count FROM notifications WHERE userId = ? AND isRead = 0',
          [userId],
        );
      } else {
        results = await db.rawQuery(
          'SELECT COUNT(*) as count FROM notifications WHERE isRead = 0',
        );
      }

      return results.first['count'] as int;
    } catch (e) {
      debugPrint('Error getting unread count: $e');
      return 0;
    }
  }

  // Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      final db = await _dbHelper.database;
      await db.update(
        'notifications',
        {'isRead': 1},
        where: 'id = ?',
        whereArgs: [notificationId],
      );
      debugPrint('Notification marked as read: $notificationId');
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
    }
  }

  // Mark all notifications as read
  Future<void> markAllAsRead({String? userId}) async {
    try {
      final db = await _dbHelper.database;

      if (userId != null) {
        await db.update(
          'notifications',
          {'isRead': 1},
          where: 'userId = ?',
          whereArgs: [userId],
        );
      } else {
        await db.update(
          'notifications',
          {'isRead': 1},
        );
      }
      debugPrint('All notifications marked as read');
    } catch (e) {
      debugPrint('Error marking all notifications as read: $e');
    }
  }

  // Delete a notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      final db = await _dbHelper.database;
      await db.delete(
        'notifications',
        where: 'id = ?',
        whereArgs: [notificationId],
      );
      debugPrint('Notification deleted: $notificationId');
    } catch (e) {
      debugPrint('Error deleting notification: $e');
    }
  }

  // Delete all notifications
  Future<void> deleteAllNotifications({String? userId}) async {
    try {
      final db = await _dbHelper.database;

      if (userId != null) {
        await db.delete(
          'notifications',
          where: 'userId = ?',
          whereArgs: [userId],
        );
      } else {
        await db.delete('notifications');
      }
      debugPrint('All notifications deleted');
    } catch (e) {
      debugPrint('Error deleting all notifications: $e');
    }
  }
}
