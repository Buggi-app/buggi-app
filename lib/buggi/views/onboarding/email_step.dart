import 'package:app/buggi/components/components.dart';
import 'package:app/common_libs.dart';

class EmailOnboarding extends StatefulWidget {
  static String name = 'email_onboarding';
  const EmailOnboarding({super.key});

  @override
  State<EmailOnboarding> createState() => _EmailOnboardingState();
}

class _EmailOnboardingState extends State<EmailOnboarding> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _step = 0;
  bool userExists = false;

  emailSubmit() async {
    if (_formKey1.currentState!.validate()) {
      loadingDialog(context);
      try {
        userExists = await BuggiAuth.checkIfUserExists(
            _emailController.text.toLowerCase());
        setState(() {
          _step = userExists ? 1 : 2;
        });
        if (!mounted) return;
        context.pop();
      } catch (e) {
        if (!mounted) return;
        context.pop();
        showToast('Error occurred !', isError: true);
      }
    }
  }

  passwordSubmit() async {
    if (_formKey2.currentState!.validate()) {
      loadingDialog(context);
      final String status;
      if (userExists) {
        status = await BuggiAuth.emailSignIn(
          _emailController.text,
          _passwordController.text,
        );
      } else {
        status = await BuggiAuth.emailSignUp(
          _emailController.text,
          _passwordController.text,
        );
      }

      if (status == BuggiAuth.success) {
        if (!mounted) return;
        context.pushReplacementNamed(Constants.initialRoute);
      } else {
        if (!mounted) return;
        context.pop();
        showToast(status, isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Hero(
                tag: 'bookgirl',
                child: Image.asset(
                  LocalAsset.bookgirlImage,
                  height: size.height * 0.2,
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _step == 0 ? _emailSection(size) : _passwordSection(size),
            ),
          ],
        ),
      ),
    );
  }

  Form _emailSection(Size size) {
    return Form(
      key: _formKey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email',
            style: TextStyle(fontSize: 28),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'johndoe@gmail.com',
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            validator: emailValidation,
            onFieldSubmitted: (value) {
              emailSubmit();
            },
          ),
        ],
      ),
    );
  }

  Form _passwordSection(Size size) {
    return Form(
      key: _formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_step == 2)
            const Text(
              'Welcome to Buggi',
              style: TextStyle(fontSize: 14),
            ),
          Text(
            _step == 2 ? 'New Password' : 'Password',
            style: const TextStyle(fontSize: 28),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: '********',
              errorMaxLines: 2,
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            validator: passwordValidation,
            onFieldSubmitted: (value) {
              passwordSubmit();
            },
          ),
          if (_step != 2)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  await BuggiAuth.forgotPassword(_emailController.text);
                  showToast(
                    '',
                    isInfo: true,
                    infoWidget: Text.rich(
                      TextSpan(
                        text: 'Email sent to ',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: _emailController.text,
                            style: const TextStyle(
                              color: AppTheme.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: '\nwith a reset password link',
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Text('Forgot password'),
              ),
            ),
        ],
      ),
    );
  }
}

class RecoverPasswordPage extends StatelessWidget {
  const RecoverPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
