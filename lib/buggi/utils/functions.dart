import 'package:app/buggi/components/widgets/input.dart';
import 'package:app/buggi/models/models.dart';
import 'package:app/common_libs.dart';

void contactTapped({required Offer offer}) async {
  var bookNames = offer.ownerBooks.map((e) => e.asData?.value.name).toList();
  var selected = await Options.select<String>(
    title: 'Contact Me',
    options: [
      'Email',
      if (offer.owner.phone != null && offer.owner.phone != "") 'Message',
      if (offer.owner.phone != null && offer.owner.phone != "") 'Call',
    ],
  );
  if (selected != null) {
    Uri launchUri;
    switch (selected[0].toLowerCase()) {
      case 'call':
        launchUri = Uri(
          scheme: 'tel',
          path: offer.owner.phone,
        );
        tolaunchURL(launchUri);
        break;
      case 'message':
        String? encodeQueryParameters(Map<String, String> params) {
          return params.entries
              .map((MapEntry<String, String> e) =>
                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
              .join('&');
        }
        launchUri = Uri(
          scheme: 'sms',
          path: offer.owner.phone,
          query: encodeQueryParameters(<String, String>{
            'subject': 'Offer inquiry from Buggi',
            'body':
                'Hello I saw you had the following books\n ${bookNames.join(" ,")}\n',
          }),
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
