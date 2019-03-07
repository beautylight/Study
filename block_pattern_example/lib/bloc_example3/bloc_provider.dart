import 'package:flutter/material.dart';
import './sample_bloc.dart' show SampleBloc;
//show 는 뭐지..

class BlocProvider extends InheritedWidget { //inheritedWidget..
  final blocState = new _BlocState(
    sampleBloc: SampleBloc(),
  );

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static _BlocState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .blocState; //얘는 왜 붙어있는거지
    //bloc State 중에서 parameter로 받은 blocprovider와 일치하는 애를 찾는건가?
  }
}

class _BlocState {
  final SampleBloc sampleBloc;

  _BlocState({
    this.sampleBloc,
  });
}