import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';


class SignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
     UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}

class DataBarangService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createData(String kodeBarang,String kategori,String namaBarang, String hargaModal, String hargaJual, String jumlahBarang, String gambar) async {
    try {
      await _firestore.collection('barang').doc(kodeBarang).set({
        'kategori': kategori,
        'namaBarang': namaBarang,
        'hargaModal': hargaModal,
        'hargaJual': hargaJual,
        'jumlahBarang': jumlahBarang,
        'gambar': gambar, 
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateData(String namaBarang, String hargaModal, String hargaJual, String jumlahBarang) async {
    try {
      await _firestore.collection('barang').doc().update({
        'namaBarang': namaBarang,
        'hargaModal': hargaModal,
        'hargaJual': hargaJual,
        'jumlahBarang': jumlahBarang,

      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> uploadImage(File file) async {
    String fileName = basename(file.path);
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();

  }

  
}


