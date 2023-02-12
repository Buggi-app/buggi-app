import 'package:app/buggi/config/config.dart';
import 'package:app/buggi/views/home/body.dart';
import 'package:app/buggi/views/home/bottom.dart';
import 'package:app/buggi/views/search/root.dart';
import 'package:app/common_libs.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  final ScrollController scrollController;
  final double scrollOffset;
  final Size size;
  const HomePage({
    super.key,
    required this.scrollController,
    required this.scrollOffset,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    double topPadding = query.padding.top;
    double appBarHeight = topPadding + 120;
    return SizedBox(
      height: size.height,
      child: Stack(
        children: [
          Positioned(
            top: getTop,
            left: 0,
            right: 0,
            child: Container(
              height: appBarHeight,
              padding: EdgeInsets.only(
                top: topPadding + 16,
                left: 16,
                right: 16,
              ),
              decoration: BoxDecoration(
                border: showBorder
                    ? Border(
                        bottom: BorderSide(
                          color: AppTheme.halfGrey,
                          width: 0,
                        ),
                      )
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: getTopOpacity,
                    child: const Text(
                      'Hi, Lewis 😀',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: AppTheme.halfOrange,
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () {
                        showSearch(context: context, delegate: SearchPage());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              CupertinoIcons.search,
                              color: Colors.grey,
                              size: 18,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Search for a book...',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: appBarHeight + getTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: HomeBody(
              scrollController: scrollController,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: HomeBottom.background(context),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: HomeBottom(size: size),
          ),
        ],
      ),
    );
  }

  double get getTop {
    if (scrollOffset < 0) {
      return -scrollOffset;
    } else if (scrollOffset > 50) {
      return -50;
    } else {
      return -scrollOffset;
    }
  }

  double get getTopOpacity {
    if (scrollOffset < 0) {
      return 1;
    } else if (scrollOffset > 50) {
      return 0;
    } else {
      return 1 - (scrollOffset / 50);
    }
  }

  bool get showBorder {
    if (scrollOffset < 0) {
      return false;
    } else if (scrollOffset > 50) {
      return true;
    } else {
      return false;
    }
  }
}
