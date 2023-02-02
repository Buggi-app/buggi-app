import 'package:app/common_libs.dart';
import 'package:app/firebase_options.dart';

class Dependencies {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
