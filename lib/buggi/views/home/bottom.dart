import 'package:app/buggi/views/actions/create_offer.dart';
import 'package:app/common_libs.dart';

class HomeBottom extends StatelessWidget {
  final Size size;
  const HomeBottom({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: EdgeInsets.only(
            left: size.width * 0.25,
            right: size.width * 0.25,
            bottom: 16,
            top: 16),
        child: TextButton(
          onPressed: () {
            context.pushNamed(BuggiActions.route);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'Create an Offer',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }

  static Widget background(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: IgnorePointer(
        child: Container(
          padding: EdgeInsets.only(
            left: context.width * 0.25,
            right: context.width * 0.25,
            bottom: 16,
            top: 16,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.lightYellow.withOpacity(.0),
                AppTheme.lightYellow.withOpacity(.5),
                AppTheme.lightYellow,
              ],
            ),
          ),
          child: TextButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'B',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
