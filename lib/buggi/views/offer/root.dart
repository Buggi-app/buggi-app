import 'dart:math';

import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/config/theme.dart';
import 'package:app/buggi/models/models.dart';
import 'package:app/common_libs.dart';

List tempData = [
  {
    "name": "Grade1 klb",
    "image": "https://klbbooks.com/wp-content/uploads/2020/10/math-grade1.png",
  },
  {
    "name": "CRE 1 klb",
    "image": "https://klbbooks.com/wp-content/uploads/2020/10/cre-g1.jpg",
  },
  {
    "name": "CRE 1 klb",
    "image":
        "https://klbbooks.com/wp-content/uploads/2020/10/Environmental-Activities-Grade-1-PB-416x593.jpg",
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
  int deckOneIndex = 0;
  int deckTwoIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.error_outline_rounded),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookDeck.lookForText('My offer :'),
          BookDeck.lookForTitle(widget.offer.title),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 40, top: 40),
            child: Row(
              children: [
                BookDeck(
                  links: const [
                    'https://klbbooks.com/wp-content/uploads/2020/10/math-grade1.png',
                    'https://klbbooks.com/wp-content/uploads/2020/10/cre-g1.jpg',
                    'https://klbbooks.com/wp-content/uploads/2020/10/Environmental-Activities-Grade-1-PB-416x593.jpg',
                  ],
                  onChange: (value) {
                    setState(() {
                      deckOneIndex = value;
                    });
                  },
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(tempData[deckOneIndex]["name"]),
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
                    'Total books: ${tempData.length}',
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
          BookDeck.lookForTitle(
            'Grade two books in for different subjects in decent condition',
          ),
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
                  links: const [
                    'https://klbbooks.com/wp-content/uploads/2020/10/english-literacy-g1.jpg',
                    'https://klbbooks.com/wp-content/uploads/2020/10/cre-g1.jpg',
                    'https://klbbooks.com/wp-content/uploads/2020/10/Environmental-Activities-Grade-1-PB-416x593.jpg',
                  ],
                  onChange: (value) {
                    setState(() {
                      deckTwoIndex = value;
                    });
                  },
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(tempData[deckTwoIndex]["name"]),
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
                    'Total books: ${tempData.length}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _contact,
        label: const Text('Contact Me'),
      ),
    );
  }

  void _contact() async {
    var selected = await Options.select<String>(
      title: 'Contact Me',
      options: ['Call', 'Message', 'Email'],
    );
    if (selected != null) {
      Uri launchUri;
      switch (selected[0].toLowerCase()) {
        case 'call':
          launchUri = Uri(
            scheme: 'tel',
            path: '0712345678',
          );
          _launchURL(launchUri);
          break;
        case 'message':
          launchUri = Uri(
            scheme: 'sms',
            path: '0118 999 881 999 119 7253',
            queryParameters: <String, String>{
              'body':
                  Uri.encodeComponent('Example Subject & Symbols are allowed!'),
            },
          );
          _launchURL(launchUri);
          break;
        case 'email':
          String? encodeQueryParameters(Map<String, String> params) {
            return params.entries
                .map((MapEntry<String, String> e) =>
                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                .join('&');
          }
          launchUri = Uri(
            scheme: 'mailto',
            path: 'smith@example.com',
            query: encodeQueryParameters(<String, String>{
              'subject': 'Example Subject & Symbols are allowed!',
            }),
          );
          launchUrl(launchUri);
          break;
      }
    }
  }

  _launchURL(Uri url) async {
    try {
      await launchUrl(url);
    } catch (e) {
      print(e);
    }
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
