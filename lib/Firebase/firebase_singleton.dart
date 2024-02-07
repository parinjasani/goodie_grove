import 'package:firebase_auth/firebase_auth.dart';

class FirebaseSingleton{

  static final FirebaseSingleton _instance = FirebaseSingleton._internal();

  factory FirebaseSingleton(){
    return _instance;
  }



  FirebaseSingleton._internal();


  Future<dynamic> login(String email,String password) async {
  UserCredential credential =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  return credential;
  }

   Future<dynamic> forgetmethod(String email) async {
    var forgetcredential  = await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    return forgetcredential;
  }
}