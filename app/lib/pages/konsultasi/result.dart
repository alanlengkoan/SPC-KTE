import 'package:egg_detection/networks/api.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ResultKonsultasi extends StatefulWidget {
  const ResultKonsultasi({Key? key, required this.title, this.id})
      : super(key: key);

  final String title;
  final int? id;

  @override
  State<ResultKonsultasi> createState() => _ResultKonsultasiState();
}

class _ResultKonsultasiState extends State<ResultKonsultasi> {
  Map konsultasi = {};
  List<String> imgList = [];

  _getData() async {
    imgList = [
      'http://192.140.20.234/skripsi/SPC-KTE/web/api/konsultasi/img_one/${widget.id}',
      'http://192.140.20.234/skripsi/SPC-KTE/web/api/konsultasi/img_two/${widget.id}',
      'http://192.140.20.234/skripsi/SPC-KTE/web/api/konsultasi/img_three/${widget.id}',
      'http://192.140.20.234/skripsi/SPC-KTE/web/api/konsultasi/img_four/${widget.id}',
    ];

    var response = await Network().getKonsultasiResult(widget.id.toString());
    var body = json.decode(response.body);
    print(body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      setState(() {
        konsultasi = data;
      });
    } else {
      throw Exception('Maaf gagal mengambil data!');
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    _show() {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(25.0),
                  child: Text(
                    'Nama :',
                  ),
                ),
                Container(
                  child: Text(
                    konsultasi['konsultasi']['nama'],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(25.0),
                  child: Text(
                    'Klasifikasi :',
                  ),
                ),
                Container(
                  child: Text(
                    konsultasi['klasifikasi'],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(25.0),
                  child: Text(
                    'Deskripsi :',
                  ),
                ),
                Expanded(
                  child: Text(
                    konsultasi['deskripsi'],
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(left: 25, right: 10, top: 25, bottom: 25),
                  child: Text(
                    'R :',
                  ),
                ),
                Container(
                  child: Text(
                    konsultasi['konsultasi']['r'].toString(),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 25, right: 10, top: 25, bottom: 25),
                  child: Text(
                    'G :',
                  ),
                ),
                Container(
                  child: Text(
                    konsultasi['konsultasi']['g'].toString(),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 25, right: 10, top: 25, bottom: 25),
                  child: Text(
                    'B :',
                  ),
                ),
                Container(
                  child: Text(
                    konsultasi['konsultasi']['b'].toString(),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(left: 25, right: 10, top: 25, bottom: 25),
                  child: Text(
                    'H :',
                  ),
                ),
                Container(
                  child: Text(
                    konsultasi['konsultasi']['h'].toString(),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 25, right: 10, top: 25, bottom: 25),
                  child: Text(
                    'S :',
                  ),
                ),
                Container(
                  child: Text(
                    konsultasi['konsultasi']['s'].toString(),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 25, right: 10, top: 25, bottom: 25),
                  child: Text(
                    'V :',
                  ),
                ),
                Container(
                  child: Text(
                    konsultasi['konsultasi']['v'].toString(),
                  ),
                ),
              ],
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: imgList
                  .map(
                    (imgUrl) => Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Image.network(imgUrl, fit: BoxFit.cover),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    }

    _loading() {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: const Color(0xFF1C6758),
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 26.0,
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: konsultasi.isEmpty ? _loading() : _show(),
      ),
    );
  }
}
