import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:packare_shipper/config/typography.dart';
import 'package:packare_shipper/presentation/authentication/global_widgets/custom_floating_search_bar/view_model/search_state.dart';
import 'package:packare_shipper/presentation/authentication/global_widgets/custom_floating_search_bar/view_model/search_view_model.dart';

class CustomFloatingSearchBar extends ConsumerStatefulWidget {
  final String title;
  final String hintText;
  final List<Map<String, dynamic>> searchResults;
  final ValueChanged<String>? onQueryChanged;
  final ValueChanged<Map<String, dynamic>>? onResultTap;

  const CustomFloatingSearchBar({
    Key? key,
    required this.title,
    required this.hintText,
    this.searchResults = const [],
    this.onQueryChanged,
    this.onResultTap,
  }) : super(key: key);

  @override
  ConsumerState<CustomFloatingSearchBar> createState() =>
      _CustomFloatingSearchBarState();
}

class _CustomFloatingSearchBarState
    extends ConsumerState<CustomFloatingSearchBar> {
  late FloatingSearchBarController _searchBarController;

  SearchState get state => ref.watch(searchViewModelProvider);

  @override
  void initState() {
    super.initState();
    _searchBarController = FloatingSearchBarController();
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      controller: _searchBarController,
      backdropColor: Colors.transparent,
      elevation: 0,
      height: 62,
      margins: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      border: BorderSide(color: Theme.of(context).colorScheme.outline),
      borderRadius: BorderRadius.circular(12.0),
      body: FloatingSearchBarScrollNotifier(
        child: Container(), // Placeholder for body content
      ),
      transition: CircularFloatingSearchBarTransition(),
      physics: const BouncingScrollPhysics(),
      title: Text(
        widget.title,
        style: AppTypography(context: context).bodyText,
      ),
      hint: widget.hintText,
      hintStyle: AppTypography(context: context).bodyText,
      automaticallyImplyBackButton: false,
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      onQueryChanged: widget.onQueryChanged,
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: widget.searchResults.length <= 5
                        ? widget.searchResults.length
                        : 5,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final place = widget.searchResults[index];
                      return ListTile(
                        title: Text(
                          place['description'] ?? 'No address available',
                          style: AppTypography(context: context).bodyText,
                        ),
                        onTap: () {
                          widget.onResultTap?.call(place);
                          _searchBarController.close();
                        },
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
