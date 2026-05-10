import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  factory SearchState({
    @Default([]) List<Map<String, dynamic>> results,  // Search results
    @Default(false) bool isLoading,  // Loading state
    String? error,  // Error message
  }) = _SearchState;
}
