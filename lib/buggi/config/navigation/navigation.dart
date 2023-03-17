import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/config/config.dart';
import 'package:app/buggi/models/timeline_model.dart';
import 'package:app/buggi/services/auth/root.dart';
import 'package:app/buggi/views/actions/create_offer.dart';
import 'package:app/buggi/views/offer/root.dart';
import 'package:app/buggi/views/onboarding/root.dart';
import 'package:app/buggi/views/profile/edit_profile.dart';
import 'package:app/buggi/views/profile/my_offers.dart';
import 'package:app/buggi/views/root_app/root.dart';
import 'package:app/common_libs.dart';

class GlobalNavigation {
  GlobalNavigation._();
  static final GlobalNavigation _instance = GlobalNavigation._();
  static GlobalNavigation get instance => _instance;
  factory GlobalNavigation() => _instance;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get context => _instance._navigatorKey.currentContext;
  static GlobalKey<NavigatorState> get key => _instance._navigatorKey;

  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case Constants.initialRoute:
        return MaterialPageRoute(
          builder: (_) {
            return BuggiAuth.userIsAuthenticated
                ? const RootApp()
                : const OnboardingPage();
          },
        );
      case OfferPage.route:
        return CustomPage(
          type: Transition.fade,
          child: OfferPage(
            offer: settings.arguments as Offer,
          ),
        );
      case BuggiActions.route:
        return CustomPage(
          type: Transition.slide,
          direction: AxisDirection.up,
          child: const BuggiActions(),
        );
      case EditProfilePage.route:
        return CustomPage(
          type: Transition.fade,
          child: const EditProfilePage(),
        );
      case MyOffers.route:
        return CustomPage(
          type: Transition.fade,
          child: const MyOffers(),
        );
      default:
        return CustomPage(
          child: const ErrorView(),
        );
    }
  }
}
