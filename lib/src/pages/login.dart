//로그인 페이지
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  //구글 로그인 프로세스
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _signUp() async {
    //await이니까 async로
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "eunho111@naver.com",
        password: "1234",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void _signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "eunho111@naver.com", password: "1234");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("회원 로그인 "),
        ),
        body: Center(
          child: Column(
            //버튼 나열하기
            mainAxisAlignment: MainAxisAlignment.center, //로그인 버튼을 중앙정렬로
            children: [
              ElevatedButton(
                  onPressed: _signUp, //_signUp 이벤트로 처리하기
                  child: Text("회원가입")),
              ElevatedButton(onPressed: _signIn, child: Text("로그인")),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.red,
                  //primary: Colors.red.withOpacity(0.3),
                ),
                onPressed: signInWithGoogle, //버튼을 누르면 구글 signin 실행
                child: Text("Google Login"),
              ),
            ],
          ),
        )); //로그인을 구현하기
  }
}
