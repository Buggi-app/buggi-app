import 'package:app/buggi/components/widgets/input.dart';
import 'package:app/buggi/models/models.dart';
import 'package:app/common_libs.dart';

void contactTapped({required Offer offer}) async {
  var bookNames = offer.ownerBooks.map((e) => e.asData?.value.name).toList();
  var selected = await Options.select<String>(
    title: 'Contact Me',
    options: ['Email'],
  );
  if (selected != null) {
    Uri launchUri;
    switch (selected[0].toLowerCase()) {
      case 'call':
        launchUri = Uri(
          scheme: 'tel',
          path: '0712345678',
        );
        tolaunchURL(launchUri);
        break;
      case 'message':
        launchUri = Uri(
          scheme: 'sms',
          path: '0118 999 881 999 119 7253',
          queryParameters: <String, String>{
            'body': 'Example Subject & Symbols are allowed!'
          },
        );
        tolaunchURL(launchUri);
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
          path: offer.owner.email,
          query: encodeQueryParameters(<String, String>{
            'subject': 'Offer inquiry from Buggi',
            'body':
                'Hello I saw you had the following books\n ${bookNames.join(" ,")}\n',
          }),
        );
        tolaunchURL(launchUri);
        break;
    }
  }
}

tolaunchURL(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {}
}
