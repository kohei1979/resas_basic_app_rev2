import 'package:flutter/material.dart';
import 'package:resas_project_app/city/detail_page.dart';

class CityListPage extends StatefulWidget {
  const CityListPage({super.key});

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
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
        future: Future.delayed(const Duration(seconds: 3)),
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
