import 'dart:developer';

import 'package:desktop/desktop.dart';
import 'package:provider/provider.dart';
import 'package:train_map/component/part/part_table.dart';
import 'package:train_map/database/schemas.dart';
import 'package:train_map/main.dart' as main;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _SearchPageViewModel(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(
              builder: (context) {
                return SearchTextField(
                  onChanged: (text) {
                    log('search: $text');
                    final viewModel = context.read<_SearchPageViewModel>();
                    viewModel.updateSearch(text);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: ((context) {
                  final viewModel = context.watch<_SearchPageViewModel>();
                  return PartTable(
                    parts: viewModel.parts,
                    isBlueprintInfoDisplay: true,
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchPageViewModel extends ChangeNotifier {
  // input
  final realm = main.App.realm;

  // output
  List<Part> parts = [];

  _SearchPageViewModel() {
    parts = realm.all<Part>().toList();
  }

  void updateSearch(String text) {
    log('updateSearch: $text');
    final keywords = text.trim().split(' ');
    log("searching: $keywords");

    if (keywords.isEmpty) {
      parts = realm.all<Part>().toList();
    } else {
      final propertyNames = [
        'index',
        'code',
        'name',
        'importCode',
        'domesticCode',
        'count',
        'remark',
      ];
      String queryString = keywords.asMap().entries.map((entry) {
        final queryForProperty = propertyNames
            .map((name) => "$name CONTAINS[c] \$${entry.key}")
            .join(" OR ");
        return "($queryForProperty)";
      }).join(" AND ");
      log("searching with query: $queryString");
      parts = realm.query<Part>(queryString, keywords).toList();
    }
    notifyListeners();
  }
}
