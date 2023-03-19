import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/models/models.dart';
import 'package:app/common_libs.dart';

class AvailableOffers extends StatelessWidget {
  static const String route = '/book/offers';
  final Book book;
  const AvailableOffers({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.width / 2.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BuggImage(
                      image: NetworkImage(book.cover!),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.name),
                      Text(book.grade),
                      Text('ISBN: ${book.isbn}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[300],
          ),
          Consumer(
            builder: (context, ref, _) {
              final timelineService = ref.watch(timelineServiceProvider);
              var a = timelineService.asData?.value;
              List<AsyncValue<List<Offer>>> b = [];
              for (Section aa in a ?? []) {
                if (aa.isNotNull) b.add(aa.offers);
              }
              var c = b.whereType<AsyncData<List<Offer>>>();
              var d = c.expand((element) => element.value).where((element) =>
                  element.ownerBooks.every((ww) => ww is AsyncData));
              var e = d.where((element) =>
                  element.offerBooks.every((element) => element is AsyncData));
              var f = e.where((element) => element.ownerBooks
                  .any((element) => element.asData!.value.name == book.name));
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: f.length + 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Available Offers with that book :',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }
                    var availableOffer = f.elementAt(index - 1);
                    return BigOfferCard(offer: availableOffer);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
