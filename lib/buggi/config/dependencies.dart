import 'package:app/common_libs.dart';
import 'package:app/firebase_options.dart';
import 'package:flutter/services.dart';

class Dependencies {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await NoSQLDb.init();
  }
}
