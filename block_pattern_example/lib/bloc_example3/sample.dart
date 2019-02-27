import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'sample_bloc.dart';

class Sample extends StatelessWidget {
  final SampleBloc bloc = SampleBloc();
//sample bloc 생성
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(height: 12.0),
            Text('SampleChild1'),
            SampleChild1(bloc),
            Container(height: 12.0),
            Text('SampleChild2'),
            SampleChild2(bloc),
            Container(height: 12.0),
            Text('SampleChild3'),
            SampleChild3(bloc),
            // children들은 Stateless widget을 extend
            // constructor로 bloc을 받음..
            // 어떻게 사용하는지 보자
          ],
        ),
      ),
    );
  }
}

class SampleChild1 extends StatelessWidget {
  SampleChild1(this.bloc);
  final SampleBloc bloc;

  @override
  Widget build(BuildContext context) {
    // stream builder를 사용.. 
    // bloc의 message stream을 stream에 설정.
    return StreamBuilder(
      stream: bloc.message,
      builder: (context, snapshot) { //bloc에서 넘어오는 snapshot들을 받아서
        return Container(
          child: Text(snapshot.data ?? ''), // snapshot의 data들을 text로 호출
        );
      },
    );
  }
}

//sample child1 과 마찬가지
class SampleChild2 extends StatelessWidget {
  SampleChild2(this.bloc);
  final SampleBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.message,
      builder: (context, snapshot) {
        return Container(
          child: Text(snapshot.data ?? ''),
        );
      },
    );
  }
}

class SampleChild3 extends StatelessWidget {
  SampleChild3(this.bloc);
  final SampleBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.message,
      builder: (context, snapshot) { // 여기까지는 child 1,2 와 같다.
        return Container(
          width: 200.0,
          child: TextField( // Text Field에서 내용이 바뀌면
            onChanged: (String str) => bloc.setMessage(str), //bloc에 setMessage method를 통해 전달
          ),
        );
      },
    );
  }
}