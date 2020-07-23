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
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: searchBar()),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Consumer<SearchProvider>(
                  builder: (context, value, child) => value.results == null
                      ? Text(
                          "Type in and Search",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        )
                      : value.searching
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                Container(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator()),
                              ],
                            )
                          : value.results.isEmpty
                              ? Text(
                                  "No Results",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                )
                              : ListView.builder(
                                  itemCount: value.results.length,
                                  addAutomaticKeepAlives: true,
                                  padding: EdgeInsets.all(8),
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
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            hintText: "Search",
            border: OutlineInputBorder()),
        textInputAction: TextInputAction.search,
        onEditingComplete: () {
          searchProvider.search(searchString: _searchController.text);
        },
      ),
    );
  }
}
