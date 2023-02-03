import 'package:app/buggi/models/models.dart';
import 'package:app/common_libs.dart';

class OfferPage extends StatelessWidget {
  final Offer offer;
  static const String routeName = '/offer';
  const OfferPage({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                offer.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(offer.description),
            ],
          ),
        ));
  }
}
