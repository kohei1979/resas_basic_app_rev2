import 'package:flutter/material.dart';
import 'package:resas_project_app/city/detail_page.dart';

class CityListPage extends StatelessWidget {
  const CityListPage({super.key});

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
      body: ListView(
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
                    builder: (context) => CityDetailPage(
                      city: city,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
