import 'package:app/common_libs.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color lightYellow = Color(0xffFFFAF3);
  static const Color orange = Color(0XFFFD8C09);
  static Color halfGrey = Colors.grey.withOpacity(.5);

  static final ThemeData defaultTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: lightYellow,
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      secondary: orange,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightYellow,
      elevation: 0,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
