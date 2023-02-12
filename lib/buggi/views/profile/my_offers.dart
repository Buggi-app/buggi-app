import 'package:app/common_libs.dart';

class MyOffers extends StatelessWidget {
  static const String route = '/profile/my_offers';
  const MyOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Offers'),
      ),
    );
  }
}
