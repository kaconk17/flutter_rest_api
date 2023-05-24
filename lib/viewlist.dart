import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api/editdata.dart';
import 'package:flutter_rest_api/homepage.dart';
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

  Future _hapus(id) async{
    try {
      final response = await http.post(
      Uri.parse("https://restfull.mecloud.my.id/default/webService/deleteSiswa"),
      body: {
        "id": id,
      }
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
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
          ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                    itemCount: _listdata.length,
                    itemBuilder: (context, index) {
                      return Card(
                        
                        color: Colors.amberAccent,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context)=>EditData(
                                  ListData:{
                                    "id":_listdata[index]["id_siswa"],
                                    "nama":_listdata[index]["nama_siswa"],
                                    "alamat":_listdata[index]["alamat_siswa"],
                                    "telp":_listdata[index]["nomor_telp"],
                                    "email":_listdata[index]["email_siswa"],
                                  }, ))));
                          },
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
                          trailing: IconButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: ((context){
                                  return AlertDialog(
                                    content: Text("Apakah Anda Akan Menghapus data ini?"),
                                    actions: [
                                      ElevatedButton(onPressed: (){
                                        Navigator.of(context).pop();
                                      }, 
                                      child: Text("Batal")),
                                      ElevatedButton(
                                        onPressed: (){
                                          _hapus(_listdata[index]["id_siswa"]).then((value) {
                                            if(value){
                                              final snackBar = SnackBar(
                                                content: const Text('Data Berhasil dihapus'),
                                                duration: Duration(seconds: 5),
                                                action: SnackBarAction(
                                                  label: 'Undo',
                                                  onPressed: () {
                                                    // Some code to undo the change.
                                                  },
                                                ),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            }else{
                                              final snackBar = SnackBar(
                                                content: const Text('Data Gagal dihapus'),
                                                duration: Duration(seconds: 5),
                                                action: SnackBarAction(
                                                  label: 'Undo',
                                                  onPressed: () {
                                                    // Some code to undo the change.
                                                  },
                                                ),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            }
                                          });
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(builder: ((context)=>Homepage())), (route) => false);
                                        },
                                        child: Text("Hapus"))
                                    ],
                                  );
                                }));
                            }, 
                            icon: Icon(Icons.delete)
                            ),
                          
                        ),
                        ),
                        
                      );
                    }
                    
                  ),
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