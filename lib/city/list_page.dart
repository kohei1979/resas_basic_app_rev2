import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resas_project_app/city/detail_page.dart';
import 'package:resas_project_app/env.dart';

class CityListPage extends StatefulWidget {
  const CityListPage({super.key});

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late Future<String> _citiesFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const host = 'opendata.resas-portal.go.jp';
    const endpoint = 'api/v1/cities';
    final headers = {
      'X-API-KEY': Env.resasApiKey,
    };
    _citiesFuture = http
        .get(
          Uri.https(host, endpoint),
          headers: headers,
        )
        .then((res) => res.body);
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
      body: FutureBuilder<String>(
        future: _citiesFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            //非同期処理が完了したことを示す状態
            case ConnectionState.done:
              final json = jsonDecode(snapshot.data!)['result'] as List;

              // List の各要素はkey.value構造。key: String, valu: dynamicとして変換
              final items = json.cast<Map<String, dynamic>>();

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item['cityName'] as String),
                    subtitle: const Text('政令指定都市'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.of(context).push<void>(MaterialPageRoute(
                          builder: (context) => CityDetailPage(
                                city: item['cityName'] as String,
                              )));
                    },
                  );
                },
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
