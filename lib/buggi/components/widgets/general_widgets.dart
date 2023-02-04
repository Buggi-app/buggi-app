import 'dart:math';

import 'package:app/buggi/config/theme.dart';
import 'package:app/common_libs.dart';

class BuggiNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTap;
  final List<Map<String, dynamic>> destinations;
  const BuggiNavigationBar({
    super.key,
    required this.selectedIndex,
    this.destinations = const [],
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppTheme.halfGrey,
            width: 0.5,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < destinations.length; i++)
              Expanded(
                child: InkWell(
                  onTap: () {
                    onTap?.call(i);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: bottomPadding, top: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          selectedIndex == i
                              ? destinations[i]['active_icon']
                              : destinations[i]['icon'],
                          height: 34,
                          width: 34,
                          color: selectedIndex == i
                              ? Colors.black
                              : Colors.black.withOpacity(.6),
                        ),
                        Text(
                          destinations[i]['label'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: selectedIndex == i
                                ? Colors.black
                                : Colors.black.withOpacity(.6),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class BuggImage extends StatefulWidget {
  const BuggImage({
    super.key,
    required this.image,
    this.fit = BoxFit.scaleDown,
    this.scale,
    this.syncDuration,
  });

  final ImageProvider? image;
  final BoxFit fit;
  final double? scale;
  final Duration? syncDuration;

  @override
  State<BuggImage> createState() => _BuggImageState();
}

class _BuggImageState extends State<BuggImage> {
  @override
  Widget build(BuildContext context) {
       return ImageFade(
      image: widget.image,
      fit: widget.fit,
      // alignment: widget.alignment,
      // duration: widget.duration ?? $styles.times.fast,
      // syncDuration: widget.syncDuration ?? 0.ms,
      loadingBuilder: (_, value, ___) {
        if (!false && !false) return SizedBox();
        // return Center(child: AppLoadingIndicator(value: widget.progress ? value : null, color: widget.color));
      },
      errorBuilder: (_, __) => Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: LayoutBuilder(builder: (_, constraints) {
          double size = min(constraints.biggest.width, constraints.biggest.height);
          if (size < 16) return SizedBox();
          return Icon(
            Icons.image_not_supported_outlined,
            color: Colors.white.withOpacity(.2),
            size: min(size, 32),
          );
        }),
      ),
    );
  }
}
