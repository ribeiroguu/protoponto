part of 'punch_record.dart';


class PunchRecordAdapter extends TypeAdapter<PunchRecord> {
  @override
  final int typeId = 0;

  @override
  PunchRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PunchRecord(
      project: fields[0] as String,
      developed: fields[1] as String,
      description: fields[2] as String,
      totalHours: fields[3] as String,
      timestamp: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PunchRecord obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.project)
      ..writeByte(1)
      ..write(obj.developed)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.totalHours)
      ..writeByte(4)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PunchRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
