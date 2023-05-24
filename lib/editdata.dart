import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'homepage.dart';

class EditData extends StatefulWidget {
  final Map ListData;
  const EditData({Key ? key,required this.ListData}) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final formkey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController telp = TextEditingController();
  TextEditingController email = TextEditingController();

  Future _update() async{
    final response = await http.post(
      Uri.parse("https://restfull.mecloud.my.id/default/webService/updateSiswa"),
      body: {
        "id": id.text,
        "nama": nama.text,
        "alamat": alamat.text,
        "telp":telp.text,
        "email":email.text
      }
    );
     if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    id.text = widget.ListData["id"];
    nama.text = widget.ListData["nama"];
    alamat.text = widget.ListData["alamat"];
    telp.text = widget.ListData["telp"];
    email.text = widget.ListData["email"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit data"),
      ),
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 242, 231, 231),
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
                  
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.purple)
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
                      _update().then((value){
                        if(value){
                          //final snackbar = SnackBar(content: const Text("Data Berhasil Disimpan"));
                          final snackBar = SnackBar(
                          content: const Text('Data Berhasil Disimpan'),
                          duration: Duration(seconds: 5),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }else{
                          //final snackbar = SnackBar(content: const Text("Data Gagal Disimpan"));
                           final snackBar = SnackBar(
                          content: const Text('Data Gagal Disimpan'),
                          duration: Duration(seconds: 5),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                      );
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