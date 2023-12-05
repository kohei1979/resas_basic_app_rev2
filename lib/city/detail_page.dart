import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resas_project_app/env.dart';

class CityDetailPage extends StatefulWidget {
  const CityDetailPage({super.key, required this.city});

  final String city;

  @override
  State<CityDetailPage> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  late Future<String> _municipalityTaxesFuture;

  @override
  void initState() {
    super.initState();
    const host = 'opendata.resas-portal.go.jp';
    const endpoint = 'opendata.resas-portal.go.jp';
    final headers = {
      'X-API-Key': Env.resasApiKey,
    };

    final param = {
      'prefCode': '13',
      'cityCode': '13115',
    };

    _municipalityTaxesFuture = http
        .get(
          Uri.https(host, endpoint, param),
          headers: headers,
        )
        .then((res) => res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.city)),
      body: FutureBuilder<String>(
          future: _municipalityTaxesFuture,
          builder: (context, snapshot) {
            print(snapshot.data);
            return Center(
              child: Text('${widget.city}の詳細画面です'),
            );
          }),
    );
  }
}
