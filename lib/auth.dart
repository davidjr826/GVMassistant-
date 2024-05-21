// import 'package:firebase_auth/firebase_auth.dart';
// class auth{
//   final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
//   User? get currentUser => _firebaseAuth.currentUser;
//
//   Stream<User?> get authstateChange => _firebaseAuth.authStateChanges();
//
//   Future<void> signInWithEmailAndPassword({
//     required String email,
//     required String password,
// }) async{
//     await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password
//      );
//   }
//   Future<void> createUserWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async{
//     await _firebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   }
//   Future<void> signOut() async{
//     await _firebaseAuth.signOut();
//   }
// }
//
