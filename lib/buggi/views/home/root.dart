import 'package:app/buggi/config/config.dart';
import 'package:app/common_libs.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    Size size = query.size;
    double topPadding = query.padding.top;
    double appBarHeight = topPadding + 128;
    return SizedBox(
      height: size.height,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: appBarHeight,
              padding:
                  EdgeInsets.only(top: topPadding + 16, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hi, Lewis 😀',
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold, height: 1),
                  ),
                  const SizedBox(height: 16),
                  Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: AppTheme.halfOrange,
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.search,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Search for a book...',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: appBarHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: const Center(
                child: Text('Home Page'),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: size.width * 0.25,
                right: size.width * 0.25,
                bottom: 16,
              ),
              child: TextButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Buggi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
