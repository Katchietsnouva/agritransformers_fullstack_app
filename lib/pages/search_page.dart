import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<String>> _buttonsFuture;

  @override
  void initState() {
    super.initState();
    _buttonsFuture = Future.delayed(Duration(seconds: 2), () {
      return [
        'Pesticides',
        'Insecticides',
        'Herbicides',
        'Fungicides',
        'Famers choice',
        'Favourites',
        'Ministry of Agriculture',
        'Recent news',
        'DIY',
        'Fertilizers',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                contentPadding: EdgeInsets.all(0),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Color.fromRGBO(220, 220, 220, 1),
                filled: true,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.person_add),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<List<String>>(
              future: _buttonsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No items found."));
                }

                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: Column(
                    key: ValueKey<int>(snapshot.data!.length),
                    children: snapshot.data!.map((item) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(item),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
