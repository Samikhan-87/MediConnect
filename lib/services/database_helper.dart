import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static const int _dbVersion = 4; // Increment this to add notifications table

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mediconnect.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    debugPrint('Database path: $path');

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint('Upgrading database from $oldVersion to $newVersion');
    // Drop and recreate tables for schema changes
    await db.execute('DROP TABLE IF EXISTS appointments');
    await db.execute('DROP TABLE IF EXISTS doctors');
    await db.execute('DROP TABLE IF EXISTS medical_centers');
    await db.execute('DROP TABLE IF EXISTS notifications');
    await _createDB(db, newVersion);
  }

  Future<void> _createDB(Database db, int version) async {
    debugPrint('Creating database tables...');

    // Create doctors table
    await db.execute('''
      CREATE TABLE doctors (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        specialty TEXT NOT NULL,
        description TEXT,
        rating REAL,
        imagePath TEXT,
        experienceYears INTEGER
      )
    ''');

    // Create appointments table
    await db.execute('''
      CREATE TABLE appointments (
        id TEXT PRIMARY KEY,
        doctorId TEXT NOT NULL,
        doctorName TEXT NOT NULL,
        doctorSpecialty TEXT,
        doctorImagePath TEXT,
        day TEXT,
        time TEXT,
        location TEXT,
        appointmentDate TEXT,
        isCompleted INTEGER DEFAULT 0,
        userId TEXT,
        FOREIGN KEY (doctorId) REFERENCES doctors (id)
      )
    ''');

    // Create medical centers table
    await db.execute('''
      CREATE TABLE medical_centers (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        address TEXT,
        rating REAL,
        imagePath TEXT,
        distance TEXT
      )
    ''');

    // Create notifications table
    await db.execute('''
      CREATE TABLE notifications (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        message TEXT NOT NULL,
        type TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        isRead INTEGER DEFAULT 0,
        appointmentId TEXT,
        doctorName TEXT,
        userId TEXT
      )
    ''');
  }

  // ==================== DOCTORS ====================

  Future<int> insertDoctor(Map<String, dynamic> doctor) async {
    final db = await database;
    return await db.insert(
      'doctors',
      doctor,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertDoctors(List<Map<String, dynamic>> doctors) async {
    final db = await database;
    final batch = db.batch();
    for (var doctor in doctors) {
      batch.insert('doctors', doctor,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getAllDoctors() async {
    final db = await database;
    return await db.query('doctors', orderBy: 'rating DESC');
  }

  Future<Map<String, dynamic>?> getDoctorById(String id) async {
    final db = await database;
    final results = await db.query(
      'doctors',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<List<Map<String, dynamic>>> getDoctorsBySpecialty(
      String specialty) async {
    final db = await database;
    return await db.query(
      'doctors',
      where: 'specialty = ?',
      whereArgs: [specialty],
    );
  }

  Future<List<Map<String, dynamic>>> searchDoctors(String query) async {
    final db = await database;
    return await db.query(
      'doctors',
      where: 'name LIKE ? OR specialty LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
  }

  // ==================== APPOINTMENTS ====================

  Future<int> insertAppointment(Map<String, dynamic> appointment) async {
    final db = await database;
    return await db.insert(
      'appointments',
      appointment,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllAppointments(
      {String? userId}) async {
    final db = await database;
    if (userId != null) {
      return await db.query(
        'appointments',
        where: 'userId = ?',
        whereArgs: [userId],
        orderBy: 'appointmentDate DESC',
      );
    }
    return await db.query('appointments', orderBy: 'appointmentDate DESC');
  }

  Future<List<Map<String, dynamic>>> getCurrentAppointments(
      {String? userId}) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();

    if (userId != null) {
      return await db.query(
        'appointments',
        where: 'userId = ? AND appointmentDate > ? AND isCompleted = 0',
        whereArgs: [userId, now],
        orderBy: 'appointmentDate ASC',
      );
    }
    return await db.query(
      'appointments',
      where: 'appointmentDate > ? AND isCompleted = 0',
      whereArgs: [now],
      orderBy: 'appointmentDate ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getPreviousAppointments(
      {String? userId}) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();

    if (userId != null) {
      return await db.query(
        'appointments',
        where: 'userId = ? AND (appointmentDate <= ? OR isCompleted = 1)',
        whereArgs: [userId, now],
        orderBy: 'appointmentDate DESC',
      );
    }
    return await db.query(
      'appointments',
      where: 'appointmentDate <= ? OR isCompleted = 1',
      whereArgs: [now],
      orderBy: 'appointmentDate DESC',
    );
  }

  Future<int> updateAppointment(
      String id, Map<String, dynamic> appointment) async {
    final db = await database;
    return await db.update(
      'appointments',
      appointment,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAppointment(String id) async {
    final db = await database;
    return await db.delete(
      'appointments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> markAppointmentCompleted(String id) async {
    final db = await database;
    return await db.update(
      'appointments',
      {'isCompleted': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==================== MEDICAL CENTERS ====================

  Future<int> insertMedicalCenter(Map<String, dynamic> center) async {
    final db = await database;
    return await db.insert(
      'medical_centers',
      center,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertMedicalCenters(List<Map<String, dynamic>> centers) async {
    final db = await database;
    final batch = db.batch();
    for (var center in centers) {
      batch.insert('medical_centers', center,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getAllMedicalCenters() async {
    final db = await database;
    return await db.query('medical_centers', orderBy: 'rating DESC');
  }

  // ==================== UTILITY ====================

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('doctors');
    await db.delete('appointments');
    await db.delete('medical_centers');
  }

  // Delete and recreate database (for fixing schema issues)
  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mediconnect.db');

    // Close existing connection
    if (_database != null) {
      await _database!.close();
      _database = null;
    }

    // Delete the database file
    await deleteDatabase(path);
    debugPrint('Database deleted, will be recreated on next access');

    // Recreate by accessing database
    await database;
    debugPrint('Database recreated successfully');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
