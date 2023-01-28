import 'package:app/common_libs.dart';

class ErrorView extends StatelessWidget {
  final String? message;
  final bool isFullScreen;
  const ErrorView({super.key, this.message, this.isFullScreen = false});

  @override
  Widget build(BuildContext context) {
    if (!isFullScreen) {
      return Center(
        child: Text(message ?? 'Something went wrong'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Text(message ?? 'Something went wrong'),
      ),
    );
  }
}
