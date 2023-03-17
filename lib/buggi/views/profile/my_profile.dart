import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/config/config.dart';
import 'package:app/buggi/utils/utils.dart';
import 'package:app/buggi/views/profile/edit_profile.dart';
import 'package:app/buggi/views/profile/my_offers.dart';
import 'package:app/common_libs.dart';

class MyProfileWidget extends StatelessWidget {
  const MyProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
          child: Row(
            children: [
              Image.asset(
                "assets/images/demo/c_face.png",
                width: context.width * .2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Lewis Wise',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Student',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.pushNamed(EditProfilePage.route);
                },
                icon: SvgPicture.asset(
                  LocalAsset.editPersonIcon,
                  width: 20,
                  height: 20,
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[300],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 16, right: 16),
          child: Text(
            'My Offers',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 200 + 32,
          child: GridView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: .5,
            ),
            itemBuilder: (context, index) {
              if (index == 3) {
                return TextButton(
                  onPressed: () {
                    context.pushNamed(MyOffers.route);
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      AppTheme.orange,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const Text('View All'),
                );
              }
              return const OfferPreview();
            },
          ),
        ),
      ],
    );
  }
}
