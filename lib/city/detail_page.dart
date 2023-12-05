import 'dart:convert';

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
    const endpoint = 'api/v1/municipality/taxes/perYear';
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
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final result = jsonDecode(snapshot.data!)['result']
                    as Map<String, dynamic>;
                final data = result['data'] as List;
                final items = data.cast<Map<String, dynamic>>();
                return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text('${item['year']}年',
                            style: const TextStyle(fontSize: 18)),
                        trailing: Text(
                          _formatTaxLabel(item['value'] as int),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    });
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  String _formatTaxLabel(int value) {
    return '${value * 1000}円';
  }
}
