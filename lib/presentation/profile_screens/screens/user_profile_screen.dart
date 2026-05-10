import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packare_shipper/presentation/profile_screens/view_model/profile_view_model.dart';
import 'package:packare_shipper/router/app_router.dart';
import 'package:packare_shipper/shared/account_view_model/account_view_model.dart';
import '../../../config/typography.dart';
import '../../profile_screens/widgets/settings_list_item.dart';
import '../../profile_screens/widgets/user_profile_app_bar.dart';

@RoutePage()
class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountInfo = ref.watch(accountViewModelProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // app bar
            UserProfileAppBar(
              accountInfo: accountInfo!,
            ),

            // settings lists
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'My Account',
                    style: AppTypography(context: context).title3,
                  ),
                  const SizedBox(height: 10), // Add spacing between sections
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final icon_list = [
                        Icon(Icons.person_outline),
                        Icon(Icons.tune),
                        Icon(Icons.payment_outlined),
                        Icon(Icons.lock_outline),
                        Icon(Icons.logout)
                      ];
                      final list_titles = [
                        'User Information',
                        'Max Expanding Distance',
                        'Payment Method',
                        'Change Password',
                        'Logout'
                      ];
                      final callbacks = [
                        () {
                          // Replace navigation with AutoRoute navigation
                          context.pushRoute(UserInfoRoute());
                        },
                        () {
                          context.pushRoute(ConfigMaxDistanceAllowanceRoute());
                        },
                        () {},
                        () {
                          context.pushRoute(ChangePasswordRoute());
                        },
                        () async {
                          await ref.read(profileViewModelProvider).logout();

                          context.router.replaceAll([AuthenticationRoute()]);

                          Future.delayed(const Duration(milliseconds: 300), () {
                            ref
                                .read(accountViewModelProvider.notifier)
                                .clearAccount();
                          });
                        }
                      ];
                      return SettingsListItem(
                        buttonText: list_titles[index],
                        icon: icon_list[index],
                        callback: callbacks[index],
                      );
                    },
                  ),
                  const SizedBox(height: 20), // Add spacing between sections
                  Text(
                    'General',
                    style: AppTypography(context: context).title3,
                  ),
                  const SizedBox(height: 10), // Add spacing between sections
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final icon_list = [
                        Icon(Icons.settings_outlined),
                        Icon(Icons.language_outlined),
                        Icon(Icons.more_horiz)
                      ];
                      final list_titles = ['Settings', 'Language', 'About Us'];
                      final callbacks = [() {}, () {}, () {}];
                      return SettingsListItem(
                        buttonText: list_titles[index],
                        icon: icon_list[index],
                        callback: callbacks[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
