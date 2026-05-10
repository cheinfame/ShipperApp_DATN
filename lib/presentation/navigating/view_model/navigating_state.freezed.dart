// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigating_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NavigatingState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<NavigatingRoute> get navigatingRoutes =>
      throw _privateConstructorUsedError;
  NavigatingRoute? get currentNavigatingRoute =>
      throw _privateConstructorUsedError;
  List<OrderWithInfo>? get currentPickingUpOrders =>
      throw _privateConstructorUsedError;
  List<OrderWithInfo>? get currentDeliveringOrders =>
      throw _privateConstructorUsedError;
  RouteDirection? get currentNavigatingRouteDirection =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NavigatingStateCopyWith<NavigatingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigatingStateCopyWith<$Res> {
  factory $NavigatingStateCopyWith(
          NavigatingState value, $Res Function(NavigatingState) then) =
      _$NavigatingStateCopyWithImpl<$Res, NavigatingState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<NavigatingRoute> navigatingRoutes,
      NavigatingRoute? currentNavigatingRoute,
      List<OrderWithInfo>? currentPickingUpOrders,
      List<OrderWithInfo>? currentDeliveringOrders,
      RouteDirection? currentNavigatingRouteDirection});
}

/// @nodoc
class _$NavigatingStateCopyWithImpl<$Res, $Val extends NavigatingState>
    implements $NavigatingStateCopyWith<$Res> {
  _$NavigatingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? navigatingRoutes = null,
    Object? currentNavigatingRoute = freezed,
    Object? currentPickingUpOrders = freezed,
    Object? currentDeliveringOrders = freezed,
    Object? currentNavigatingRouteDirection = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      navigatingRoutes: null == navigatingRoutes
          ? _value.navigatingRoutes
          : navigatingRoutes // ignore: cast_nullable_to_non_nullable
              as List<NavigatingRoute>,
      currentNavigatingRoute: freezed == currentNavigatingRoute
          ? _value.currentNavigatingRoute
          : currentNavigatingRoute // ignore: cast_nullable_to_non_nullable
              as NavigatingRoute?,
      currentPickingUpOrders: freezed == currentPickingUpOrders
          ? _value.currentPickingUpOrders
          : currentPickingUpOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderWithInfo>?,
      currentDeliveringOrders: freezed == currentDeliveringOrders
          ? _value.currentDeliveringOrders
          : currentDeliveringOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderWithInfo>?,
      currentNavigatingRouteDirection: freezed ==
              currentNavigatingRouteDirection
          ? _value.currentNavigatingRouteDirection
          : currentNavigatingRouteDirection // ignore: cast_nullable_to_non_nullable
              as RouteDirection?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NavigatingStateImplCopyWith<$Res>
    implements $NavigatingStateCopyWith<$Res> {
  factory _$$NavigatingStateImplCopyWith(_$NavigatingStateImpl value,
          $Res Function(_$NavigatingStateImpl) then) =
      __$$NavigatingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<NavigatingRoute> navigatingRoutes,
      NavigatingRoute? currentNavigatingRoute,
      List<OrderWithInfo>? currentPickingUpOrders,
      List<OrderWithInfo>? currentDeliveringOrders,
      RouteDirection? currentNavigatingRouteDirection});
}

/// @nodoc
class __$$NavigatingStateImplCopyWithImpl<$Res>
    extends _$NavigatingStateCopyWithImpl<$Res, _$NavigatingStateImpl>
    implements _$$NavigatingStateImplCopyWith<$Res> {
  __$$NavigatingStateImplCopyWithImpl(
      _$NavigatingStateImpl _value, $Res Function(_$NavigatingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? navigatingRoutes = null,
    Object? currentNavigatingRoute = freezed,
    Object? currentPickingUpOrders = freezed,
    Object? currentDeliveringOrders = freezed,
    Object? currentNavigatingRouteDirection = freezed,
  }) {
    return _then(_$NavigatingStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      navigatingRoutes: null == navigatingRoutes
          ? _value._navigatingRoutes
          : navigatingRoutes // ignore: cast_nullable_to_non_nullable
              as List<NavigatingRoute>,
      currentNavigatingRoute: freezed == currentNavigatingRoute
          ? _value.currentNavigatingRoute
          : currentNavigatingRoute // ignore: cast_nullable_to_non_nullable
              as NavigatingRoute?,
      currentPickingUpOrders: freezed == currentPickingUpOrders
          ? _value._currentPickingUpOrders
          : currentPickingUpOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderWithInfo>?,
      currentDeliveringOrders: freezed == currentDeliveringOrders
          ? _value._currentDeliveringOrders
          : currentDeliveringOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderWithInfo>?,
      currentNavigatingRouteDirection: freezed ==
              currentNavigatingRouteDirection
          ? _value.currentNavigatingRouteDirection
          : currentNavigatingRouteDirection // ignore: cast_nullable_to_non_nullable
              as RouteDirection?,
    ));
  }
}

/// @nodoc

class _$NavigatingStateImpl implements _NavigatingState {
  const _$NavigatingStateImpl(
      {this.isLoading = false,
      final List<NavigatingRoute> navigatingRoutes = const [],
      this.currentNavigatingRoute,
      final List<OrderWithInfo>? currentPickingUpOrders,
      final List<OrderWithInfo>? currentDeliveringOrders,
      this.currentNavigatingRouteDirection})
      : _navigatingRoutes = navigatingRoutes,
        _currentPickingUpOrders = currentPickingUpOrders,
        _currentDeliveringOrders = currentDeliveringOrders;

  @override
  @JsonKey()
  final bool isLoading;
  final List<NavigatingRoute> _navigatingRoutes;
  @override
  @JsonKey()
  List<NavigatingRoute> get navigatingRoutes {
    if (_navigatingRoutes is EqualUnmodifiableListView)
      return _navigatingRoutes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_navigatingRoutes);
  }

  @override
  final NavigatingRoute? currentNavigatingRoute;
  final List<OrderWithInfo>? _currentPickingUpOrders;
  @override
  List<OrderWithInfo>? get currentPickingUpOrders {
    final value = _currentPickingUpOrders;
    if (value == null) return null;
    if (_currentPickingUpOrders is EqualUnmodifiableListView)
      return _currentPickingUpOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<OrderWithInfo>? _currentDeliveringOrders;
  @override
  List<OrderWithInfo>? get currentDeliveringOrders {
    final value = _currentDeliveringOrders;
    if (value == null) return null;
    if (_currentDeliveringOrders is EqualUnmodifiableListView)
      return _currentDeliveringOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final RouteDirection? currentNavigatingRouteDirection;

  @override
  String toString() {
    return 'NavigatingState(isLoading: $isLoading, navigatingRoutes: $navigatingRoutes, currentNavigatingRoute: $currentNavigatingRoute, currentPickingUpOrders: $currentPickingUpOrders, currentDeliveringOrders: $currentDeliveringOrders, currentNavigatingRouteDirection: $currentNavigatingRouteDirection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigatingStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._navigatingRoutes, _navigatingRoutes) &&
            (identical(other.currentNavigatingRoute, currentNavigatingRoute) ||
                other.currentNavigatingRoute == currentNavigatingRoute) &&
            const DeepCollectionEquality().equals(
                other._currentPickingUpOrders, _currentPickingUpOrders) &&
            const DeepCollectionEquality().equals(
                other._currentDeliveringOrders, _currentDeliveringOrders) &&
            (identical(other.currentNavigatingRouteDirection,
                    currentNavigatingRouteDirection) ||
                other.currentNavigatingRouteDirection ==
                    currentNavigatingRouteDirection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_navigatingRoutes),
      currentNavigatingRoute,
      const DeepCollectionEquality().hash(_currentPickingUpOrders),
      const DeepCollectionEquality().hash(_currentDeliveringOrders),
      currentNavigatingRouteDirection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NavigatingStateImplCopyWith<_$NavigatingStateImpl> get copyWith =>
      __$$NavigatingStateImplCopyWithImpl<_$NavigatingStateImpl>(
          this, _$identity);
}

abstract class _NavigatingState implements NavigatingState {
  const factory _NavigatingState(
          {final bool isLoading,
          final List<NavigatingRoute> navigatingRoutes,
          final NavigatingRoute? currentNavigatingRoute,
          final List<OrderWithInfo>? currentPickingUpOrders,
          final List<OrderWithInfo>? currentDeliveringOrders,
          final RouteDirection? currentNavigatingRouteDirection}) =
      _$NavigatingStateImpl;

  @override
  bool get isLoading;
  @override
  List<NavigatingRoute> get navigatingRoutes;
  @override
  NavigatingRoute? get currentNavigatingRoute;
  @override
  List<OrderWithInfo>? get currentPickingUpOrders;
  @override
  List<OrderWithInfo>? get currentDeliveringOrders;
  @override
  RouteDirection? get currentNavigatingRouteDirection;
  @override
  @JsonKey(ignore: true)
  _$$NavigatingStateImplCopyWith<_$NavigatingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
