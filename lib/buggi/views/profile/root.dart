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
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MyProfileCard(
                user: snapshot.data!,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[300],
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, cs) {
              return SizedBox(
                height: cs.maxHeight,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                        child: Text(
                          'My Offers',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      MyOffersCard()
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
