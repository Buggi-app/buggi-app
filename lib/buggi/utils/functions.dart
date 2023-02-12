import 'package:app/buggi/components/widgets/input.dart';
import 'package:app/common_libs.dart';

void contactTapped() async {
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
          path: 'smith@example.com',
          query: encodeQueryParameters(<String, String>{
            'subject': 'Example Subject & Symbols are allowed!',
            'body': 'Hello world!',
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
  } else {
    print('unable to launch');
  }
}
