import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/models/models.dart';
import 'package:app/buggi/views/actions/create_offer.dart';
import 'package:app/buggi/views/profile/edit_profile.dart';
import 'package:app/common_libs.dart';

class MyProfileCard extends StatelessWidget {
  final User user;
  const MyProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppTheme.orange,
            child: Padding(
              padding: !user.photoURL.isNotNull
                  ? const EdgeInsets.all(12.0)
                  : EdgeInsets.zero,
              child: !user.photoURL.isNotNull
                  ? Image.asset(
                      'assets/images/noface.png',
                      fit: BoxFit.contain,
                    )
                  : Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        user.photoURL!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.displayName.isNotNull)
                  Text(
                    user.displayName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                Text(
                  user.email!,
                  style: const TextStyle(
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
    );
  }
}

class MyOffersCard extends ConsumerWidget {
  const MyOffersCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelineService = ref.watch(timelineServiceProvider);
    return timelineService.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const SizedBox.shrink(),
      data: (data) {
        // List<Offer> allOfers = [];
        // for (var section in data) {
        //   if (section.offers is AsyncData) {
        //     for (var offer in section.offers.asData!.value) {
        //       allOfers.add(offer);
        //     }
        //   }
        // }
        String myId = BuggiAuth.user.uid;
        List<Offer> myOffers = data
            .where((section) => section.offers is AsyncData)
            .expand((section) => section.offers.asData!.value)
            .where((element) => element.owner.id == myId)
            .toList();
        return GridView.builder(
          shrinkWrap: true,
          itemCount: myOffers.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            Offer myOffer = myOffers[index];
            return offerCardBorder(
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: () {
                      if (myOffer.ownerBooks[0] is AsyncData) {
                        Book bk = myOffer.ownerBooks[0].asData!.value;
                        return Image.network(
                          bk.cover!,
                          height: 100,
                          width: 60,
                          fit: BoxFit.cover,
                        );
                      }
                    }(),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          myOffer.title,
                          style: const TextStyle(fontSize: 16, height: 1),
                        ),
                        // Spacer(),
                        offerTags(myOffer),
                      ],
                    ),
                  )
                ],
              ),
              onTap: () {
                context.pushNamed(BuggiActions.route, arguments: myOffer.id);
              },
            );
          },
        );
      },
    );
    // Expanded(
    //   // child: LayoutBuilder(
    //   //   builder: (context, cs) {
    //   //     return Text('data');
    //   //   },
    //   // ),
    //   child: Text('ss'),
    // ),
    // SizedBox(
    //   // height: 200 + 32,
    //   child: GridView.builder(
    //     itemCount: 9,
    //     shrinkWrap: true,
    //     scrollDirection: Axis.vertical,
    //     padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       mainAxisSpacing: 16,
    //       crossAxisSpacing: 16,
    //       childAspectRatio: 1.5,
    //     ),
    //     itemBuilder: (context, index) {
    //       if (index == 3) {
    //         return TextButton(
    //           onPressed: () {
    //             context.pushNamed(MyOffers.route);
    //           },
    //           style: ButtonStyle(
    //             foregroundColor: MaterialStateProperty.all(
    //               AppTheme.orange,
    //             ),
    //             shape: MaterialStateProperty.all(
    //               RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(8),
    //               ),
    //             ),
    //           ),
    //           child: const Text('View All'),
    //         );
    //       }
    //       return const OfferPreview();
    //     },
    //   ),
    // ),
  }
}
