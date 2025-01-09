import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/edit_barang.dart';
import 'package:project1/tambah_barang.dart';


class HalamanListbarang extends StatefulWidget{
  const HalamanListbarang({super.key});

  @override
  State<HalamanListbarang> createState() => _HalamanProdukState();
}

class _HalamanProdukState extends State<HalamanListbarang> {
  List _listdata = [];
  bool _loading = true;

  //Read
  Future _getData() async {
    try {
      final respon = 
        await http.get(Uri.parse('http://192.168.172.18/api_produk/read.php'));
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        print(data);
        setState(() {
          _listdata = data;
          _loading = false;
        });
      } else {
        print('Error: ${respon.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    } 
  }

  //Delete
  Future _deleteData(String id) async {
    try {
      final respon = 
        await http.delete(Uri.parse('http://192.168.172.18/api_produk/delete.php'),body: {
          "id" : id,
      });
      if (respon.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception: $e');
    } 
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DATA BARANG TOKO',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: _loading 
      ? const Center(
        child: CircularProgressIndicator(),
        )
      : ListView.builder(
          itemCount: _listdata.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              child: Card(
                color: const Color.fromARGB(255, 219, 240, 251),
                child: ListTile(
                  title: Text(
                    _listdata[index]['jenis_barang'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('Stok Barang: ${_listdata[index]['jumlah_barang']}\nHarga: ${_listdata[index]['harga_barang']}'  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Update
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => EditBarang (
                                ListData: {
                                  'id' : _listdata[index]['id'],
                                  'jenis_barang' : _listdata[index]['jenis_barang'],
                                  'jumlah_barang' : _listdata[index]['jumlah_barang'],
                                  'harga_barang' : _listdata[index]['harga_barang'],
                                },
                            ))
                          );
                        }, 
                        icon: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 255, 164, 27),
                        ),
                      ),
                      
                      //Delete
                      IconButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context, 
                            builder: ((context) {
                              return AlertDialog(
                                content: const Text('Hapus data ini?'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _deleteData(_listdata[index]['id']).then((value){
                                        Navigator.pushAndRemoveUntil(
                                          context, 
                                          MaterialPageRoute(
                                            builder: ((context) => const HalamanListbarang())
                                          ), 
                                          (route) => false);
                                      });
                                    }, 
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 40, 75, 104),
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Hapus')
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }, 
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 40, 75, 104),
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Batal')
                                  ),
                                ],
                              );
                            })
                          );
                        }, 
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 40, 75, 104),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => const TambahBarang ())
        );
      })
    );
  }
}