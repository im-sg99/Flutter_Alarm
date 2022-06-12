import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

enum AlarmType {
  quick,
  normal,
}

enum TurnAlarm {
  on,
  off,
}

enum StateAlarm {
  active,
  inactive,
  nothing
}

class Alarm {
  int id;  // 알람이 저장된 순서
  int type; // 알람 타입 (퀵 알람 or 일반 알람)
  String time; // 퀵 알람이 울려야 할 시간
  int state;  // 알람이 켜져있는지, 꺼져있는지
  String label;

  Alarm({
    required this.id,
    required this.type,
    required this.time,
    required this.state,
    this.label = ' ',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'time': time,
      'state': state,
      'label': label,
    };
  }

  @override
  String toString() {
    return 'Alarm{id: $id, type: $type, time: $time, state: $state, label: $label}';
  }
}

class AlarmDB {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'alarm_database.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE ALARM_TB(id INTEGER PRIMARY KEY, type INTEGER, time TEXT, state INTEGER, label TEXT)');
      },
      version: 1,
    );
    return _db;
  }

  // 데이터베이스 CRUD
  // Create
  Future<void> insertAlarm(Alarm alarm) async {
    final db = await database;

    await db.insert(
      'ALARM_TB',
      alarm.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  Future<List<Alarm>> read() async {
    final db = await database;

    // final List<Map<String, dynamic>> maps = await db.query('ALARM_TB');
    // final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM ALARM_TB ORDER BY id DESC');
    final List<Map<String, dynamic>> maps = await db.query('ALARM_TB', orderBy: "id DESC");

    return List.generate(maps.length, (i) {
      return Alarm(
        id: maps[i]['id'],
        type: maps[i]['type'],
        time: maps[i]['time'],
        state: maps[i]['state'],
        label: maps[i]['label'],
      );
    });
    
  }

  // Update
  Future<void> updateAlarm(Alarm alarm) async {
    final db = await database;

    await db.update(
      'ALARM_TB',
      alarm.toMap(),
      where: "id = ?",
      whereArgs: [alarm.id],
    );
  }

  // Delete
  Future<void> deleteAlarm(int id) async {
    final db = await database;

    await db.delete(
      'ALARM_TB',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> reset() async {
    final db = await database;

    await db.execute('DROP TABLE IF EXISTS ALARM_TB');
    await db.execute('CREATE TABLE ALARM_TB(id INTEGER PRIMARY KEY, type INTEGER, time TEXT, state INTEGER, label TEXT)');
    print('No problem');
  }
}