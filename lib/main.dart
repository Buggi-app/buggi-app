import 'package:app/buggi/config/config.dart';
import 'package:app/common_libs.dart';

void main() async {
  await Dependencies.initialize();
  runApp(
    const ProviderScope(child: BuggiApp()),
  );
}

class BuggiApp extends StatelessWidget {
  const BuggiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: appRouter.routeInformationProvider,
      routeInformationParser: appRouter.routeInformationParser,
      routerDelegate: appRouter.routerDelegate,
      theme: AppTheme.defaultTheme,
    );
  }
}
