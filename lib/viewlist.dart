import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'tambahdata.dart';

class Testviewlist extends StatefulWidget {
  const Testviewlist({super.key});

  @override
  State<Testviewlist> createState() => _TestviewlistState();
}

class _TestviewlistState extends State<Testviewlist> {
  List _listdata = [];
  //Map<String, dynamic> map=[];
  bool _isloading = true;

  Future _getdata() async {
    try {
      final response = await http.get(Uri.parse("https://restfull.mecloud.my.id/default/webService/getSiswa"));
      if (response.statusCode == 200) {
        //print(response.body);
        final data = jsonDecode(response.body);
        //print(data);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
        print(_listdata[2]);
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState(){
    _getdata();
    super.initState();
  }
  //@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Get"),

      ),
      body: _isloading ? Center(
        child: CircularProgressIndicator(),
      )
      :Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 240, 234, 234),
          ),
          ListView(
            children: <Widget>[
              Container(
                height: 700,
                  child: ListView.builder(
                    itemCount: _listdata.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.amberAccent,
                        child: ListTile(
                          title: Text(
                            //bulan[index],
                            _listdata[index]["nama_siswa"],
                            style: TextStyle(fontSize: 30),
                          ),
                          subtitle: Text(_listdata[index]["nomor_telp"].toString()),
                          leading: CircleAvatar(
                            child: Text(
                             // bulan[index][0],
                             _listdata[index]["id_siswa"].toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          
                        ),
                      );
                    }
                    
                  ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("+",style: TextStyle(fontSize: 30),),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context)=> TambahData())));
        },
      ),
    );
  }
}