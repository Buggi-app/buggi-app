import 'package:app/common_libs.dart';

class Options extends StatelessWidget {
  final String title;
  final List<String> options;
  final List<String> currentOptions;
  final bool isMultiSelect;
  final bool isSwich;
  const Options({
    super.key,
    required this.title,
    required this.options,
    this.isMultiSelect = false,
    this.isSwich = false,
    required this.currentOptions,
  });

  static Future<List<T>?> select<T>({
    String? title,
    BuildContext? context,
    List<String>? options,
    List<String>? currentOptions,
    bool? isMultiSelect,
    bool? isSwich,
  }) {
    return showModalBottomSheet<List<T>>(
      context: context ?? GlobalNavigation.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Options(
        title: title ?? '',
        options: options ?? [],
        currentOptions: currentOptions ?? [],
        isMultiSelect: isMultiSelect ?? false,
        isSwich: isSwich ?? false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context, null);
            },
            child: Container(
              height: double.infinity,
              width: context.width,
              color: Colors.transparent,
            ),
          ),
        ),
        Container(
          height: 6,
          width: context.width * .16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(
          height: context.height * 0.012,
        ),
        Container(
          width: context.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              const Divider(
                thickness: 0.5,
                height: 1,
                color: Color(0XFFB8BBC1),
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: context.height * 0.8,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: options.length,
                  physics: const ClampingScrollPhysics(),
                  padding:
                      const EdgeInsets.only(left: 32, right: 32, bottom: 32),
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 0.5,
                      height: 1,
                      color: Colors.grey[200],
                    );
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // tapped(index);
                        Navigator.pop(context, [options[index]]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                        child: Row(
                          children: [
                            Text(
                              options[index],
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void tapped(int index) {}
}
