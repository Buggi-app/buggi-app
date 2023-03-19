import 'dart:math';

import 'package:app/buggi/models/models.dart';
import 'package:app/buggi/views/offer/root.dart';
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
        return Container(
          color: AppTheme.halfOrange,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            value: value,
            valueColor: const AlwaysStoppedAnimation(AppTheme.orange),
            strokeWidth: 2,
          ),
        );
      },
      errorBuilder: (_, __) => Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: LayoutBuilder(builder: (_, constraints) {
          double size =
              min(constraints.biggest.width, constraints.biggest.height);
          if (size < 16) return const SizedBox();
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

class OfferPreview extends StatelessWidget {
  const OfferPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.halfGrey),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage([
                'https://klbbooks.com/wp-content/uploads/2020/10/math-grade1.png'
              ]),
              Container(
                width: 140 - 18,
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Offer Title',
                      style: TextStyle(height: 1),
                      maxLines: 2,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        height: 1,
                        fontSize: 12,
                        color: Colors.grey.shade800,
                      ),
                      maxLines: 1,
                    ),
                    const Spacer(),
                    Wrap(
                      children: ['exchange']
                          .map<Widget>(
                            (e) => Container(
                              margin: const EdgeInsets.only(right: 4),
                              padding: const EdgeInsets.only(
                                left: 4,
                                right: 4,
                                top: 2,
                                bottom: 1,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.halfGrey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                e,
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 10,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const Spacer(),
                    Text(
                      'Mama Doe',
                      style: TextStyle(
                        height: 1,
                        fontSize: 12,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(List<String> links) {
    return ListView.builder(
      itemCount: links.length > 2 ? 2 : links.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.only(right: index == links.length - 1 ? 0 : 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.network(
            links[0],
            height: 100,
            width: 60,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

class BookDeck extends StatelessWidget {
  final List<AsyncValue<Book>> books;
  final ValueChanged<int> onChange;
  final double? width;
  const BookDeck({
    super.key,
    required this.onChange,
    this.width,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width / 2,
      child: books.length == 1
          ? (books.first is AsyncData)
              ? Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 170,
                      child: BuggImage(
                        image: NetworkImage(books.first.asData!.value.cover!),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Container(
                    width: 130,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppTheme.halfGrey),
                    ),
                  ),
                )
          : SwipeDeck(
              cardSpreadInDegrees: 10,
              aspectRatio: 1.4,
              onChange: onChange,
              widgets: [
                for (var i = 0; i < books.length; i++)
                  if (books[i] is AsyncData)
                    InkWell(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: BuggImage(
                          image: NetworkImage(books[i].asData!.value.cover!),
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppTheme.lightYellow,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.halfGrey),
                      ),
                    )
              ],
            ),
    );
  }

  static Widget lookForText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        text,
        style: const TextStyle(
          color: AppTheme.orange,
          height: 1,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget lookForTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}

Material offerCardBorder(Widget child, {VoidCallback? onTap}) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    clipBehavior: Clip.hardEdge,
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.halfGrey),
        ),
        child: child,
      ),
    ),
  );
}

Widget offerTags(Offer offer) {
  return Wrap(
    children: offer.actions
        .map<Widget>(
          (e) => Container(
            margin: const EdgeInsets.only(right: 4),
            padding: const EdgeInsets.only(
              left: 4,
              right: 4,
              top: 2,
              bottom: 0,
            ),
            decoration: BoxDecoration(
              color: AppTheme.halfGrey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              e == 0 ? 'exchange' : 'give',
              style: TextStyle(
                height: 1,
                fontSize: 10,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        )
        .toList(),
  );
}

class OfferOwnerPreviewCard extends StatelessWidget {
  const OfferOwnerPreviewCard({
    super.key,
    required this.offer,
  });

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (offer.owner.avatar.isNotNull)
          CircleAvatar(
            radius: 8,
            backgroundColor: AppTheme.lightYellow,
            foregroundImage: NetworkImage(
              offer.owner.avatar!,
            ),
          ),
        if (offer.owner.avatar.isNotNull) const SizedBox(width: 4),
        Text(
          offer.owner.name ?? offer.owner.email,
          style: TextStyle(
            height: 1,
            fontSize: 12,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class BigOfferCard extends StatelessWidget {
  const BigOfferCard({
    super.key,
    required this.offer,
  });

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: offerCardBorder(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: context.width,
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    ...offer.ownerBooks.map(
                      (e) {
                        if (e is AsyncData) {
                          return Container(
                            clipBehavior: Clip.hardEdge,
                            width: 60,
                            height: 80,
                            margin: const EdgeInsets.only(
                              right: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.lightYellow,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppTheme.halfGrey,
                              ),
                            ),
                            child: Image.network(
                              e.asData!.value.cover!,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        return Container(
                          width: 60,
                          height: 80,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: AppTheme.lightYellow,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppTheme.halfGrey,
                            ),
                          ),
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.swap_horiz_outlined,
                        color: AppTheme.orange,
                      ),
                    ),
                    ...offer.offerBooks.map(
                      (e) {
                        if (e is AsyncData) {
                          return Container(
                            clipBehavior: Clip.hardEdge,
                            width: 60,
                            height: 80,
                            margin: const EdgeInsets.only(
                              right: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.lightYellow,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppTheme.halfGrey,
                              ),
                            ),
                            child: Image.network(
                              e.asData!.value.cover!,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        return Container(
                          width: 60,
                          height: 80,
                          padding: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: AppTheme.lightYellow,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppTheme.halfGrey,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              offer.title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              offer.grade,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            Row(
              children: [
                Text(
                  DateFormat.yMMMEd().format(
                    offer.createdAt.toDate(),
                  ),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                OfferOwnerPreviewCard(offer: offer),
              ],
            )
          ],
        ),
        onTap: () => context.pushNamed(
          OfferPage.route,
          arguments: offer,
        ),
      ),
    );
  }
}
