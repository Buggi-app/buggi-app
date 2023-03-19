import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/models/models.dart';
import 'package:app/common_libs.dart';

class OfferPage extends StatefulWidget {
  final Offer offer;
  static const String route = '/offer';
  const OfferPage({super.key, required this.offer});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  int deckOneIndex = 0;
  int deckTwoIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Text('Give feedback'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookDeck.lookForText('${DateFormat.yMMMEd().format(
            widget.offer.createdAt.toDate(),
          )}\n'),
          BookDeck.lookForText('My offer :'),
          BookDeck.lookForTitle(widget.offer.title),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 40,
              top: 40,
            ),
            child: Row(
              children: [
                BookDeck(
                  books: widget.offer.ownerBooks,
                  onChange: (value) {
                    setState(() {
                      deckOneIndex = value;
                    });
                  },
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: widget.offer.ownerBooks[deckOneIndex] is AsyncData
                        ? Text(
                            widget.offer.ownerBooks[deckOneIndex].asData!.value
                                .name,
                          )
                        : Container(
                            height: 24,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Wrap(
              spacing: 8,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.halfOrange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Total books: ${widget.offer.ownerBooks.length}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.halfOrange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Condition: Used',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
            ),
          ),
          BookDeck.lookForText('Looking for :'),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 28,
              top: 38,
            ),
            child: Row(
              children: [
                BookDeck(
                  books: widget.offer.offerBooks,
                  onChange: (value) {
                    setState(() {
                      deckTwoIndex = value;
                    });
                  },
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: widget.offer.offerBooks[deckOneIndex] is AsyncData
                        ? Text(
                            widget.offer.offerBooks[deckOneIndex].asData!.value
                                .name,
                          )
                        : Container(
                            height: 24,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Wrap(
              spacing: 8,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.halfOrange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Total books: ${widget.offer.offerBooks.length}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
          ),
          if (widget.offer.description.isNotEmpty) const SizedBox(height: 25),
          if (widget.offer.description.isNotEmpty)
            BookDeck.lookForText('Additional Information'),
          if (widget.offer.description.isNotEmpty)
            BookDeck.lookForTitle(widget.offer.description)
        ],
      ),
      floatingActionButton: const FloatingActionButton.extended(
        onPressed: contactTapped,
        label: Text('Contact Me'),
      ),
    );
  }
}
