// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ExerciseRecord _$ExerciseRecordFromJson(Map<String, dynamic> json) {
  return _ExerciseRecord.fromJson(json);
}

/// @nodoc
mixin _$ExerciseRecord {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get exerciseType =>
      throw _privateConstructorUsedError; // ウォーキング、ランニング等
  int get durationMinutes => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ExerciseRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExerciseRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseRecordCopyWith<ExerciseRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseRecordCopyWith<$Res> {
  factory $ExerciseRecordCopyWith(
    ExerciseRecord value,
    $Res Function(ExerciseRecord) then,
  ) = _$ExerciseRecordCopyWithImpl<$Res, ExerciseRecord>;
  @useResult
  $Res call({
    String id,
    DateTime date,
    String exerciseType,
    int durationMinutes,
    String? note,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$ExerciseRecordCopyWithImpl<$Res, $Val extends ExerciseRecord>
    implements $ExerciseRecordCopyWith<$Res> {
  _$ExerciseRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExerciseRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? exerciseType = null,
    Object? durationMinutes = null,
    Object? note = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            exerciseType: null == exerciseType
                ? _value.exerciseType
                : exerciseType // ignore: cast_nullable_to_non_nullable
                      as String,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExerciseRecordImplCopyWith<$Res>
    implements $ExerciseRecordCopyWith<$Res> {
  factory _$$ExerciseRecordImplCopyWith(
    _$ExerciseRecordImpl value,
    $Res Function(_$ExerciseRecordImpl) then,
  ) = __$$ExerciseRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime date,
    String exerciseType,
    int durationMinutes,
    String? note,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$ExerciseRecordImplCopyWithImpl<$Res>
    extends _$ExerciseRecordCopyWithImpl<$Res, _$ExerciseRecordImpl>
    implements _$$ExerciseRecordImplCopyWith<$Res> {
  __$$ExerciseRecordImplCopyWithImpl(
    _$ExerciseRecordImpl _value,
    $Res Function(_$ExerciseRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExerciseRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? exerciseType = null,
    Object? durationMinutes = null,
    Object? note = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$ExerciseRecordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        exerciseType: null == exerciseType
            ? _value.exerciseType
            : exerciseType // ignore: cast_nullable_to_non_nullable
                  as String,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseRecordImpl implements _ExerciseRecord {
  const _$ExerciseRecordImpl({
    required this.id,
    required this.date,
    required this.exerciseType,
    required this.durationMinutes,
    this.note,
    this.createdAt,
  });

  factory _$ExerciseRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseRecordImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final String exerciseType;
  // ウォーキング、ランニング等
  @override
  final int durationMinutes;
  @override
  final String? note;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ExerciseRecord(id: $id, date: $date, exerciseType: $exerciseType, durationMinutes: $durationMinutes, note: $note, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.exerciseType, exerciseType) ||
                other.exerciseType == exerciseType) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    exerciseType,
    durationMinutes,
    note,
    createdAt,
  );

  /// Create a copy of ExerciseRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseRecordImplCopyWith<_$ExerciseRecordImpl> get copyWith =>
      __$$ExerciseRecordImplCopyWithImpl<_$ExerciseRecordImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseRecordImplToJson(this);
  }
}

abstract class _ExerciseRecord implements ExerciseRecord {
  const factory _ExerciseRecord({
    required final String id,
    required final DateTime date,
    required final String exerciseType,
    required final int durationMinutes,
    final String? note,
    final DateTime? createdAt,
  }) = _$ExerciseRecordImpl;

  factory _ExerciseRecord.fromJson(Map<String, dynamic> json) =
      _$ExerciseRecordImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  String get exerciseType; // ウォーキング、ランニング等
  @override
  int get durationMinutes;
  @override
  String? get note;
  @override
  DateTime? get createdAt;

  /// Create a copy of ExerciseRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseRecordImplCopyWith<_$ExerciseRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
