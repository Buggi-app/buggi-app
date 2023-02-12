import 'package:app/buggi/config/config.dart';
import 'package:app/buggi/utils/utils.dart';
import 'package:app/common_libs.dart';

class BuggiActions extends StatelessWidget {
  static const String route = '/buggi/actions';
  const BuggiActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: _hintText('I want to :'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: DropdownButton(
                elevation: 1,
                underline: const SizedBox.shrink(),
                dropdownColor: AppTheme.halfOrange,
                value: 'Exchange a book',
                onChanged: (value) {},
                items: [
                  'Exchange a book',
                  'Give a book',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: _hintText('The books are :'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(LocalAsset.addBookIcon, width: 26),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: _hintText('General name of this books'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Short description',
                  hintStyle: TextStyle(
                    color: AppTheme.halfGrey,
                    height: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Divider(
              color: AppTheme.halfGrey,
              thickness: 1,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: _hintText('The books I need are :'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(LocalAsset.addBookIcon, width: 26),
              ),
            ),
            const SizedBox(height: 20),
            Divider(
              color: AppTheme.halfGrey,
              thickness: 1,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: _hintText('Any other description'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Row(
            children: [
              const Text('Submit'),
              const SizedBox(width: 10),
              Icon(Icons.arrow_forward_ios, size: 16)
            ],
          )),
    );
  }

  Widget _hintText(String text) => Text(
        text,
        style: const TextStyle(
          color: AppTheme.orange,
          height: 1,
          fontWeight: FontWeight.bold,
        ),
      );
}
