import 'package:app/buggi/config/theme.dart';
import 'package:app/common_libs.dart';

class BuggiNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTap;
  final List<Map<String, dynamic>> destinations;
  const BuggiNavigationBar({
    super.key,
    required this.selectedIndex,
    this.destinations = const [],
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppTheme.halfGrey,
            width: 0.5,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < destinations.length; i++)
              Expanded(
                child: InkWell(
                  onTap: () {
                    onTap?.call(i);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: bottomPadding, top: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          selectedIndex == i
                              ? destinations[i]['active_icon']
                              : destinations[i]['icon'],
                          height: 34,
                          width: 34,
                          color: selectedIndex == i
                              ? Colors.black
                              : Colors.black.withOpacity(.6),
                        ),
                        Text(
                          destinations[i]['label'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: selectedIndex == i
                                ? Colors.black
                                : Colors.black.withOpacity(.6),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
