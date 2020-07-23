import 'package:flutter/material.dart';
import 'package:imdb_simple_search/Provider/searchProvider.dart';
import 'package:provider/provider.dart';
import 'package:imdb_simple_search/Widgets/filmCard.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: searchBar(),
              ),
              Expanded(
                child: Consumer<SearchProvider>(
                  builder: (context, value, child) => value.searching
                      ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                            Container(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator()),
                          ],
                        )
                      : value.results == null
                          ? Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                ),
                                Text(
                                  "Type in and Search",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                ),
                              ],
                            )
                          : value.results.isEmpty
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                    ),
                                    Text(
                                      "No Results \nTry with broader Search",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  itemCount: value.results.length,
                                  addAutomaticKeepAlives: true,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  itemBuilder: (context, index) {
                                    return FilmCard(
                                      data: value.results[index],
                                    );
                                  },
                                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: false);
    return Container(
      child: TextField(
        controller: _searchController,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            hintText: "Search",
            border: OutlineInputBorder()),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onEditingComplete: () {
          searchProvider.search(searchString: _searchController.text);
        },
      ),
    );
  }
}
