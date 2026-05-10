import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:packare_shipper/data/repositories/map_repository_impl.dart';
import 'package:packare_shipper/data/models/route_model.dart' as route_model;
import 'package:packare_shipper/locator.dart';
import 'package:packare_shipper/presentation/create_route/view_model/create_route_state.dart';
import 'package:packare_shipper/presentation/create_route/view_model/create_route_view_model.dart';
import 'package:packare_shipper/presentation/routes/widgets/save_route_sheet.dart';
import '../../config/typography.dart';
import '../authentication/global_widgets/info_text_field.dart';

import '../../data/services/api/location_search_service.dart';
import '../map/widgets/map_widget.dart';

final _createRouteViewModelProvider =
    StateNotifierProvider.autoDispose<CreateRouteViewModel, CreateRouteState>(
        (ref) => CreateRouteViewModel(
              ref: ref,
              mapRepository: locator<MapRepositoryImpl>(),
            ));

@RoutePage()
class CreateRouteScreen extends ConsumerStatefulWidget {
  const CreateRouteScreen({super.key});

  @override
  ConsumerState<CreateRouteScreen> createState() => _CreateRouteScreenState();
}

class _CreateRouteScreenState extends ConsumerState<CreateRouteScreen> {
  final TextEditingController _startLocationSearchController =
      TextEditingController();
  final TextEditingController _endLocationSearchController =
      TextEditingController();
  final TextEditingController _routeNameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> _searchResults = [];
  Timer? _debounceTimer;
  Timer? _saveDebounceTimer;

  late FocusNode _startLocationFocusNode;
  late FocusNode _endLocationFocusNode;

  bool _isFocused = false;

  CreateRouteState get state => ref.watch(_createRouteViewModelProvider);

  CreateRouteViewModel get viewModel =>
      ref.read(_createRouteViewModelProvider.notifier);

  @override
  void initState() {
    super.initState();
    _startLocationFocusNode = FocusNode();
    _endLocationFocusNode = FocusNode();

    // Add listeners to focus nodes
    _startLocationFocusNode.addListener(_handleFocusChange);
    _endLocationFocusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _startLocationSearchController.dispose();
    _endLocationSearchController.dispose();
    _routeNameController.dispose();

    _startLocationFocusNode.removeListener(_handleFocusChange);
    _endLocationFocusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  void searchLocations(String query) async {
    if (query.isNotEmpty) {
      if (_debounceTimer?.isActive ?? false) {
        _debounceTimer!.cancel();
      }

      _debounceTimer = Timer(const Duration(seconds: 1), () async {
        try {
          final results = await LocationSearchService.searchPlaces(query);
          if (results.containsKey('predictions')) {
            setState(() {
              _searchResults = List<Map<String, dynamic>>.from(
                results['predictions']
                    .map((prediction) => prediction as Map<String, dynamic>),
              );
            });
          } else {
            setState(() {
              _searchResults.clear();
            });
          }
        } catch (error) {
          print('Error searching places: $error');
        }
      });
    } else {
      setState(() {
        _searchResults.clear();
      });
    }
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused =
          _startLocationFocusNode.hasFocus || _endLocationFocusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Route'),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: MapWidget(
              startCoords: state.startCoords,
              endCoords: state.endCoords,
              geometry: state.geometry,
            ),
          ),
          Material(
            elevation: 8.0,
            child: Container(
              color: Theme.of(context).colorScheme.background,
              height: _isFocused ? double.infinity : 170,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InfoTextField(
                    hintText: 'Start Location',
                    label: 'Start Location',
                    textFieldController: _startLocationSearchController,
                    focusNode: _startLocationFocusNode,
                    onChanged: (value) {
                      searchLocations(value);
                    },
                    suffixIcon: _startLocationSearchController.text.isNotEmpty
                        ? const Icon(Icons.clear)
                        : _startLocationFocusNode.hasFocus
                            ? const Icon(Icons.search)
                            : null,
                    onSuffixPressed: () {
                      _startLocationSearchController.clear();
                      viewModel.setStartCoords(null);
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InfoTextField(
                    hintText: 'End Location',
                    label: 'End Location',
                    textFieldController: _endLocationSearchController,
                    focusNode: _endLocationFocusNode,
                    onChanged: (value) {
                      searchLocations(value);
                    },
                    suffixIcon: _endLocationSearchController.text.isNotEmpty
                        ? const Icon(Icons.clear)
                        : _endLocationFocusNode.hasFocus
                            ? const Icon(Icons.search)
                            : null,
                    onSuffixPressed: () {
                      _endLocationSearchController.clear();
                      // Clear endCoords
                      viewModel.setEndCoords(null);
                    },
                  ),
                  if (_isFocused)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ListView.separated(
                            itemCount: _searchResults.length <= 5
                                ? _searchResults.length
                                : 5,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(),
                                ),
                            itemBuilder: (context, index) {
                              final place = _searchResults[index];
                              return ListTile(
                                  title: Text(
                                      place['description'] ??
                                          'No address available',
                                      style: AppTypography(context: context)
                                          .bodyText),
                                  leading: const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blue,
                                  ),
                                  onTap: () async {
                                    final tappedPlace =
                                        await LocationSearchService
                                            .geocodeAddress(
                                                place['description']);
                                    _startLocationFocusNode.hasFocus
                                        ? {
                                            _startLocationSearchController
                                                .text = place['description'],
                                            viewModel.setStartCoords(
                                              LatLng(
                                                  tappedPlace['results'][0]
                                                          ['geometry']
                                                      ['location']['lat'],
                                                  tappedPlace['results'][0]
                                                          ['geometry']
                                                      ['location']['lng']),
                                            ),
                                          }
                                        : {
                                            _endLocationSearchController.text =
                                                place['description'],
                                            viewModel.setEndCoords(
                                              LatLng(
                                                tappedPlace['results'][0]
                                                        ['geometry']['location']
                                                    ['lat'],
                                                tappedPlace['results'][0]
                                                        ['geometry']['location']
                                                    ['lng'],
                                              ),
                                            ),
                                          };

                                    viewModel.createRoute();

                                    _startLocationFocusNode.unfocus();
                                    _endLocationFocusNode.unfocus();
                                  });
                            }),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: state.geometry.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(bottom: 64.0),
              child: SizedBox(
                width: 120,
                height: 48,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  onPressed: () {
                    if (_saveDebounceTimer?.isActive ?? false) {
                      _saveDebounceTimer!.cancel();
                    }

                    _saveDebounceTimer = Timer(const Duration(seconds: 1), () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return SaveRouteSheet(
                            routeNameController: _routeNameController,
                            startLocationController:
                                _startLocationSearchController,
                            endLocationController: _endLocationSearchController,
                            routeInfo: state.createdRoute!,
                            onSaveButtonTapped: (route) =>
                                _onSaveButtonTapped(route),
                          );
                        },
                      );
                    });
                  },
                  elevation: 8.0,
                  child: Text(
                    'Save Route',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 15.0),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _onSaveButtonTapped(route_model.Route route) async {
    try {
      await viewModel.saveRoute(route);

      if (context.mounted) {
        Navigator.pop(context);

        Future.delayed(const Duration(milliseconds: 500));
        context.router.back();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Route created successfully!'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed creating route. Please try again.'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}
