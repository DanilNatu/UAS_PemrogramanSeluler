import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'halaman_listbarang.dart';

class EditBarang extends StatefulWidget {
  final Map ListData;
  const EditBarang({super.key, required this.ListData});

  @override
  State<EditBarang> createState() => _EditBarangState();
}

class _EditBarangState extends State<EditBarang> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController id;
  late TextEditingController jenis_barang;
  late TextEditingController jumlah_barang;
  late TextEditingController harga_barang;

  @override
  void initState() {
    super.initState();
    id = TextEditingController(text: widget.ListData['id']);
    jenis_barang = TextEditingController(text: widget.ListData['jenis_barang']);
    jumlah_barang =
        TextEditingController(text: widget.ListData['jumlah_barang']);
    harga_barang = TextEditingController(text: widget.ListData['harga_barang']);
  }

  Future<bool> _updateData() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.172.18/api_produk/update.php'),
        body: {
          'id': id.text,
          'jenis_barang': jenis_barang.text,
          'jumlah_barang': jumlah_barang.text,
          'harga_barang': harga_barang.text,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Widget _kolominput({
    required TextEditingController controller,
    required String labelText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Kolom Tidak Boleh Kosong!";
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Ubah Barang'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 8),
            _kolominput(controller: jenis_barang, labelText: 'Jenis Barang'),
            _kolominput(controller: jumlah_barang, labelText: 'Jumlah Barang'),
            _kolominput(controller: harga_barang, labelText: 'Harga Barang'),
            SizedBox(height: 25),

            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                width: 200,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _updateData().then((success) {
                        if (success) {
                          final snackBar = SnackBar(
                            content: const Text('Data Berhasil Diubah'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HalamanListbarang()),
                            (route) => false,
                          );
                        } else {
                          final snackBar = SnackBar(
                            content: const Text('Data Gagal Diubah'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 40, 75, 104),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Ubah'),
                ),
              ),
            ),
          ],
            
        ),
      ),
    );
  }

  @override
  void dispose() {
    id.dispose();
    jenis_barang.dispose();
    jumlah_barang.dispose();
    harga_barang.dispose();
    super.dispose();
  }
}
