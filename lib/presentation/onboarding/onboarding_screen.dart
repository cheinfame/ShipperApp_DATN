import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packare_shipper/router/app_router.dart';
import '../../config/path.dart';
import '../../config/typography.dart';
import '../authentication/global_widgets/rounded_button.dart';
import '../authentication/screens/authentication_screen.dart';
import 'widgets/page_indicator.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_handlePageChange);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlePageChange() {
    setState(() {
      _currentPage = _pageController.page!.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: <Widget>[
              _buildOnBoardView(
                context,
                warehouse_logo_path,
                "onboard1",
                "1 ",
                "Continue",
                () => _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
              ),
              _buildOnBoardView(
                context,
                delivery_bike_logo_path,
                "onboard2",
                "2 ",
                "Continue",
                () => _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
              ),
              _buildOnBoardView(
                context,
                map_logo_path,
                "onboard3",
                "3 ",
                "Get Started",
                () {
                  context.pushRoute(AuthenticationRoute());
                },
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: PageIndicator(
              currentPage: _currentPage,
              pageCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildOnBoardView(BuildContext context, String svg, String headTitle, String body,
    String buttonString, VoidCallback callback) {
  final Size size = MediaQuery.of(context).size;
  final double height = size.height;
  final double width = size.width;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: height * 0.4,
        width: width * 0.4,
        child: SvgPicture.asset(svg),
      ),
      Text(
        headTitle,
        style: AppTypography(context: context).heading1,
      ),
      Text(
        body,
        style: AppTypography(context: context).bodyText,
      ),
      const SizedBox(
        height: 10,
      ),
      RoundedButton(
        text: buttonString,
        onTap: callback,
      )
    ],
  );
}
