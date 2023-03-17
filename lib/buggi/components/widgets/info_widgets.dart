import 'package:app/buggi/config/config.dart';
import 'package:app/common_libs.dart';
import 'package:flutter/cupertino.dart';

void loadingDialog(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      barrierColor: Colors.white.withOpacity(0.7),
      context: context,
      builder: (context) {
        return const SizedBox.shrink();
      });
}

void showToast(String? message,
    {BuildContext? context,
    bool? isError,
    bool isInfo = false,
    Widget? infoWidget}) {
  SnackBar toaster;
  BuildContext toasterContext = context ?? GlobalNavigation.context!;
  if (isError ?? false) {
    toaster = errorSnackBar(message ?? '');
  } else if (isInfo) {
    toaster = infoSnackBar(infoWidget ?? Text(message ?? ''));
  } else {
    toaster = successSnackBar(message ?? '');
  }
  ScaffoldMessenger.of(toasterContext).showSnackBar(toaster);
}

SnackBar successSnackBar(String success) => SnackBar(
      elevation: 16,
      backgroundColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            success,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
    );

SnackBar errorSnackBar(String error) => SnackBar(
      elevation: 16,
      backgroundColor: Colors.black,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
    );

SnackBar infoSnackBar(Widget child) => SnackBar(
      elevation: 16,
      backgroundColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 8,
              color: AppTheme.orange,
            ),
          ),
        ),
        padding: const EdgeInsets.only(left: 8),
        child: child,
      ),
      behavior: SnackBarBehavior.floating,
    );

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key});

  static Future<bool> show(
    String title, {
    String? message,
    BuildContext? context,
    VoidCallback? onYes,
    VoidCallback? onNo,
  }) async {
    final BuildContext contextToUse = context ?? GlobalNavigation.context!;
    var selected = false;
    await showCupertinoDialog(
      context: contextToUse,
      barrierDismissible: true,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message ?? 'Are you sure you want to log out ?'),
          actions: [
            TextButton(
              onPressed: () {
                selected = false;
                Navigator.of(ctx).pop();
              },
              child: const Text('no'),
            ),
            TextButton(
              onPressed: () {
                selected = true;
                Navigator.of(ctx).pop();
              },
              child: const Text('yes'),
            )
          ],
        );
      },
    );
    return selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
