import 'package:app/common_libs.dart';

enum Transition { scale, slide, fade }

class CustomPage extends PageRouteBuilder {
  final Widget child;
  final bool? isOpaque;
  final AxisDirection direction;
  final Transition type;
  CustomPage({
    required this.child,
    this.isOpaque,
    this.direction = AxisDirection.left,
    this.type = Transition.slide,
  }) : super(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
  @override
  bool get opaque => isOpaque ?? true;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var curveTween = CurveTween(curve: Curves.linear);
    final tween = Tween(begin: getBeginOffset(direction), end: Offset.zero)
        .chain(curveTween);
    final offsetAnimation = animation.drive(tween);
    if (type == Transition.scale) {
      return ScaleTransition(
        scale: animation,
        child: child,
      );
    }
    if (type == Transition.fade) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  Offset getBeginOffset(AxisDirection direction) {
    switch (direction) {
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
        return const Offset(1, 0);
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
    }
  }
}
