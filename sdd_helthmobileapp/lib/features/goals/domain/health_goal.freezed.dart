// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HealthGoal _$HealthGoalFromJson(Map<String, dynamic> json) {
  return _HealthGoal.fromJson(json);
}

/// @nodoc
mixin _$HealthGoal {
  String get id => throw _privateConstructorUsedError;
  GoalType get type => throw _privateConstructorUsedError;
  double get targetValue => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this HealthGoal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthGoalCopyWith<HealthGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthGoalCopyWith<$Res> {
  factory $HealthGoalCopyWith(
    HealthGoal value,
    $Res Function(HealthGoal) then,
  ) = _$HealthGoalCopyWithImpl<$Res, HealthGoal>;
  @useResult
  $Res call({
    String id,
    GoalType type,
    double targetValue,
    DateTime startDate,
    DateTime? endDate,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$HealthGoalCopyWithImpl<$Res, $Val extends HealthGoal>
    implements $HealthGoalCopyWith<$Res> {
  _$HealthGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? targetValue = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as GoalType,
            targetValue: null == targetValue
                ? _value.targetValue
                : targetValue // ignore: cast_nullable_to_non_nullable
                      as double,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
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
abstract class _$$HealthGoalImplCopyWith<$Res>
    implements $HealthGoalCopyWith<$Res> {
  factory _$$HealthGoalImplCopyWith(
    _$HealthGoalImpl value,
    $Res Function(_$HealthGoalImpl) then,
  ) = __$$HealthGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    GoalType type,
    double targetValue,
    DateTime startDate,
    DateTime? endDate,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$HealthGoalImplCopyWithImpl<$Res>
    extends _$HealthGoalCopyWithImpl<$Res, _$HealthGoalImpl>
    implements _$$HealthGoalImplCopyWith<$Res> {
  __$$HealthGoalImplCopyWithImpl(
    _$HealthGoalImpl _value,
    $Res Function(_$HealthGoalImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HealthGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? targetValue = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$HealthGoalImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as GoalType,
        targetValue: null == targetValue
            ? _value.targetValue
            : targetValue // ignore: cast_nullable_to_non_nullable
                  as double,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
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
class _$HealthGoalImpl implements _HealthGoal {
  const _$HealthGoalImpl({
    required this.id,
    required this.type,
    required this.targetValue,
    required this.startDate,
    this.endDate,
    this.createdAt,
  });

  factory _$HealthGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthGoalImplFromJson(json);

  @override
  final String id;
  @override
  final GoalType type;
  @override
  final double targetValue;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'HealthGoal(id: $id, type: $type, targetValue: $targetValue, startDate: $startDate, endDate: $endDate, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthGoalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    targetValue,
    startDate,
    endDate,
    createdAt,
  );

  /// Create a copy of HealthGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthGoalImplCopyWith<_$HealthGoalImpl> get copyWith =>
      __$$HealthGoalImplCopyWithImpl<_$HealthGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthGoalImplToJson(this);
  }
}

abstract class _HealthGoal implements HealthGoal {
  const factory _HealthGoal({
    required final String id,
    required final GoalType type,
    required final double targetValue,
    required final DateTime startDate,
    final DateTime? endDate,
    final DateTime? createdAt,
  }) = _$HealthGoalImpl;

  factory _HealthGoal.fromJson(Map<String, dynamic> json) =
      _$HealthGoalImpl.fromJson;

  @override
  String get id;
  @override
  GoalType get type;
  @override
  double get targetValue;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  DateTime? get createdAt;

  /// Create a copy of HealthGoal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthGoalImplCopyWith<_$HealthGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
