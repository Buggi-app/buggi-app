import 'package:app/common_libs.dart';

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

  MediaQueryData get mq => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);
  double get height => mq.size.height;
  double get width => mq.size.width;
}

extension BuggiExt on Object? {
  bool get isNotNull => this != null;
}
