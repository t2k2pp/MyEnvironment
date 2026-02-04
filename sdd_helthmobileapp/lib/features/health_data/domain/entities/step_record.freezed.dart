// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'step_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StepRecord _$StepRecordFromJson(Map<String, dynamic> json) {
  return _StepRecord.fromJson(json);
}

/// @nodoc
mixin _$StepRecord {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get steps => throw _privateConstructorUsedError;
  bool get isAutoSync => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this StepRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StepRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StepRecordCopyWith<StepRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StepRecordCopyWith<$Res> {
  factory $StepRecordCopyWith(
    StepRecord value,
    $Res Function(StepRecord) then,
  ) = _$StepRecordCopyWithImpl<$Res, StepRecord>;
  @useResult
  $Res call({
    String id,
    DateTime date,
    int steps,
    bool isAutoSync,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$StepRecordCopyWithImpl<$Res, $Val extends StepRecord>
    implements $StepRecordCopyWith<$Res> {
  _$StepRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StepRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? steps = null,
    Object? isAutoSync = null,
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
            steps: null == steps
                ? _value.steps
                : steps // ignore: cast_nullable_to_non_nullable
                      as int,
            isAutoSync: null == isAutoSync
                ? _value.isAutoSync
                : isAutoSync // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$StepRecordImplCopyWith<$Res>
    implements $StepRecordCopyWith<$Res> {
  factory _$$StepRecordImplCopyWith(
    _$StepRecordImpl value,
    $Res Function(_$StepRecordImpl) then,
  ) = __$$StepRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime date,
    int steps,
    bool isAutoSync,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$StepRecordImplCopyWithImpl<$Res>
    extends _$StepRecordCopyWithImpl<$Res, _$StepRecordImpl>
    implements _$$StepRecordImplCopyWith<$Res> {
  __$$StepRecordImplCopyWithImpl(
    _$StepRecordImpl _value,
    $Res Function(_$StepRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StepRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? steps = null,
    Object? isAutoSync = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$StepRecordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        steps: null == steps
            ? _value.steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as int,
        isAutoSync: null == isAutoSync
            ? _value.isAutoSync
            : isAutoSync // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$StepRecordImpl implements _StepRecord {
  const _$StepRecordImpl({
    required this.id,
    required this.date,
    required this.steps,
    this.isAutoSync = false,
    this.createdAt,
  });

  factory _$StepRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$StepRecordImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final int steps;
  @override
  @JsonKey()
  final bool isAutoSync;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'StepRecord(id: $id, date: $date, steps: $steps, isAutoSync: $isAutoSync, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StepRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.isAutoSync, isAutoSync) ||
                other.isAutoSync == isAutoSync) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, date, steps, isAutoSync, createdAt);

  /// Create a copy of StepRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StepRecordImplCopyWith<_$StepRecordImpl> get copyWith =>
      __$$StepRecordImplCopyWithImpl<_$StepRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StepRecordImplToJson(this);
  }
}

abstract class _StepRecord implements StepRecord {
  const factory _StepRecord({
    required final String id,
    required final DateTime date,
    required final int steps,
    final bool isAutoSync,
    final DateTime? createdAt,
  }) = _$StepRecordImpl;

  factory _StepRecord.fromJson(Map<String, dynamic> json) =
      _$StepRecordImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  int get steps;
  @override
  bool get isAutoSync;
  @override
  DateTime? get createdAt;

  /// Create a copy of StepRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StepRecordImplCopyWith<_$StepRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
