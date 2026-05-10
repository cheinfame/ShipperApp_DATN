import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../../config/typography.dart';
import '../../authentication/global_widgets/rounded_button.dart';
import '../../map/widgets/map_widget.dart';
import '../../../data/models/route_model.dart' as route_model;
import '../../authentication/global_widgets/info_text_field.dart';

class SaveRouteSheet extends StatefulWidget {
  final TextEditingController routeNameController;
  final TextEditingController startLocationController;
  final TextEditingController endLocationController;
  final route_model.Route routeInfo;
  final bool isUpdatingRouteProcess;
  final Function(route_model.Route updatedRoute) onSaveButtonTapped;

  const SaveRouteSheet({
    super.key,
    required this.routeNameController,
    required this.startLocationController,
    required this.endLocationController,
    required this.routeInfo,
    required this.onSaveButtonTapped,
    this.isUpdatingRouteProcess = false,
  });

  @override
  _SaveRouteSheetState createState() => _SaveRouteSheetState();
}

class _SaveRouteSheetState extends State<SaveRouteSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  route_model.RouteDirection? selectedDirection;

  @override
  Widget build(BuildContext context) {
    final typo = AppTypography(context: context);

    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(typo),
              const SizedBox(height: 16.0),
              _buildRouteNameField(),
              const SizedBox(height: 8.0),
              _buildLocationFields(),
              const SizedBox(height: 8.0),
              _buildRouteDirectionDropdown(typo),
              if (widget.isUpdatingRouteProcess) const SizedBox(height: 16.0),
              if (widget.isUpdatingRouteProcess) _buildMapWidget(),
              const SizedBox(height: 16.0),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppTypography typo) {
    return Text('Save Route', style: typo.title2);
  }

  Widget _buildRouteNameField() {
    return InfoTextField(
      hintText: 'Route Name',
      label: 'Route Name',
      textFieldController: widget.routeNameController,
      formValidator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a route name';
        }
        return null;
      },
    );
  }

  Widget _buildLocationFields() {
    return Column(
      children: [
        InfoTextField(
          readOnly: true,
          hintText: 'Start Location',
          label: 'Start Location',
          textFieldController: widget.startLocationController,
        ),
        const SizedBox(height: 8.0),
        InfoTextField(
          readOnly: true,
          hintText: 'End Location',
          label: 'End Location',
          textFieldController: widget.endLocationController,
        ),
      ],
    );
  }

  Widget _buildRouteDirectionDropdown(AppTypography typo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Route Direction', style: typo.bodyText),
        DropdownButton<route_model.RouteDirection>(
          value: selectedDirection ?? widget.routeInfo.routeDirection,
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                selectedDirection = newValue;
              });
            }
          },
          items: route_model.RouteDirection.values.map((direction) {
            return DropdownMenuItem(
              value: direction,
              child: Text(route_model.routeDirectionToString(direction)),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMapWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: MapWidget(
        geometry: widget.routeInfo.geometry,
        startCoords: LatLng(
          widget.routeInfo.startCoordinates.coordinates[1],
          widget.routeInfo.startCoordinates.coordinates[0],
        ),
        endCoords: LatLng(
          widget.routeInfo.endCoordinates.coordinates[1],
          widget.routeInfo.endCoordinates.coordinates[0],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return RoundedButton(
      text: 'Save',
      onTap: () {
        if (formKey.currentState?.validate() ?? false) {
          final route_model.Route updatedRoute = widget.routeInfo.copyWith(
            routeName: widget.routeNameController.text,
            startLocation: widget.startLocationController.text,
            endLocation: widget.endLocationController.text,
            routeDirection: selectedDirection,
          );
          widget.onSaveButtonTapped(updatedRoute);
        }
      },
    );
  }
}
