import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:packare_shipper/data/models/account_model.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    @Default(0.0) double maxDistanceConfig,
  }) = _ProfileState;
}