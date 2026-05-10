// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<OrderWithInfo> get availableOrders => throw _privateConstructorUsedError;
  Map<String, String> get routeNamesMap => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<OrderWithInfo> availableOrders,
      Map<String, String> routeNamesMap});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? availableOrders = null,
    Object? routeNamesMap = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      availableOrders: null == availableOrders
          ? _value.availableOrders
          : availableOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderWithInfo>,
      routeNamesMap: null == routeNamesMap
          ? _value.routeNamesMap
          : routeNamesMap // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<OrderWithInfo> availableOrders,
      Map<String, String> routeNamesMap});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? availableOrders = null,
    Object? routeNamesMap = null,
  }) {
    return _then(_$HomeStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      availableOrders: null == availableOrders
          ? _value._availableOrders
          : availableOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderWithInfo>,
      routeNamesMap: null == routeNamesMap
          ? _value._routeNamesMap
          : routeNamesMap // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl(
      {this.isLoading = false,
      final List<OrderWithInfo> availableOrders = const [],
      final Map<String, String> routeNamesMap = const {}})
      : _availableOrders = availableOrders,
        _routeNamesMap = routeNamesMap;

  @override
  @JsonKey()
  final bool isLoading;
  final List<OrderWithInfo> _availableOrders;
  @override
  @JsonKey()
  List<OrderWithInfo> get availableOrders {
    if (_availableOrders is EqualUnmodifiableListView) return _availableOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableOrders);
  }

  final Map<String, String> _routeNamesMap;
  @override
  @JsonKey()
  Map<String, String> get routeNamesMap {
    if (_routeNamesMap is EqualUnmodifiableMapView) return _routeNamesMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_routeNamesMap);
  }

  @override
  String toString() {
    return 'HomeState(isLoading: $isLoading, availableOrders: $availableOrders, routeNamesMap: $routeNamesMap)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._availableOrders, _availableOrders) &&
            const DeepCollectionEquality()
                .equals(other._routeNamesMap, _routeNamesMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_availableOrders),
      const DeepCollectionEquality().hash(_routeNamesMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final bool isLoading,
      final List<OrderWithInfo> availableOrders,
      final Map<String, String> routeNamesMap}) = _$HomeStateImpl;

  @override
  bool get isLoading;
  @override
  List<OrderWithInfo> get availableOrders;
  @override
  Map<String, String> get routeNamesMap;
  @override
  @JsonKey(ignore: true)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
