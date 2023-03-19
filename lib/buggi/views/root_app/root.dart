import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/views/home/root.dart';
import 'package:app/buggi/views/profile/root.dart';
import 'package:app/common_libs.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int navSelectedIndex = 0;
  double homeScrollOffset = 0;
  final ScrollController _timelineScrollController = ScrollController();
  List<Map<String, dynamic>> get destinations => [
        {
          'active_icon': LocalAsset.homeFilledIcon,
          'icon': LocalAsset.homeOutlinedIcon,
          'label': 'Home',
        },
        {
          'active_icon': LocalAsset.userFilledIcon,
          'icon': LocalAsset.userOutlinedIcon,
          'label': 'Profile',
        }
      ];

  @override
  void initState() {
    super.initState();
    AppTheme.systemChrome;
    homeScrollManager();
  }

  homeScrollManager() {
    _timelineScrollController.addListener(() {
      setState(() {
        homeScrollOffset = _timelineScrollController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, animation, seconAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: seconAnimation,
            fillColor: AppTheme.lightYellow,
            child: child,
          );
        },
        child: navSelectedIndex == 0
            ? HomePage(
                scrollController: _timelineScrollController,
                scrollOffset: homeScrollOffset,
                size: size,
              )
            : const ProfilePage(),
      ),
      bottomNavigationBar: BuggiNavigationBar(
        selectedIndex: navSelectedIndex,
        destinations: destinations,
        onTap: (value) {
          setState(() {
            navSelectedIndex = value;
          });
        },
      ),
    );
  }
}
