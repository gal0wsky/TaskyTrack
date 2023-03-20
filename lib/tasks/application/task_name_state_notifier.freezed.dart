// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_name_state_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaskNameState {
  String? get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskNameStateCopyWith<TaskNameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskNameStateCopyWith<$Res> {
  factory $TaskNameStateCopyWith(
          TaskNameState value, $Res Function(TaskNameState) then) =
      _$TaskNameStateCopyWithImpl<$Res, TaskNameState>;
  @useResult
  $Res call({String? name});
}

/// @nodoc
class _$TaskNameStateCopyWithImpl<$Res, $Val extends TaskNameState>
    implements $TaskNameStateCopyWith<$Res> {
  _$TaskNameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskNameStateCopyWith<$Res>
    implements $TaskNameStateCopyWith<$Res> {
  factory _$$_TaskNameStateCopyWith(
          _$_TaskNameState value, $Res Function(_$_TaskNameState) then) =
      __$$_TaskNameStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name});
}

/// @nodoc
class __$$_TaskNameStateCopyWithImpl<$Res>
    extends _$TaskNameStateCopyWithImpl<$Res, _$_TaskNameState>
    implements _$$_TaskNameStateCopyWith<$Res> {
  __$$_TaskNameStateCopyWithImpl(
      _$_TaskNameState _value, $Res Function(_$_TaskNameState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$_TaskNameState(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_TaskNameState extends _TaskNameState {
  const _$_TaskNameState({this.name = ""}) : super._();

  @override
  @JsonKey()
  final String? name;

  @override
  String toString() {
    return 'TaskNameState(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskNameState &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskNameStateCopyWith<_$_TaskNameState> get copyWith =>
      __$$_TaskNameStateCopyWithImpl<_$_TaskNameState>(this, _$identity);
}

abstract class _TaskNameState extends TaskNameState {
  const factory _TaskNameState({final String? name}) = _$_TaskNameState;
  const _TaskNameState._() : super._();

  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_TaskNameStateCopyWith<_$_TaskNameState> get copyWith =>
      throw _privateConstructorUsedError;
}
