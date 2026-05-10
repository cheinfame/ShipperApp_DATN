// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_route_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateRouteState {
  bool get isLoading => throw _privateConstructorUsedError;
  LatLng? get startCoords => throw _privateConstructorUsedError;
  LatLng? get endCoords => throw _privateConstructorUsedError;
  List<List<double>> get geometry => throw _privateConstructorUsedError;
  Route? get createdRoute => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateRouteStateCopyWith<CreateRouteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateRouteStateCopyWith<$Res> {
  factory $CreateRouteStateCopyWith(
          CreateRouteState value, $Res Function(CreateRouteState) then) =
      _$CreateRouteStateCopyWithImpl<$Res, CreateRouteState>;
  @useResult
  $Res call(
      {bool isLoading,
      LatLng? startCoords,
      LatLng? endCoords,
      List<List<double>> geometry,
      Route? createdRoute});
}

/// @nodoc
class _$CreateRouteStateCopyWithImpl<$Res, $Val extends CreateRouteState>
    implements $CreateRouteStateCopyWith<$Res> {
  _$CreateRouteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? startCoords = freezed,
    Object? endCoords = freezed,
    Object? geometry = null,
    Object? createdRoute = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      startCoords: freezed == startCoords
          ? _value.startCoords
          : startCoords // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      endCoords: freezed == endCoords
          ? _value.endCoords
          : endCoords // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      geometry: null == geometry
          ? _value.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      createdRoute: freezed == createdRoute
          ? _value.createdRoute
          : createdRoute // ignore: cast_nullable_to_non_nullable
              as Route?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateRouteStateImplCopyWith<$Res>
    implements $CreateRouteStateCopyWith<$Res> {
  factory _$$CreateRouteStateImplCopyWith(_$CreateRouteStateImpl value,
          $Res Function(_$CreateRouteStateImpl) then) =
      __$$CreateRouteStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      LatLng? startCoords,
      LatLng? endCoords,
      List<List<double>> geometry,
      Route? createdRoute});
}

/// @nodoc
class __$$CreateRouteStateImplCopyWithImpl<$Res>
    extends _$CreateRouteStateCopyWithImpl<$Res, _$CreateRouteStateImpl>
    implements _$$CreateRouteStateImplCopyWith<$Res> {
  __$$CreateRouteStateImplCopyWithImpl(_$CreateRouteStateImpl _value,
      $Res Function(_$CreateRouteStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? startCoords = freezed,
    Object? endCoords = freezed,
    Object? geometry = null,
    Object? createdRoute = freezed,
  }) {
    return _then(_$CreateRouteStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      startCoords: freezed == startCoords
          ? _value.startCoords
          : startCoords // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      endCoords: freezed == endCoords
          ? _value.endCoords
          : endCoords // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      geometry: null == geometry
          ? _value._geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      createdRoute: freezed == createdRoute
          ? _value.createdRoute
          : createdRoute // ignore: cast_nullable_to_non_nullable
              as Route?,
    ));
  }
}

/// @nodoc

class _$CreateRouteStateImpl implements _CreateRouteState {
  const _$CreateRouteStateImpl(
      {this.isLoading = false,
      this.startCoords,
      this.endCoords,
      final List<List<double>> geometry = const [],
      this.createdRoute})
      : _geometry = geometry;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final LatLng? startCoords;
  @override
  final LatLng? endCoords;
  final List<List<double>> _geometry;
  @override
  @JsonKey()
  List<List<double>> get geometry {
    if (_geometry is EqualUnmodifiableListView) return _geometry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_geometry);
  }

  @override
  final Route? createdRoute;

  @override
  String toString() {
    return 'CreateRouteState(isLoading: $isLoading, startCoords: $startCoords, endCoords: $endCoords, geometry: $geometry, createdRoute: $createdRoute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateRouteStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.startCoords, startCoords) ||
                other.startCoords == startCoords) &&
            (identical(other.endCoords, endCoords) ||
                other.endCoords == endCoords) &&
            const DeepCollectionEquality().equals(other._geometry, _geometry) &&
            (identical(other.createdRoute, createdRoute) ||
                other.createdRoute == createdRoute));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, startCoords,
      endCoords, const DeepCollectionEquality().hash(_geometry), createdRoute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateRouteStateImplCopyWith<_$CreateRouteStateImpl> get copyWith =>
      __$$CreateRouteStateImplCopyWithImpl<_$CreateRouteStateImpl>(
          this, _$identity);
}

abstract class _CreateRouteState implements CreateRouteState {
  const factory _CreateRouteState(
      {final bool isLoading,
      final LatLng? startCoords,
      final LatLng? endCoords,
      final List<List<double>> geometry,
      final Route? createdRoute}) = _$CreateRouteStateImpl;

  @override
  bool get isLoading;
  @override
  LatLng? get startCoords;
  @override
  LatLng? get endCoords;
  @override
  List<List<double>> get geometry;
  @override
  Route? get createdRoute;
  @override
  @JsonKey(ignore: true)
  _$$CreateRouteStateImplCopyWith<_$CreateRouteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
