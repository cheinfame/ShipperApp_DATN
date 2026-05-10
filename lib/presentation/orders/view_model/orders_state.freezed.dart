// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrdersState {
  bool get isLoading => throw _privateConstructorUsedError;
  OrderStatus get currentViewingOrdersStatus =>
      throw _privateConstructorUsedError;
  List<OrderWithInfo> get currentViewingOrders =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrdersStateCopyWith<OrdersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersStateCopyWith<$Res> {
  factory $OrdersStateCopyWith(
          OrdersState value, $Res Function(OrdersState) then) =
      _$OrdersStateCopyWithImpl<$Res, OrdersState>;
  @useResult
  $Res call(
      {bool isLoading,
      OrderStatus currentViewingOrdersStatus,
      List<OrderWithInfo> currentViewingOrders});
}

/// @nodoc
class _$OrdersStateCopyWithImpl<$Res, $Val extends OrdersState>
    implements $OrdersStateCopyWith<$Res> {
  _$OrdersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? currentViewingOrdersStatus = null,
    Object? currentViewingOrders = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currentViewingOrdersStatus: null == currentViewingOrdersStatus
          ? _value.currentViewingOrdersStatus
          : currentViewingOrdersStatus // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      currentViewingOrders: null == currentViewingOrders
          ? _value.currentViewingOrders
          : currentViewingOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderWithInfo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrdersStateImplCopyWith<$Res>
    implements $OrdersStateCopyWith<$Res> {
  factory _$$OrdersStateImplCopyWith(
          _$OrdersStateImpl value, $Res Function(_$OrdersStateImpl) then) =
      __$$OrdersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      OrderStatus currentViewingOrdersStatus,
      List<OrderWithInfo> currentViewingOrders});
}

/// @nodoc
class __$$OrdersStateImplCopyWithImpl<$Res>
    extends _$OrdersStateCopyWithImpl<$Res, _$OrdersStateImpl>
    implements _$$OrdersStateImplCopyWith<$Res> {
  __$$OrdersStateImplCopyWithImpl(
      _$OrdersStateImpl _value, $Res Function(_$OrdersStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? currentViewingOrdersStatus = null,
    Object? currentViewingOrders = null,
  }) {
    return _then(_$OrdersStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currentViewingOrdersStatus: null == currentViewingOrdersStatus
          ? _value.currentViewingOrdersStatus
          : currentViewingOrdersStatus // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      currentViewingOrders: null == currentViewingOrders
          ? _value._currentViewingOrders
          : currentViewingOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderWithInfo>,
    ));
  }
}

/// @nodoc

class _$OrdersStateImpl implements _OrdersState {
  const _$OrdersStateImpl(
      {this.isLoading = false,
      this.currentViewingOrdersStatus = OrderStatus.shipperAccepted,
      final List<OrderWithInfo> currentViewingOrders = const []})
      : _currentViewingOrders = currentViewingOrders;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final OrderStatus currentViewingOrdersStatus;
  final List<OrderWithInfo> _currentViewingOrders;
  @override
  @JsonKey()
  List<OrderWithInfo> get currentViewingOrders {
    if (_currentViewingOrders is EqualUnmodifiableListView)
      return _currentViewingOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentViewingOrders);
  }

  @override
  String toString() {
    return 'OrdersState(isLoading: $isLoading, currentViewingOrdersStatus: $currentViewingOrdersStatus, currentViewingOrders: $currentViewingOrders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.currentViewingOrdersStatus,
                    currentViewingOrdersStatus) ||
                other.currentViewingOrdersStatus ==
                    currentViewingOrdersStatus) &&
            const DeepCollectionEquality()
                .equals(other._currentViewingOrders, _currentViewingOrders));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      currentViewingOrdersStatus,
      const DeepCollectionEquality().hash(_currentViewingOrders));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrdersStateImplCopyWith<_$OrdersStateImpl> get copyWith =>
      __$$OrdersStateImplCopyWithImpl<_$OrdersStateImpl>(this, _$identity);
}

abstract class _OrdersState implements OrdersState {
  const factory _OrdersState(
      {final bool isLoading,
      final OrderStatus currentViewingOrdersStatus,
      final List<OrderWithInfo> currentViewingOrders}) = _$OrdersStateImpl;

  @override
  bool get isLoading;
  @override
  OrderStatus get currentViewingOrdersStatus;
  @override
  List<OrderWithInfo> get currentViewingOrders;
  @override
  @JsonKey(ignore: true)
  _$$OrdersStateImplCopyWith<_$OrdersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
