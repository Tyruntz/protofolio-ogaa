import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataBarang extends StatefulWidget {
  final String kategori;
  const DataBarang({Key? key, required this.kategori}) : super(key: key);

  @override
  State<DataBarang> createState() => _DataBarangState();
}

class _DataBarangState extends State<DataBarang> {
  String? gambarPath;
  TextEditingController namaBarang = TextEditingController();
  TextEditingController hargaModal = TextEditingController();
  TextEditingController hargaJual = TextEditingController();
  TextEditingController jumlahBarang = TextEditingController();

  void getData() async {
    await FirebaseFirestore.instance
        .collection('barang')
        .where('kategori', isEqualTo: widget.kategori)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
      
      });
    });

    final ref = FirebaseStorage.instance.ref().child('gambar');
    var url = await ref.getDownloadURL();
    setState(() {
      gambarPath = url;
    });
  }


  @override
  void initState() {
    super.initState();
    getData();
  }

  void clear() {
    namaBarang.clear();
    hargaModal.clear();
    hargaJual.clear();
    jumlahBarang.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data ${widget.kategori}'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('barang')
            .where('kategori', isEqualTo: widget.kategori)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                  leading: Image.network(data['gambar']),
                  title: Text(data['namaBarang']),
                  subtitle: Text('${data['jumlahBarang']} unit'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          namaBarang.text = data['namaBarang'];
                          hargaModal.text = data['hargaModal'];
                          hargaJual.text = data['hargaJual'];
                          jumlahBarang.text = data['jumlahBarang'];
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 500,
                                child: Column(
                                  children: [
                                    Text('Edit Data Barang',
                                        style: TextStyle(fontSize: 30)),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: namaBarang,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Nama Barang',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: hargaModal,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Harga Modal',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: hargaJual,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Harga Jual',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: jumlahBarang,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Jumlah Barang',
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          if (namaBarang.text.isNotEmpty &&
                                              hargaModal.text.isNotEmpty &&
                                              hargaJual.text.isNotEmpty &&
                                              jumlahBarang.text.isNotEmpty) {
                                            await FirebaseFirestore.instance
                                                .collection('barang')
                                                .doc(document.id)
                                                .update({
                                              'namaBarang': namaBarang.text,
                                              'hargaModal': hargaModal.text,
                                              'hargaJual': hargaJual.text,
                                              'jumlahBarang': jumlahBarang.text,
                                            });
                                            Navigator.pop(context);
                                            CoolAlert.show(
                                              context: context,
                                              type: CoolAlertType.success,
                                              title: 'Success',
                                              text: 'Data berhasil di edit',
                                            );
                                          } else {
                                            CoolAlert.show(
                                              context: context,
                                              type: CoolAlertType.error,
                                              title: 'Error',
                                              text: 'Harap isi semua field',
                                            );
                                          }
                                        } catch (e) {
                                          CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.error,
                                            title: 'Error',
                                            text: 'Terjadi kesalahan',
                                          );
                                        }
                                      },
                                      child: const Text('Edit'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.confirm,
                            title: 'Konfirmasi',
                            text: 'Apakah anda yakin ingin menghapus data ini?',
                            confirmBtnText: 'Ya',
                            cancelBtnText: 'Tidak',
                            onConfirmBtnTap: () async {
                              try {
                                await FirebaseFirestore.instance
                                    .collection('barang')
                                    .doc(document.id)
                                    .delete();
                                Navigator.pop(context);
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  title: 'Success',
                                  text: 'Data berhasil di hapus',
                                );
                              } catch (e) {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  title: 'Error',
                                  text: 'Terjadi kesalahan',
                                );
                              }
                            },
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ));
            }).toList(),
          );
        },
      ),
    );
  }
}
