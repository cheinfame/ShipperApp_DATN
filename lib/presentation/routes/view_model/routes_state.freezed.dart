// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routes_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RoutesState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<Route> get routes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoutesStateCopyWith<RoutesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutesStateCopyWith<$Res> {
  factory $RoutesStateCopyWith(
          RoutesState value, $Res Function(RoutesState) then) =
      _$RoutesStateCopyWithImpl<$Res, RoutesState>;
  @useResult
  $Res call({bool isLoading, List<Route> routes});
}

/// @nodoc
class _$RoutesStateCopyWithImpl<$Res, $Val extends RoutesState>
    implements $RoutesStateCopyWith<$Res> {
  _$RoutesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? routes = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      routes: null == routes
          ? _value.routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<Route>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoutesStateImplCopyWith<$Res>
    implements $RoutesStateCopyWith<$Res> {
  factory _$$RoutesStateImplCopyWith(
          _$RoutesStateImpl value, $Res Function(_$RoutesStateImpl) then) =
      __$$RoutesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<Route> routes});
}

/// @nodoc
class __$$RoutesStateImplCopyWithImpl<$Res>
    extends _$RoutesStateCopyWithImpl<$Res, _$RoutesStateImpl>
    implements _$$RoutesStateImplCopyWith<$Res> {
  __$$RoutesStateImplCopyWithImpl(
      _$RoutesStateImpl _value, $Res Function(_$RoutesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? routes = null,
  }) {
    return _then(_$RoutesStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      routes: null == routes
          ? _value._routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<Route>,
    ));
  }
}

/// @nodoc

class _$RoutesStateImpl implements _RoutesState {
  const _$RoutesStateImpl(
      {this.isLoading = false, final List<Route> routes = const []})
      : _routes = routes;

  @override
  @JsonKey()
  final bool isLoading;
  final List<Route> _routes;
  @override
  @JsonKey()
  List<Route> get routes {
    if (_routes is EqualUnmodifiableListView) return _routes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routes);
  }

  @override
  String toString() {
    return 'RoutesState(isLoading: $isLoading, routes: $routes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutesStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._routes, _routes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_routes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutesStateImplCopyWith<_$RoutesStateImpl> get copyWith =>
      __$$RoutesStateImplCopyWithImpl<_$RoutesStateImpl>(this, _$identity);
}

abstract class _RoutesState implements RoutesState {
  const factory _RoutesState({final bool isLoading, final List<Route> routes}) =
      _$RoutesStateImpl;

  @override
  bool get isLoading;
  @override
  List<Route> get routes;
  @override
  @JsonKey(ignore: true)
  _$$RoutesStateImplCopyWith<_$RoutesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
