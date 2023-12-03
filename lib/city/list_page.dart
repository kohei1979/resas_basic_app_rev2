import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resas_project_app/city/detail_page.dart';

class CityListPage extends StatefulWidget {
  const CityListPage({super.key});

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late Future<void> _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = Future.delayed(const Duration(seconds: 3));
    const host = 'opendata.resas-portal.go.jp';
    const endpoint = 'api/v1/cities';
    final headers = {
      'X-API-KEY': Env.resasApiKey,
    };
    final response = http.get(
      Uri.https(host, endpoint),
      headers: headers,
    );
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    // citiesという配列を定義
    final cities = [
      '札幌市',
      '仙台市',
      'さいたま市',
      '名古屋市',
      '京都市',
      '大阪市',
      '神戸市',
      '岡山市',
      '広島市',
      '福岡市',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            //非同期処理が完了したことを示す状態
            case ConnectionState.done:
              //元々のListviewを移動
              return ListView(
                children: [
                  //for文でcities配列の中身を一つずつ取り出し、ListTileで表示
                  for (final city in cities)
                    ListTile(
                      title: Text(city),
                      subtitle: const Text('政令指定都市'),
                      trailing: const Icon(Icons.navigate_next),
                      onTap: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute(
                            builder: (context) => CityDetailPage(city: city),
                          ),
                        );
                      },
                    ),
                ],
              );

            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
          }
          //非同期処理が完了するまではインジケータを表示
          return const Center(
            child: LinearProgressIndicator(),
          );
        },
      ),
    );
  }
}
