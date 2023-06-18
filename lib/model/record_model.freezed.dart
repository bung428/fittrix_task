// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RecordModel _$RecordModelFromJson(Map<String, dynamic> json) {
  return _RecordModel.fromJson(json);
}

/// @nodoc
mixin _$RecordModel {
  String get date => throw _privateConstructorUsedError;
  String get msg => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get user_id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordModelCopyWith<RecordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordModelCopyWith<$Res> {
  factory $RecordModelCopyWith(
          RecordModel value, $Res Function(RecordModel) then) =
      _$RecordModelCopyWithImpl<$Res, RecordModel>;
  @useResult
  $Res call({String date, String msg, String type, String id, String user_id});
}

/// @nodoc
class _$RecordModelCopyWithImpl<$Res, $Val extends RecordModel>
    implements $RecordModelCopyWith<$Res> {
  _$RecordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? msg = null,
    Object? type = null,
    Object? id = null,
    Object? user_id = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecordModelCopyWith<$Res>
    implements $RecordModelCopyWith<$Res> {
  factory _$$_RecordModelCopyWith(
          _$_RecordModel value, $Res Function(_$_RecordModel) then) =
      __$$_RecordModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, String msg, String type, String id, String user_id});
}

/// @nodoc
class __$$_RecordModelCopyWithImpl<$Res>
    extends _$RecordModelCopyWithImpl<$Res, _$_RecordModel>
    implements _$$_RecordModelCopyWith<$Res> {
  __$$_RecordModelCopyWithImpl(
      _$_RecordModel _value, $Res Function(_$_RecordModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? msg = null,
    Object? type = null,
    Object? id = null,
    Object? user_id = null,
  }) {
    return _then(_$_RecordModel(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RecordModel implements _RecordModel {
  _$_RecordModel(
      {required this.date,
      required this.msg,
      required this.type,
      required this.id,
      required this.user_id});

  factory _$_RecordModel.fromJson(Map<String, dynamic> json) =>
      _$$_RecordModelFromJson(json);

  @override
  final String date;
  @override
  final String msg;
  @override
  final String type;
  @override
  final String id;
  @override
  final String user_id;

  @override
  String toString() {
    return 'RecordModel(date: $date, msg: $msg, type: $type, id: $id, user_id: $user_id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecordModel &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, msg, type, id, user_id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecordModelCopyWith<_$_RecordModel> get copyWith =>
      __$$_RecordModelCopyWithImpl<_$_RecordModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecordModelToJson(
      this,
    );
  }
}

abstract class _RecordModel implements RecordModel {
  factory _RecordModel(
      {required final String date,
      required final String msg,
      required final String type,
      required final String id,
      required final String user_id}) = _$_RecordModel;

  factory _RecordModel.fromJson(Map<String, dynamic> json) =
      _$_RecordModel.fromJson;

  @override
  String get date;
  @override
  String get msg;
  @override
  String get type;
  @override
  String get id;
  @override
  String get user_id;
  @override
  @JsonKey(ignore: true)
  _$$_RecordModelCopyWith<_$_RecordModel> get copyWith =>
      throw _privateConstructorUsedError;
}
