import 'package:clean_architecture_class/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_architecture_class/modules/search/presenter/search/states/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: TextField(
              onChanged: bloc.add,
              decoration: InputDecoration(
                labelText: 'Search...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: bloc.stream,
                builder: (_, __) {
                  final state = bloc.state;
                  if (state is SearchStart)
                    return Center(
                      child: Text('Digite um texto'),
                    );
                  if (state is SearchError)
                    return Center(
                      child: Text('Error'),
                    );
                  if (state is SearchLoading)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  final list = (state as SearchSuccess).list;

                  print(list);
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, id) {
                      final item = list[id];

                      return ListTile(
                        leading: item.img == null
                            ? SizedBox()
                            : CircleAvatar(
                                backgroundImage: NetworkImage(item.img),
                              ),
                        title: Text(item.title ?? ''),
                        subtitle: Text(item.content ?? ''),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
