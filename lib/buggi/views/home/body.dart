import 'package:app/buggi/config/config.dart';
import 'package:app/common_libs.dart';

final List<Map<String, dynamic>> sections = [
  {
    'title': 'Popular Authors',
    'data': [
      {
        'name': 'It Ends with Us',
        'author': 'Colleen Hoover',
        'type': ['Free', 'Exchange'],
        'from': 'Jameson',
        'image':
            'https://prodimage.images-bn.com/lf?set=key%5Bresolve.pixelRatio%5D,value%5B1%5D&set=key%5Bresolve.width%5D,value%5B300%5D&set=key%5Bresolve.height%5D,value%5B10000%5D&set=key%5Bresolve.imageFit%5D,value%5Bcontainerwidth%5D&set=key%5Bresolve.allowImageUpscaling%5D,value%5B0%5D&set=key%5Bresolve.format%5D,value%5Bwebp%5D&product=path%5B/pimages/9781501110368_p0_v11%5D&call=url%5Bfile:common/decodeProduct.chain%5D',
      },
      {
        'name': 'The Last Thing He Told Me',
        'author': 'Laura Dave',
        'type': ['Free', 'Exchange'],
        'from': 'Jameson',
        'image':
            'https://prodimage.images-bn.com/lf?set=key%5Bresolve.pixelRatio%5D,value%5B1%5D&set=key%5Bresolve.width%5D,value%5B300%5D&set=key%5Bresolve.height%5D,value%5B10000%5D&set=key%5Bresolve.imageFit%5D,value%5Bcontainerwidth%5D&set=key%5Bresolve.allowImageUpscaling%5D,value%5B0%5D&set=key%5Bresolve.format%5D,value%5Bwebp%5D&product=path%5B/pimages/9781501171345_p0_v7%5D&call=url%5Bfile:common/decodeProduct.chain%5D',
      },
      {
        'name': 'The Galveston Diet',
        'author': 'A. J. Banner',
        'type': ['Free', 'Exchange'],
        'from': 'Jameson',
        'image':
            'https://prodimage.images-bn.com/lf?set=key%5Bresolve.pixelRatio%5D,value%5B1%5D&set=key%5Bresolve.width%5D,value%5B300%5D&set=key%5Bresolve.height%5D,value%5B10000%5D&set=key%5Bresolve.imageFit%5D,value%5Bcontainerwidth%5D&set=key%5Bresolve.allowImageUpscaling%5D,value%5B0%5D&set=key%5Bresolve.format%5D,value%5Bwebp%5D&product=path%5B/pimages/9780593578896_p0_v1%5D&call=url%5Bfile:common/decodeProduct.chain%5D',
      },
      {
        'name': 'If He Had Been with Me',
        'author': 'Laura Nowlin',
        'type': ['Free', 'Exchange'],
        'from': 'Jameson',
        'image':
            'https://prodimage.images-bn.com/lf?set=key%5Bresolve.pixelRatio%5D,value%5B1%5D&set=key%5Bresolve.width%5D,value%5B300%5D&set=key%5Bresolve.height%5D,value%5B10000%5D&set=key%5Bresolve.imageFit%5D,value%5Bcontainerwidth%5D&set=key%5Bresolve.allowImageUpscaling%5D,value%5B0%5D&set=key%5Bresolve.format%5D,value%5Bwebp%5D&product=path%5B/pimages/9781728205489_p0_v2%5D&call=url%5Bfile:common/decodeProduct.chain%5D',
      },
      {
        'name': 'It Starts with Us',
        'author': 'Colleen Hoover',
        'type': ['Free', 'Exchange'],
        'from': 'Jameson',
        'image':
            'https://prodimage.images-bn.com/lf?set=key%5Bresolve.pixelRatio%5D,value%5B1%5D&set=key%5Bresolve.width%5D,value%5B300%5D&set=key%5Bresolve.height%5D,value%5B10000%5D&set=key%5Bresolve.imageFit%5D,value%5Bcontainerwidth%5D&set=key%5Bresolve.allowImageUpscaling%5D,value%5B0%5D&set=key%5Bresolve.format%5D,value%5Bwebp%5D&product=path%5B/pimages/9781668001226_p0_v6%5D&call=url%5Bfile:common/decodeProduct.chain%5D',
      },
    ],
  },
];

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        var currSection = sections[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 12),
              child: Text(
                currSection['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                padding: const EdgeInsets.only(),
                itemCount: currSection['data'].length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index2) {
                  var book = currSection['data'][index2];
                  var last = index2 == (currSection['data'].length) - 1;
                  return Container(
                    width: 200,
                    height: 100,
                    margin: EdgeInsets.only(left: 16, right: last ? 16 : 0),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppTheme.halfGrey),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            book['image'],
                            width: 60,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Container(
                          width: 140 - 18,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book['name'],
                                style: const TextStyle(height: 1),
                                maxLines: 2,
                              ),
                              Text(
                                book['author'],
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 12,
                                  color: Colors.grey.shade800,
                                ),
                                maxLines: 1,
                              ),
                              const Spacer(),
                              Wrap(
                                children: book['type']
                                    .map<Widget>(
                                      (e) => Container(
                                        margin: const EdgeInsets.only(right: 4),
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                          right: 4,
                                          top: 2,
                                          bottom: 1,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppTheme.halfGrey,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                            height: 1,
                                            fontSize: 10,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const Spacer(),
                              Text(
                                book['from'],
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 12,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
