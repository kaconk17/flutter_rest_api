import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api/homepage.dart';
import 'package:http/http.dart' as http;

class TambahData extends StatefulWidget {
  const TambahData({super.key});

  @override
  State<TambahData> createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController telp = TextEditingController();
  TextEditingController email = TextEditingController();

  Future _simpan() async{
    final response = await http.post(
      Uri.parse("https://restfull.mecloud.my.id/default/webService/saveSiswa"),
      body: {
        "nama": nama.text,
        "alamat":alamat.text,
        "telp": telp.text,
        "email":email.text
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data"),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          ListView(
            children: [
              Form(
        key: formkey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10),
              child:  TextFormField(
                controller: nama,
                decoration: InputDecoration(
                  hintText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Nama Tidak Boleh Kosong";
                  }
                },
              ),
              ),
              Padding(padding: EdgeInsets.all(10),
              child:  TextFormField(
                controller: alamat,
                decoration: InputDecoration(
                  hintText: "Alamat",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Alamat Tidak Boleh Kosong";
                  }
                },
              ),
              ),
              Padding(padding: EdgeInsets.all(10),
              child:  TextFormField(
                controller: telp,
                decoration: InputDecoration(
                  hintText: "Telp",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Telp Tidak Boleh Kosong";
                  }
                },
              ),
              ),
              Padding(padding: EdgeInsets.all(10),
              child:  TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Email Tidak Boleh Kosong";
                  }
                },
              ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    
                  ),
                  onPressed: (){
                    if (formkey.currentState!.validate()) {
                      _simpan().then((value){
                        if(value){
                          final snackbar = SnackBar(content: const Text("Data Berhasil Disimpan"));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }else{
                          final snackbar = SnackBar(content: const Text("Data Gagal Disimpan"));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      });
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=>Homepage())), (route) => false);
                    }
                  }, 
                  child: Text("Submit")),
              )
             
            ],
          ),
        ),
      ),
            ],
          )
        ],
      ),
    );
  }
}