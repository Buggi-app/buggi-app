import 'package:app/buggi/config/config.dart';
import 'package:app/common_libs.dart';

class HomeBottom extends StatelessWidget {
  final Size size;
  const HomeBottom({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: IgnorePointer(
        child: Container(
          padding: EdgeInsets.only(
              left: size.width * 0.25,
              right: size.width * 0.25,
              bottom: 16,
              top: 16),
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
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Buggi',
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
