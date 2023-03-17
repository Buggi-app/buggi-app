import 'package:app/buggi/config/config.dart';
import 'package:app/buggi/services/auth/root.dart';
import 'package:app/buggi/utils/utils.dart';
import 'package:app/buggi/views/profile/my_profile.dart';
import 'package:app/common_libs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    double topPadding = query.padding.top;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: topPadding + 16, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              // const Spacer(),
              TextButton(
                onPressed: () async {
                  bool logout = await BuggiAuth.logOutUser();
                  if (logout) {
                    if (!mounted) return;
                    context.pushReplacementNamed(Constants.initialRoute);
                  }
                },
                child: const Text('Log Out'),
              )
            ],
          ),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(BuggiAuth.user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              return const MyProfileWidget();
            })
      ],
    );
  }
}
