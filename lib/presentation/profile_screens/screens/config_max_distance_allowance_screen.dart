import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packare_shipper/config/typography.dart';
import 'package:packare_shipper/data/models/account_model.dart';
import 'package:packare_shipper/presentation/profile_screens/view_model/profile_view_model.dart';
import 'package:packare_shipper/shared/account_view_model/account_view_model.dart';

@RoutePage()
class ConfigMaxDistanceAllowanceScreen extends ConsumerStatefulWidget {
  const ConfigMaxDistanceAllowanceScreen({super.key});

  @override
  ConsumerState<ConfigMaxDistanceAllowanceScreen> createState() =>
      _ConfigMaxDistanceAllowanceScreenState();
}

class _ConfigMaxDistanceAllowanceScreenState
    extends ConsumerState<ConfigMaxDistanceAllowanceScreen> {
  late double maxDistanceConfig;
  late double maxDistanceChanges;

  Account? get shipperAccount => ref.watch(accountViewModelProvider);

  ProfileViewModel get viewModel => ref.read(profileViewModelProvider);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    maxDistanceConfig = shipperAccount!.shipper!.maxDistanceAllowance;
    maxDistanceChanges = maxDistanceConfig;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    bool isChanged = maxDistanceConfig != maxDistanceChanges;

    return AppBar(
      title: const Text('Config Expanding Distance'),
      actions: [_buildSaveButton(context, isChanged)],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDistanceText(context),
          _buildDistanceSlider(),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, bool isChanged) {
    return TextButton(
      onPressed: isChanged ? _onSaveMaxDistance : null,
      child: Text(
        'Save',
        style: TextStyle(
          color:
              isChanged ? Theme.of(context).colorScheme.primary : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildDistanceText(BuildContext context) {
    return Text(
      'Maximum Distance: $maxDistanceChanges km',
      style: AppTypography(context: context).bodyText.copyWith(fontSize: 20.0),
    );
  }

  Widget _buildDistanceSlider() {
    return Slider(
      value: maxDistanceChanges,
      min: 1.0,
      max: 10.0,
      divisions: 90,
      inactiveColor: Colors.grey,
      onChanged: (newValue) {
        setState(() {
          maxDistanceChanges = double.parse(newValue.toStringAsFixed(2));
        });
      },
    );
  }

  Future<void> _onSaveMaxDistance() async {
    try {
      await ref
          .read(profileViewModelProvider)
          .configMaxDistance(shipperAccount!, maxDistanceChanges);

      ref.read(accountViewModelProvider.notifier).setAccount(
            shipperAccount!.copyWith(
              shipper: shipperAccount!.shipper!
                  .copyWith(maxDistanceAllowance: maxDistanceChanges),
            ),
          );

      setState(() {
        maxDistanceConfig = maxDistanceChanges;
      });

      _showSnackBar('Distance updated successfully!');
    } catch (e) {
      _showSnackBar('Failed to update distance. Please try again.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
