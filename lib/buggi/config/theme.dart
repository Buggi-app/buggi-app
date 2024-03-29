import 'package:app/common_libs.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();

  static const Color lightYellow = Color(0xffFFFAF3);
  static const Color orange = Color(0XFFFD8C09);
  static Color halfGrey = Colors.grey.withOpacity(.5);
  static const Color halfOrange = Color(0xFFffeedb);

  static var systemChrome = SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: AppTheme.lightYellow,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  static final ThemeData defaultTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: lightYellow,
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      secondary: orange,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightYellow,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: lightYellow,
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
