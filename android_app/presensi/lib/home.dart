import 'dart:io';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:presensi/database_service.dart';
import 'package:presensi/login.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:presensi/data_barang.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? gambar;
  String kategori = 'SmartPhone';
  int current_index = 0;
  TextEditingController kodeBarang = TextEditingController();
  TextEditingController namaBarang = TextEditingController();
  TextEditingController hargaModal = TextEditingController();
  TextEditingController hargaJual = TextEditingController();
  TextEditingController jumlahBarang = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future scanQR() async {
    await Permission.camera.request();
    String? cameraScanResult = await scanner.scan();
    setState(() {
      kodeBarang.text = cameraScanResult!;
    });
  }

  Future<File> getGambar() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return File(image!.path);
  }

  void clear() {
    kodeBarang.clear();
    namaBarang.clear();
    hargaModal.clear();
    hargaJual.clear();
    jumlahBarang.clear();
    setState(() {
      gambar = null;
    });
  }

  BoxDecoration customBox() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.black26,
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 5,
          offset: const Offset(0, 5),
        ),
      ],
      color: const Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(20),
    );
  }

  TextStyle customText() {
    return TextStyle(
      fontSize: 30,
      color: const Color.fromARGB(255, 0, 0, 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Container(
        height: 650,
        width: 350,
        decoration: customBox(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('CSL MOBILE', style: customText()),
            Text('Kategori Barang', style: customText()),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: customBox(),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DataBarang(
                                          kategori: 'SmartPhone',
                                        )));
                          },
                          icon: Image.asset('assets/icon/iphone.png')),
                    ),
                  ),
                  SizedBox(width: 35),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: customBox(),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DataBarang(
                                          kategori: 'Laptop',
                                        )));
                          },
                          icon: Image.asset('assets/icon/laptop-screen.png')),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: customBox(),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DataBarang(
                                          kategori: 'SmartWatch',
                                        )));
                          },
                          icon: Image.asset('assets/icon/smartwatch.png')),
                    ),
                  ),
                  SizedBox(width: 35),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: customBox(),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DataBarang(
                                          kategori: 'SmartTV',
                                        )));
                          },
                          icon: Image.asset('assets/icon/smart-tv.png')),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: customBox(),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DataBarang(
                                          kategori: 'Headset',
                                        )));
                          },
                          icon: Image.asset('assets/icon/headset.png')),
                    ),
                  ),
                  SizedBox(width: 35),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: customBox(),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DataBarang(
                                          kategori: 'Charger',
                                        )));
                          },
                          icon: Image.asset('assets/icon/phone-charger.png')),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const Text('History'),
      Container(
        height: 650,
        width: 350,
        decoration: customBox(),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Tambah Barang', style: customText()),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 55,
                decoration: customBox(),
                child: TextField(
                  controller: kodeBarang,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Kode Barang',
                    suffixIcon: InkWell(
                      onTap: () {
                        scanQR();
                      },
                      child: Icon(Icons.qr_code_scanner),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: customBox(),
                height: 55,
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                        flex: 1,
                        child: Text(
                          'Kategori :',
                          style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        )),
                    Expanded(
                      flex: 2,
                      child: DropdownButton(
                          value: kategori,
                          items: [
                            DropdownMenuItem(
                                child: Text('SmartPhone'), value: 'SmartPhone'),
                            DropdownMenuItem(
                                child: Text('Laptop'), value: 'Laptop'),
                            DropdownMenuItem(
                                child: Text('SmartWatch'), value: 'SmartWatch'),
                            DropdownMenuItem(
                                child: Text('SmartTV'), value: 'SmartTV'),
                            DropdownMenuItem(
                                child: Text('Headset'), value: 'Headset'),
                            DropdownMenuItem(
                                child: Text('Charger'), value: 'Charger'),
                            DropdownMenuItem(
                                child: Text('Accesoris'), value: 'Accesoris'),
                          ],
                          onChanged: (value) {
                            setState(
                              () {
                                kategori = value!;
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 55,
                decoration: customBox(),
                child: TextField(
                  controller: namaBarang,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nama Barang',
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 55,
                decoration: customBox(),
                child: TextField(
                  controller: hargaModal,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Harga modal per Unit : Rp.',
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 55,
                decoration: customBox(),
                child: TextField(
                  controller: hargaJual,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Harga jual per Unit : Rp.',
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 55,
                decoration: customBox(),
                child: TextField(
                  controller: jumlahBarang,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Jumlah Barang',
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      decoration: customBox(),
                      child: gambar == null
                          ? IconButton(
                              onPressed: () async {
                                File image = await getGambar();
                                gambar = await DataBarangService()
                                    .uploadImage(image);
                                setState(() {});
                              },
                              icon: Icon(Icons.add_a_photo))
                          : Image.network(gambar!)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 55,
                width: 200,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 255, 201, 51)),
                    ),
                    onPressed: () async {
                      try {
                        if (kodeBarang.text.isEmpty ||
                            namaBarang.text.isEmpty ||
                            hargaModal.text.isEmpty ||
                            hargaJual.text.isEmpty ||
                            jumlahBarang.text.isEmpty) {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              text: 'Data Tidak Boleh Kosong',
                              confirmBtnText: 'OK',
                              onConfirmBtnTap: () {
                                Navigator.maybePop(context);
                              });
                        } else {
                          BuildContext context = this.context;
                          DataBarangService().createData(
                              kodeBarang.text,
                              kategori,
                              namaBarang.text,
                              hargaModal.text,
                              hargaJual.text,
                              jumlahBarang.text,
                              gambar!);
                          

                          clear();
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: 'Berhasil Menambahkan Barang',
                              confirmBtnText: 'OK',
                              onConfirmBtnTap: () {
                                Navigator.maybePop(context);
                              });
                        }
                      } catch (e) {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            text: 'Gagal Menambahkan Barang',
                            confirmBtnText: 'OK',
                            onConfirmBtnTap: () {
                              Navigator.pop(context);
                            });
                      }
                    },
                    child: Text(
                      'Tambah Barang',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )),
              ),
            )
          ],
        ),
      ),
      const Text('Analytics'),
      TextButton(
        onPressed: () {
          // try {
          //   DatabaseService().signOut();
          //   Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => LoginForm()),
          //     (Route<dynamic> route) => false,
          //   );
          // } catch (e) {
          //   print(e.toString());
          // }
        },
        child: Text('LogOut'),
      )
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 1, 192, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: pages.elementAt(current_index),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Color.fromARGB(255, 41, 126, 253),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        index: current_index,
        height: 70,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.history,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.analytics,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            current_index = index;
          });
        },
      ),
    );
  }
}
