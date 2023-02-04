import 'dart:ui';

import 'package:app/buggi/components/components.dart';
import 'package:app/common_libs.dart';

class BlurredImgBackground extends StatelessWidget {
  final String? url;
  const BlurredImgBackground({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.25,
      alignment: Alignment(0, 0.8),
      child: Container(
        foregroundDecoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
        ),
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: BuggImage(
            image: NetworkImage(
              url!,
            ),
            fit: BoxFit.cover,
            scale: 0.5,
          ),
        ),
      ),
    );
  }
}
