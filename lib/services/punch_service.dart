import 'package:hive/hive.dart';
import '../models/punch_record.dart';

class PunchService {
  static const String _boxName = 'punch_records';
  late Box<PunchRecord> _box;

  Future<void> init() async {
    _box = await Hive.openBox<PunchRecord>(_boxName);
  }

  Future<int> savePunch(PunchRecord punch) async {
    return await _box.add(punch);
  }

  List<PunchRecord> getAllPunches() {
    return _box.values.toList().reversed.toList();
  }

  PunchRecord? getPunchAt(int index) {
    if (index >= 0 && index < _box.length) {
      return _box.getAt(index);
    }
    return null;
  }

  Future<void> deletePunch(int index) async {
    if (index >= 0 && index < _box.length) {
      await _box.deleteAt(index);
    }
  }

  Future<void> updatePunch(int index, PunchRecord punch) async {
    if (index >= 0 && index < _box.length) {
      await _box.putAt(index, punch);
    }
  }

  Future<void> clearAll() async {
    await _box.clear();
  }

  int getTotalPunches() {
    return _box.length;
  }

  Future<void> close() async {
    await _box.close();
  }
}
