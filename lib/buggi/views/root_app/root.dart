import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/config/config.dart';
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
  final List<Map<String, dynamic>> destinations = [
    {
      'active_icon': LocalAsset.homeFilledIcon,
      'icon': LocalAsset.homeOutlinedIcon,
      'label': 'Home',
      'widget': HomePage(),
    },
    {
      'active_icon': LocalAsset.userFilledIcon,
      'icon': LocalAsset.userOutlinedIcon,
      'label': 'Profile',
      'widget': ProfilePage(),
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: destinations[navSelectedIndex]['widget'],
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
