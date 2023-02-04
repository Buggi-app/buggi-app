import 'dart:math';

import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/config/theme.dart';
import 'package:app/buggi/models/models.dart';
import 'package:app/buggi/utils/utils.dart';
import 'package:app/common_libs.dart';

List tempData = [
  {
    "name": "Grade1 klb",
    "image":
        "https://textbookcentre.com/media/cache/82/46/8246af01e987fb79445bcc23514e6988.jpg",
  },
  {
    "name": "Grade1 klb",
    "image":
        "https://textbookcentre.com/media/cache/c6/18/c61868a1dfde2185c892bf7c9e459f30.jpg",
  },
];

class OfferPage extends StatefulWidget {
  final Offer offer;
  static const String routeName = '/offer';
  const OfferPage({super.key, required this.offer});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  final PageController _pageController = PageController(viewportFraction: 0.5);
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final double bottomHeight = context.height / 2.75;
    double itemHeight = (context.height - 200 - bottomHeight).clamp(250, 400);
    double itemWidth = itemHeight * .666;

    final pages = tempData.map((e) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: _DoubleBorderImage(
          e['image'],
        ),
      );
    }).toList();

    return SafeArea(
      child: Material(
        color: AppTheme.lightYellow,
        child: Stack(
          children: [
            Positioned.fill(
              child: BlurredImgBackground(
                url: tempData[(_currentPage% pages.length).toInt()]['image'],
              ),
            ),
            _buildBgCircle(context.height / 2.75),
            PageView.builder(
              controller: _pageController,
              itemBuilder: (_, index) {
                final wrappedIndex = index % pages.length;
                final child = pages[wrappedIndex];
                  final int offset = (_currentPage.round() - index).abs();
                return _CollapsingCarouselItem(
                  width: itemWidth,
                  indexOffset: min(3, offset),
                  onPressed: () {},
                  title: 'Grade 1',
                  child: child,
                );
              },
            ),
            _buildHeader(),
          ],
        ),
      ),
    );
  }

  OverflowBox _buildBgCircle(double height) {
    const double size = 2000;
    return OverflowBox(
      maxWidth: size,
      maxHeight: size,
      child: Transform.translate(
        offset: Offset(0, size / 2.3),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.lightYellow,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(size),
            ),
          ),
        ),
      ),
    );
  }

  _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _CollapsingCarouselItem extends StatelessWidget {
  const _CollapsingCarouselItem(
      {Key? key,
      required this.child,
      required this.indexOffset,
      required this.width,
      required this.onPressed,
      required this.title})
      : super(key: key);
  final Widget child;
  final int indexOffset;
  final double width;
  final VoidCallback onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    // Calculate offset, this will be subtracted from the bottom padding moving the element downwards
    double vtOffset = 0;
    final tallHeight = width * 1.5;
    if (indexOffset == 1) vtOffset = width * .5;
    if (indexOffset == 2) vtOffset = width * .825;
    if (indexOffset > 2) vtOffset = width;

    final content = AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: indexOffset.abs() <= 2 ? 1 : 0,
      child: _AnimatedTranslate(
        duration: Duration(milliseconds: 500),
        offset: Offset(0, -tallHeight * .25 + vtOffset),
        child: Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            // Center item is portrait, the others are square
            height: indexOffset == 0 ? tallHeight : width,
            width: width,
            padding: indexOffset == 0
                ? EdgeInsets.all(0)
                : EdgeInsets.all(width * .1),
            child: child,
          ),
        ),
      ),
    );
    if (indexOffset > 2) return content;
    return content;
  }
}

class _AnimatedTranslate extends StatelessWidget {
  const _AnimatedTranslate({
    Key? key,
    required this.duration,
    required this.offset,
    required this.child,
  }) : super(key: key);
  final Duration duration;
  final Offset offset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: offset, end: offset),
      duration: duration,
      child: child,
      builder: (_, offset, c) => Transform.translate(offset: offset, child: c),
    );
  }
}

class _DoubleBorderImage extends StatelessWidget {
  const _DoubleBorderImage(this.data, {Key? key}) : super(key: key);
  final String data;
  @override
  Widget build(BuildContext context) => Container(
        // Add an outer border with the rounded ends.
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(999)),
        ),

        child: Padding(
          padding: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: ColoredBox(
              color: Colors.grey,
              child: BuggImage(
                  image: NetworkImage(data), fit: BoxFit.cover, scale: 0.5),
            ),
          ),
        ),
      );
}
