import 'package:app/buggi/views/root_app/root.dart';
import 'package:app/common_libs.dart';

class Views {
  static String initial = '/';
}

final appRouter = GoRouter(
  routes: [
    AppRoute(Views.initial, (_) => const RootApp()),
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
