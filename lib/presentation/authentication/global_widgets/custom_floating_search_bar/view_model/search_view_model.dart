import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packare_shipper/data/services/api/location_search_service.dart';
import 'package:packare_shipper/locator.dart';
import 'package:packare_shipper/presentation/authentication/global_widgets/custom_floating_search_bar/view_model/search_state.dart';

final searchViewModelProvider = StateNotifierProvider<SearchViewModel, SearchState>(
  (ref) => SearchViewModel(
    locationSearchService: locator<LocationSearchService>(),
  ),
);

class SearchViewModel extends StateNotifier<SearchState> {
  SearchViewModel({
    required this.locationSearchService,
  }) : super(SearchState());

  final LocationSearchService locationSearchService;

  late Timer _debounceTimer;

  // Function to handle location search
  void searchLocations(String query) async {
    if (query.isNotEmpty) {
      state = state.copyWith(isLoading: true, error: null); // Set loading state

      if (_debounceTimer.isActive) {
        _debounceTimer.cancel();
      }

      _debounceTimer = Timer(const Duration(seconds: 1), () async {
        try {
          final results = await LocationSearchService.searchPlaces(query);
          if (results.containsKey('predictions')) {
            final limitedResults = List<Map<String, dynamic>>.from(
              results['predictions'].take(5), // Limit to 5 results
            );
            state = state.copyWith(
              results: limitedResults,
              isLoading: false,
            );
          } else {
            state = state.copyWith(
              results: [],
              isLoading: false,
            );
          }
        } catch (error) {
          print('Error searching places: $error');
          state = state.copyWith(
            isLoading: false,
            error: 'Failed to load locations. Please try again.',
          );
        }
      });
    } else {
      state = state.copyWith(
        results: [],
        isLoading: false, // Stop searching if query is empty
      );
    }
  }
}
