import 'package:app/buggi/components/components.dart';
import 'package:app/buggi/models/models.dart';
import 'package:app/common_libs.dart';

class SectionOffers extends ConsumerWidget {
  final String name;
  static const String route = '/section';
  const SectionOffers({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelineService = ref.watch(timelineServiceProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            title: Text(name),
          ),
          () {
            if (timelineService is AsyncData &&
                timelineService.asData!.value
                    .firstWhere((element) => element.name == name)
                    .offers is AsyncData) {
              List<Offer>? offers = timelineService.asData?.value
                  .firstWhere((element) => element.name == name)
                  .offers
                  .asData!
                  .value;
              if (offers?.isNotEmpty ?? false) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var offer = offers[index];
                      return BigOfferCard(offer: offer);
                    },
                    childCount: offers!.length,
                  ),
                );
              }
            }
            return const SliverToBoxAdapter();
          }()
        ],
      ),
    );
  }
}


