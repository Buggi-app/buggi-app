import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/models/book.dart';
import 'package:app/buggi/models/timeline_model.dart';
import 'package:app/buggi/views/offer/root.dart';
import 'package:app/buggi/views/offer/section_offers.dart';
import 'package:app/common_libs.dart';

class HomeBody extends ConsumerWidget {
  final ScrollController scrollController;
  const HomeBody({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelineService = ref.watch(timelineServiceProvider);
    return timelineService.when(
      loading: () => const SectionLoading(),
      error: (error, stackTrace) => const Center(child: Icon(Icons.error)),
      data: (sections) {
        return ListView.builder(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 60),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            Section section = sections[index];
            return section.offers.when(
              loading: () => OffersLoading(sectionName: section.name),
              error: (error, stackTrace) => const SizedBox.shrink(),
              data: (offers) {
                if (offers.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 12),
                        child: Text(
                          section.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: () {
                          if (section.offers is AsyncData) {
                            return _offerCards(
                              offers.take(4).toList(),
                              section.name,
                            );
                          }
                          return null;
                        }(),
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  ListView _offerCards(List<Offer> offers, String name) {
    return ListView.builder(
      padding: const EdgeInsets.only(),
      itemCount: offers.length <= 2 ? offers.length : offers.length + 1,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index2) {
        if ((offers.length) == index2) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextButton(
              onPressed: () => context.pushNamed(
                SectionOffers.route,
                arguments: name,
              ),
              child: const Text('More >'),
            ),
          );
        } else {
          var offer = offers[index2];
          bool last = index2 == offers.length - 1;
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: last ? 16 : 0,
            ),
            child: offerCardBorder(
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImage(offer.ownerBooks),
                  Container(
                    width: 122,
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer.title,
                          style: const TextStyle(height: 1),
                          maxLines: 2,
                        ),
                        const Spacer(),
                        offerTags(offer),
                        const Spacer(),
                        OfferOwnerPreviewCard(offer: offer)
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () => context.pushNamed(
                OfferPage.route,
                arguments: offer,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildImage(List<AsyncValue<Book>> books) {
    return ListView.builder(
      itemCount: books.length > 2 ? 2 : books.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        AsyncValue<Book> book = books[index];
        return Container(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.only(right: index == books.length - 1 ? 0 : 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: () {
            if (book is AsyncData) {
              Book bk = book.asData!.value;
              return Image.network(
                bk.cover!,
                height: 100,
                width: 60,
                fit: BoxFit.cover,
              );
            }
            return Container(
              width: 60,
              decoration: BoxDecoration(
                color: AppTheme.lightYellow,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.halfGrey),
              ),
            );
          }(),
        );
      },
    );
  }
}
