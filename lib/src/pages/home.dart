import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/notification_blocks.dart';
import 'login.dart';

class Home extends StatelessWidget {
  //로그인이 되었으면 나오는 메인 페이지
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //로그인을 했는지 안했는지 판별 해주기
    //authStateChanges()는 Stream이다. Streambuilder로 처리하기
    return Scaffold(
      //scaffold로 return

      body: StreamBuilder<User?>(
        //상태는 stream이다 streambuilder 사용, user type 정해주는게 좋음
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          //User로 데이터가 들어올거다
          //snapshot이 dynamic이다. stream이 무엇을 반환할줄 모르기때문에 dynamic이다.
          if (!snapshot.hasData) {
            //만약에 snapshot이 데이터를 가지고 있지 않으면 Login 페이지로 가기
            return LoginWidget();
          } else {
            //회원이 로그인이 된 상태이다.
            //로그인이 처리가 되면 return하는 페이지
            return Center( 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, //중앙정렬처리하기
                children: [
                  // Text("${snapshot.data?.displayName}님 환영합니다."),
                  Text("환영합니다.\n${FirebaseAuth.instance.currentUser!.email}"),
                  //로그인이 되면 환영 메세지 출력
                  ElevatedButton(
                      onPressed: FirebaseAuth.instance.signOut,
                      child: Text("로그아웃")),

                  // TextButton(
                  //   style: TextButton.styleFrom(
                  //     primary: Colors.grey.withOpacity(0.3),
                  //   ),
                  //   onPressed: FirebaseAuth.instance.signOut,
                  //   //버튼을 누르면 구글 signout 실행
                  //   child: Text("로그아웃"),
                  // ),
                ],
              ),
              NotificationBlock(),
            );
          }
        },
      ),
    );
  }
}
