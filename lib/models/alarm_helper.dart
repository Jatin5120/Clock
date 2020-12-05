import 'package:clock_app/data/data.dart';
import 'package:clock_app/models/models.dart';
import 'package:sqflite/sqflite.dart';

final String tableAlarm = 'alarm';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';

class AlarmHelper {
  static Database _database;
  static AlarmHelper _alarmHelper;

  AlarmHelper._createInstance();

  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
    }
    return _alarmHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    alarms.clear();
    String dir = await getDatabasesPath();
    String path = dir + '/alarm.db';
    print(path);

    Database db =
        await openDatabase(
            path,
            version: 1,
            onCreate: (db, version) {
              db.execute('''
              create table $tableAlarm (
              $columnId integer primary key autoincrement,
              $columnTitle text not null,
              $columnDateTime text not null,
              $columnPending integer,
              $columnColorIndex integer)
              ''');
            },
        );
    List<Map<String, dynamic>> result = await db.query(tableAlarm);
    result.forEach((alarm) {
      AlarmInfo alarmInfo = AlarmInfo.fromMap(alarm);
      alarms.add(alarmInfo);
    });
    return db;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    Database db = await this.database;
    int result = await db.insert(tableAlarm, alarmInfo.toMap());
    alarms.add(alarmInfo);
    print("\nResult : $result");
  }

  Future<int> deleteAlarm(int id) async {
    Database db = await this.database;
    alarms.removeWhere((alarmInfo) => alarmInfo.id == id);
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = <AlarmInfo>[];

    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.query(tableAlarm);
    result.forEach((alarm) {
      AlarmInfo alarmInfo = AlarmInfo.fromMap(alarm);
      _alarms.add(alarmInfo);
    });
    return _alarms;
  }
}
