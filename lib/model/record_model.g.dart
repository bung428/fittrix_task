// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RecordModel _$$_RecordModelFromJson(Map<String, dynamic> json) =>
    _$_RecordModel(
      date: json['date'] as String,
      msg: json['msg'] as String,
      type: json['type'] as String,
      id: json['id'] as String,
      user_id: json['user_id'] as String,
    );

Map<String, dynamic> _$$_RecordModelToJson(_$_RecordModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'msg': instance.msg,
      'type': instance.type,
      'id': instance.id,
      'user_id': instance.user_id,
    };
