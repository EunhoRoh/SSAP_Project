//firebase를 사용하려면 initialization을 해줘야 한다.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssap_project/src/pages/home.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key); //app에다 ?를 붙여 null safety하기, const는 안해도 된다

  @override
  Widget build(BuildContext context) {
    //future builder를 사용해야 한다.
    return FutureBuilder(
      future: Firebase.initializeApp(), //firebase initialize 확인
      builder: (context, snapshot) {
        //firebase의 data가 snapshot에 저장됨
        if (snapshot.hasError) {
          //snapshot에 error가 있으면 error 처리
          return Center(
            child: Text("Firebase load fail"),
          ); //텍스트로 에러 처리
        }
        if (snapshot.connectionState == ConnectionState.done) {
          //connection state가 done일 경우
          return Home(); //firebase initialize가 잘 되었을 때  home을 호출한다. 다음 페이지로 넘기는 거다.
        }
        return CircularProgressIndicator(); // 아직 연결 안되었을 때 로딩 처리
      },
    );
  }
}
