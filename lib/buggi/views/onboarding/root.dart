import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/config/config.dart';
import 'package:app/buggi/services/auth/root.dart';
import 'package:app/buggi/views/onboarding/email_step.dart';
import 'package:app/common_libs.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buggi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  LocalAsset.bookgirlImage,
                  width: size.width * 0.45,
                ),
                Container(
                  width: size.width * 0.45,
                  padding: EdgeInsets.only(
                    right: size.width * 0.01,
                  ),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Find',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        Text(
                          'Exchange',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        Text(
                          'Give',
                          style: TextStyle(
                            fontSize: 50,
                            height: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Books that you love, need or have to give',
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    var signedIn = await BuggiAuth.signInWithGoogle();
                    if (signedIn) {
                      // ignore: use_build_context_synchronously
                      context.pushReplacementNamed(Constants.initialRoute);
                    } else {
                      showToast('Error signing in with Google', isError: true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: AppTheme.halfGrey,
                      width: 0.5,
                    ),
                    fixedSize: Size(size.width, 20),
                  ),
                  label: const Text('Continue with Google'),
                  icon: const Text(
                    'G',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CustomPage(
                        type: Transition.fade,
                        child: const EmailOnboarding(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fixedSize: Size(size.width, 20),
                  ),
                  child: const Text('Continue with Email'),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
