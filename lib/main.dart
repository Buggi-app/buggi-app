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
    return MaterialApp(
      navigatorKey: GlobalNavigation.key,
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      onGenerateRoute: GlobalNavigation.routes,
      initialRoute: Constants.initialRoute,
    );
  }
}
