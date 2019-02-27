import 'dart:async';

class SampleBloc extends Object {
  final _message = StreamController<String>.broadcast();

  Stream<String> get message => _message.stream;

  Function(String) get setMessage => _message.sink.add;
  // Function(String)과 get은 정확히 모르겠지만 (get은 getter만들때 쓰는 것 같긴 한데..)
  // setMessage 는 bloc 내의 _message라는 stream controller의 sink를 통해 정보를 add한다.
  // 아 Function(String)이 function name, parameter type 인 것 같네

  init() {
//    print('init');
//    await Future.delayed(Duration(seconds: 2));
//    setMessage('message');
  }

  SampleBloc() {
    init();
  }

  dispose() {
    _message.close();
  }
}