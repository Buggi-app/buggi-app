import 'package:app/buggi/config/config.dart';
import 'package:app/buggi/models/dummy_data.dart';
import 'package:app/buggi/models/timeline_model.dart';
import 'package:app/buggi/utils/utils.dart';
import 'package:app/buggi/views/offer/root.dart';
import 'package:app/common_libs.dart';

class HomeBody extends StatelessWidget {
  final ScrollController scrollController;
  const HomeBody({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 3));
      },
      child: ListView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 60),
        itemCount: timeLineData.length,
        itemBuilder: (context, index) {
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
                      currSection['section'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(),
                      itemCount: offers.length <= 2
                          ? offers.length
                          : offers.length + 1,
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
                          List<Map> books =
                              offer['books'].isEmpty ? <Map>[] : offer['books'];
                          return Padding(
                            padding: EdgeInsets.only(
                              left: 16,
                              right: last ? 16 : 0,
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              clipBehavior: Clip.hardEdge,
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  context.pushNamed(
                                    OfferPage.route,
                                    arguments: Offer(
                                      id: UniqueKey().toString(),
                                      title: offer['offer_title'],
                                      description: 'description',
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 100,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: AppTheme.halfGrey),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildImage(books
                                          .map((e) => e['image'] as String)
                                          .toList()),
                                      Container(
                                        width: 140 - 18,
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              offer['offer_title'],
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
                                            Wrap(
                                              children: offer['offer_type']
                                                  .map<Widget>(
                                                    (e) => Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 4),
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 4,
                                                        right: 4,
                                                        top: 2,
                                                        bottom: 1,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppTheme.halfGrey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                      child: Text(
                                                        e,
                                                        style: TextStyle(
                                                          height: 1,
                                                          fontSize: 10,
                                                          color: Colors
                                                              .grey.shade800,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                            const Spacer(),
                                            Text(
                                              offer['from'],
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
                            ),
                          );
                        }
                      },
                    ),
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
