import 'package:app/buggi/components/sections/error_screen.dart';
import 'package:app/buggi/views/onboarding/root.dart';
import 'package:app/buggi/views/root_app/root.dart';
import 'package:app/common_libs.dart';

class Views {
  static String initial = '/';
}

final appRouter = GoRouter(
  errorBuilder: (context, state) {
    return const ErrorView(isFullScreen: true);
  },
  routes: [
    AppRoute(Views.initial, (_) => OnboardingPage()),
  ],
);

class AppRoute extends GoRoute {
  final bool useFade;

  AppRoute(String path, Widget Function(GoRouterState state) builder,
      {List<GoRoute> routes = const [], this.useFade = false})
      : super(
          path: path,
          builder: (context, state) {
            return builder(state);
          },
        );
}
