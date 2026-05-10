// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MapState {
  bool get isLoading => throw _privateConstructorUsedError;
  Position? get currentPosition => throw _privateConstructorUsedError;
  LatLng get centerCoords => throw _privateConstructorUsedError;
  List<List<double>> get geometry => throw _privateConstructorUsedError;
  List<LatLng> get waypoints => throw _privateConstructorUsedError;
  LatLng? get startCoords => throw _privateConstructorUsedError;
  LatLng? get endCoords => throw _privateConstructorUsedError;
  double get zoomLevel => throw _privateConstructorUsedError;
  OrderWithInfo? get currentViewingOrder => throw _privateConstructorUsedError;
  bool get isNavigating => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MapStateCopyWith<MapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapStateCopyWith<$Res> {
  factory $MapStateCopyWith(MapState value, $Res Function(MapState) then) =
      _$MapStateCopyWithImpl<$Res, MapState>;
  @useResult
  $Res call(
      {bool isLoading,
      Position? currentPosition,
      LatLng centerCoords,
      List<List<double>> geometry,
      List<LatLng> waypoints,
      LatLng? startCoords,
      LatLng? endCoords,
      double zoomLevel,
      OrderWithInfo? currentViewingOrder,
      bool isNavigating});
}

/// @nodoc
class _$MapStateCopyWithImpl<$Res, $Val extends MapState>
    implements $MapStateCopyWith<$Res> {
  _$MapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? currentPosition = freezed,
    Object? centerCoords = null,
    Object? geometry = null,
    Object? waypoints = null,
    Object? startCoords = freezed,
    Object? endCoords = freezed,
    Object? zoomLevel = null,
    Object? currentViewingOrder = freezed,
    Object? isNavigating = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPosition: freezed == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as Position?,
      centerCoords: null == centerCoords
          ? _value.centerCoords
          : centerCoords // ignore: cast_nullable_to_non_nullable
              as LatLng,
      geometry: null == geometry
          ? _value.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      waypoints: null == waypoints
          ? _value.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      startCoords: freezed == startCoords
          ? _value.startCoords
          : startCoords // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      endCoords: freezed == endCoords
          ? _value.endCoords
          : endCoords // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      zoomLevel: null == zoomLevel
          ? _value.zoomLevel
          : zoomLevel // ignore: cast_nullable_to_non_nullable
              as double,
      currentViewingOrder: freezed == currentViewingOrder
          ? _value.currentViewingOrder
          : currentViewingOrder // ignore: cast_nullable_to_non_nullable
              as OrderWithInfo?,
      isNavigating: null == isNavigating
          ? _value.isNavigating
          : isNavigating // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapStateImplCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory _$$MapStateImplCopyWith(
          _$MapStateImpl value, $Res Function(_$MapStateImpl) then) =
      __$$MapStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      Position? currentPosition,
      LatLng centerCoords,
      List<List<double>> geometry,
      List<LatLng> waypoints,
      LatLng? startCoords,
      LatLng? endCoords,
      double zoomLevel,
      OrderWithInfo? currentViewingOrder,
      bool isNavigating});
}

/// @nodoc
class __$$MapStateImplCopyWithImpl<$Res>
    extends _$MapStateCopyWithImpl<$Res, _$MapStateImpl>
    implements _$$MapStateImplCopyWith<$Res> {
  __$$MapStateImplCopyWithImpl(
      _$MapStateImpl _value, $Res Function(_$MapStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? currentPosition = freezed,
    Object? centerCoords = null,
    Object? geometry = null,
    Object? waypoints = null,
    Object? startCoords = freezed,
    Object? endCoords = freezed,
    Object? zoomLevel = null,
    Object? currentViewingOrder = freezed,
    Object? isNavigating = null,
  }) {
    return _then(_$MapStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPosition: freezed == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as Position?,
      centerCoords: null == centerCoords
          ? _value.centerCoords
          : centerCoords // ignore: cast_nullable_to_non_nullable
              as LatLng,
      geometry: null == geometry
          ? _value._geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      waypoints: null == waypoints
          ? _value._waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<LatLng>,
      startCoords: freezed == startCoords
          ? _value.startCoords
          : startCoords // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      endCoords: freezed == endCoords
          ? _value.endCoords
          : endCoords // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      zoomLevel: null == zoomLevel
          ? _value.zoomLevel
          : zoomLevel // ignore: cast_nullable_to_non_nullable
              as double,
      currentViewingOrder: freezed == currentViewingOrder
          ? _value.currentViewingOrder
          : currentViewingOrder // ignore: cast_nullable_to_non_nullable
              as OrderWithInfo?,
      isNavigating: null == isNavigating
          ? _value.isNavigating
          : isNavigating // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MapStateImpl implements _MapState {
  _$MapStateImpl(
      {this.isLoading = false,
      this.currentPosition,
      this.centerCoords = const LatLng(0, 0),
      final List<List<double>> geometry = const [],
      final List<LatLng> waypoints = const [],
      this.startCoords = null,
      this.endCoords = null,
      this.zoomLevel = 13.0,
      this.currentViewingOrder,
      this.isNavigating = false})
      : _geometry = geometry,
        _waypoints = waypoints;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Position? currentPosition;
  @override
  @JsonKey()
  final LatLng centerCoords;
  final List<List<double>> _geometry;
  @override
  @JsonKey()
  List<List<double>> get geometry {
    if (_geometry is EqualUnmodifiableListView) return _geometry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_geometry);
  }

  final List<LatLng> _waypoints;
  @override
  @JsonKey()
  List<LatLng> get waypoints {
    if (_waypoints is EqualUnmodifiableListView) return _waypoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waypoints);
  }

  @override
  @JsonKey()
  final LatLng? startCoords;
  @override
  @JsonKey()
  final LatLng? endCoords;
  @override
  @JsonKey()
  final double zoomLevel;
  @override
  final OrderWithInfo? currentViewingOrder;
  @override
  @JsonKey()
  final bool isNavigating;

  @override
  String toString() {
    return 'MapState(isLoading: $isLoading, currentPosition: $currentPosition, centerCoords: $centerCoords, geometry: $geometry, waypoints: $waypoints, startCoords: $startCoords, endCoords: $endCoords, zoomLevel: $zoomLevel, currentViewingOrder: $currentViewingOrder, isNavigating: $isNavigating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.currentPosition, currentPosition) ||
                other.currentPosition == currentPosition) &&
            (identical(other.centerCoords, centerCoords) ||
                other.centerCoords == centerCoords) &&
            const DeepCollectionEquality().equals(other._geometry, _geometry) &&
            const DeepCollectionEquality()
                .equals(other._waypoints, _waypoints) &&
            (identical(other.startCoords, startCoords) ||
                other.startCoords == startCoords) &&
            (identical(other.endCoords, endCoords) ||
                other.endCoords == endCoords) &&
            (identical(other.zoomLevel, zoomLevel) ||
                other.zoomLevel == zoomLevel) &&
            (identical(other.currentViewingOrder, currentViewingOrder) ||
                other.currentViewingOrder == currentViewingOrder) &&
            (identical(other.isNavigating, isNavigating) ||
                other.isNavigating == isNavigating));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      currentPosition,
      centerCoords,
      const DeepCollectionEquality().hash(_geometry),
      const DeepCollectionEquality().hash(_waypoints),
      startCoords,
      endCoords,
      zoomLevel,
      currentViewingOrder,
      isNavigating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapStateImplCopyWith<_$MapStateImpl> get copyWith =>
      __$$MapStateImplCopyWithImpl<_$MapStateImpl>(this, _$identity);
}

abstract class _MapState implements MapState {
  factory _MapState(
      {final bool isLoading,
      final Position? currentPosition,
      final LatLng centerCoords,
      final List<List<double>> geometry,
      final List<LatLng> waypoints,
      final LatLng? startCoords,
      final LatLng? endCoords,
      final double zoomLevel,
      final OrderWithInfo? currentViewingOrder,
      final bool isNavigating}) = _$MapStateImpl;

  @override
  bool get isLoading;
  @override
  Position? get currentPosition;
  @override
  LatLng get centerCoords;
  @override
  List<List<double>> get geometry;
  @override
  List<LatLng> get waypoints;
  @override
  LatLng? get startCoords;
  @override
  LatLng? get endCoords;
  @override
  double get zoomLevel;
  @override
  OrderWithInfo? get currentViewingOrder;
  @override
  bool get isNavigating;
  @override
  @JsonKey(ignore: true)
  _$$MapStateImplCopyWith<_$MapStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
