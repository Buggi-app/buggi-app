import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/config/config.dart';
import 'package:app/buggi/models/timeline_model.dart';
import 'package:app/buggi/services/auth/root.dart';
import 'package:app/buggi/views/offer/root.dart';
import 'package:app/buggi/views/onboarding/root.dart';
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
      case OfferPage.routeName:
        return MaterialPageRoute(
          builder: (_) => OfferPage(
            offer: settings.arguments as Offer,
          ),
        );
      default:
        return CustomPage(child: const ErrorView());
    }
  }
}

extension Navigation on BuildContext {
  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  void pop() {
    Navigator.of(this).pop();
  }

  void pushReplacementNamed(String routeName) {
    Navigator.of(this).pushReplacementNamed(routeName);
  }
}
