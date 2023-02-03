import 'dart:js';

import 'package:app/buggi/config/config.dart';
import 'package:app/buggi/models/dummy_data.dart';
import 'package:app/common_libs.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(),
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
                    itemCount: offers.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index2) {
                      var offer = offers[index2];
                      bool last = index2 == offers.length - 1;
                      List<Map> books =
                          offer['books'].isEmpty ? <Map>[] : offer['books'];
                      return Container(
                        height: 100,
                        margin: EdgeInsets.only(left: 16, right: last ? 16 : 0),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTheme.halfGrey),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildImage(books
                                .map((e) => e['image'] as String)
                                .toList()),
                            // Container(
                            //   clipBehavior: Clip.hardEdge,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            //   child: Image.network(
                            //     book['image'],
                            //     height: 100,
                            //     width: 60,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            Container(
                              width: 140 - 18,
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                const EdgeInsets.only(right: 4),
                                            padding: const EdgeInsets.only(
                                              left: 4,
                                              right: 4,
                                              top: 2,
                                              bottom: 1,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppTheme.halfGrey,
                                              borderRadius:
                                                  BorderRadius.circular(4),
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
                      );
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
    );
  }

  Widget _buildImage(List<String> links) {
    // return ListView.builder(
    //   itemCount: links.length,
    //   itemBuilder: (context, index) {
    //     return Container(
    //       clipBehavior: Clip.hardEdge,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: Image.network(
    //         links[0],
    //         height: 100,
    //         width: 60,
    //         fit: BoxFit.cover,
    //       ),
    //     );
    //   },
    // );
    return Container(
      clipBehavior: Clip.hardEdge,
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
  }
}
