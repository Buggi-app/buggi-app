import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/config/config.dart';
import 'package:app/buggi/models/book.dart';
import 'package:app/buggi/models/dummy_data.dart';
import 'package:app/buggi/models/timeline_model.dart';
import 'package:app/buggi/utils/utils.dart';
import 'package:app/buggi/views/offer/root.dart';
import 'package:app/common_libs.dart';

class HomeBody extends ConsumerWidget {
  final ScrollController scrollController;
  const HomeBody({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelineService = ref.watch(timelineServiceProvider);
    return timelineService.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text('data'),
      data: (sections) {
        return RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 3));
          },
          child: ListView.builder(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 60),
            itemCount: sections.length,
            itemBuilder: (context, index) {
              Section section = sections[index];
              Map<String, dynamic> currSection = timeLineData[index];
              List offers = currSection['offers'];
              if (offers.isNotEmpty) {
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
                            return _offerCards(section.offers.asData!.value);
                          }
                          return null;
                        }(),
                      )
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        );
      },
    );
  }

  ListView _offerCards(List<Offer> offers) {
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
              onPressed: () {},
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
                      width: 140 - 18,
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offer.title,
                            style: const TextStyle(height: 1),
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
                          offerTags(offer),
                          const Spacer(),
                          Row(
                            children: [
                              if (offer.owner.avatar.isNotNull)
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: AppTheme.lightYellow,
                                  foregroundImage: NetworkImage(
                                    offer.owner.avatar!,
                                  ),
                                ),
                              if (offer.owner.avatar.isNotNull)
                                const SizedBox(width: 4),
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
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
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
          }(),
        );
      },
    );
  }
}
