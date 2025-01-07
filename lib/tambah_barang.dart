import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/halaman_listbarang.dart';

class TambahBarang extends StatefulWidget {
  const TambahBarang({super.key});

  @override
  State<TambahBarang> createState() => _TambahBarangState();
}

class _TambahBarangState extends State<TambahBarang> {
  final formKey = GlobalKey<FormState>();
  TextEditingController jenis_barang = TextEditingController();
  TextEditingController jumlah_barang = TextEditingController();
  TextEditingController harga_barang = TextEditingController();

  Future _postData () async {
    final respon = 
      await http.post(Uri.parse('http://192.168.172.18/api_produk/create.php'),
      body: {
        'jenis_barang' : jenis_barang.text,
        'jumlah_barang' : jumlah_barang.text,
        'harga_barang' : harga_barang.text,
      });
      if(respon.statusCode == 200) {
        return true;
      } 
      return false;
  }

  Widget _kolominput ({
    required TextEditingController controller,
    required String labelText,
  }) {
    return Container(
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
              validator: (value) {
                if(value!.isEmpty){
                  return "Kolom Tidak Boleh Kosong!";
                }
                return null;
              }
            ),  
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Tambah Barang Toko',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 8,),
            _kolominput(controller: jenis_barang, labelText: 'Jenis Barang'),
            _kolominput(controller: jumlah_barang, labelText: 'Jumlah Barang'),
            _kolominput(controller: harga_barang, labelText: 'Harga Barang'),

            const SizedBox(height: 25),
            SizedBox(
              width: 200,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    _postData().then((value) {
                      if (value) {
                        final snackBar = SnackBar(
                          content: const Text('Data Berhasil disimpan'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          content: const Text('Data Gagal disimpan'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: ((context)=>HalamanListbarang())), 
                      (route) => false);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 40, 75, 104),
                  foregroundColor: Colors.white,
                ),
                child: Text('Simpan')
              ),
            )
          ],
        )
      ),
    );
  }
}