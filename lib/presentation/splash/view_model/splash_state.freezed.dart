// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splash_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SplashState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isFirstTimeOpenApp => throw _privateConstructorUsedError;
  bool get isLoggedIn => throw _privateConstructorUsedError;
  bool get haveCurrentNavigatingRoute => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SplashStateCopyWith<SplashState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SplashStateCopyWith<$Res> {
  factory $SplashStateCopyWith(
          SplashState value, $Res Function(SplashState) then) =
      _$SplashStateCopyWithImpl<$Res, SplashState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isFirstTimeOpenApp,
      bool isLoggedIn,
      bool haveCurrentNavigatingRoute});
}

/// @nodoc
class _$SplashStateCopyWithImpl<$Res, $Val extends SplashState>
    implements $SplashStateCopyWith<$Res> {
  _$SplashStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isFirstTimeOpenApp = null,
    Object? isLoggedIn = null,
    Object? haveCurrentNavigatingRoute = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstTimeOpenApp: null == isFirstTimeOpenApp
          ? _value.isFirstTimeOpenApp
          : isFirstTimeOpenApp // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      haveCurrentNavigatingRoute: null == haveCurrentNavigatingRoute
          ? _value.haveCurrentNavigatingRoute
          : haveCurrentNavigatingRoute // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SplashStateImplCopyWith<$Res>
    implements $SplashStateCopyWith<$Res> {
  factory _$$SplashStateImplCopyWith(
          _$SplashStateImpl value, $Res Function(_$SplashStateImpl) then) =
      __$$SplashStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isFirstTimeOpenApp,
      bool isLoggedIn,
      bool haveCurrentNavigatingRoute});
}

/// @nodoc
class __$$SplashStateImplCopyWithImpl<$Res>
    extends _$SplashStateCopyWithImpl<$Res, _$SplashStateImpl>
    implements _$$SplashStateImplCopyWith<$Res> {
  __$$SplashStateImplCopyWithImpl(
      _$SplashStateImpl _value, $Res Function(_$SplashStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isFirstTimeOpenApp = null,
    Object? isLoggedIn = null,
    Object? haveCurrentNavigatingRoute = null,
  }) {
    return _then(_$SplashStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isFirstTimeOpenApp: null == isFirstTimeOpenApp
          ? _value.isFirstTimeOpenApp
          : isFirstTimeOpenApp // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      haveCurrentNavigatingRoute: null == haveCurrentNavigatingRoute
          ? _value.haveCurrentNavigatingRoute
          : haveCurrentNavigatingRoute // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SplashStateImpl implements _SplashState {
  const _$SplashStateImpl(
      {this.isLoading = false,
      this.isFirstTimeOpenApp = false,
      this.isLoggedIn = false,
      this.haveCurrentNavigatingRoute = false});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isFirstTimeOpenApp;
  @override
  @JsonKey()
  final bool isLoggedIn;
  @override
  @JsonKey()
  final bool haveCurrentNavigatingRoute;

  @override
  String toString() {
    return 'SplashState(isLoading: $isLoading, isFirstTimeOpenApp: $isFirstTimeOpenApp, isLoggedIn: $isLoggedIn, haveCurrentNavigatingRoute: $haveCurrentNavigatingRoute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SplashStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isFirstTimeOpenApp, isFirstTimeOpenApp) ||
                other.isFirstTimeOpenApp == isFirstTimeOpenApp) &&
            (identical(other.isLoggedIn, isLoggedIn) ||
                other.isLoggedIn == isLoggedIn) &&
            (identical(other.haveCurrentNavigatingRoute,
                    haveCurrentNavigatingRoute) ||
                other.haveCurrentNavigatingRoute ==
                    haveCurrentNavigatingRoute));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isFirstTimeOpenApp,
      isLoggedIn, haveCurrentNavigatingRoute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SplashStateImplCopyWith<_$SplashStateImpl> get copyWith =>
      __$$SplashStateImplCopyWithImpl<_$SplashStateImpl>(this, _$identity);
}

abstract class _SplashState implements SplashState {
  const factory _SplashState(
      {final bool isLoading,
      final bool isFirstTimeOpenApp,
      final bool isLoggedIn,
      final bool haveCurrentNavigatingRoute}) = _$SplashStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isFirstTimeOpenApp;
  @override
  bool get isLoggedIn;
  @override
  bool get haveCurrentNavigatingRoute;
  @override
  @JsonKey(ignore: true)
  _$$SplashStateImplCopyWith<_$SplashStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
