#Design Pattern

##index
[BLoC Pattern](#BLoC-Pattern)
[Redux Pattern](#Redux-Pattern)

---

### Bloc Pattern

- BLoC 패턴은 스트림을 이용하여 만들어진다.
- 위젯이 Sinks를 통해 BLoC에 이벤트를 보내면, BLoC이 stream을 통해 위젯들에게 결과를 통지한다.  
- UI 단에서는 BLoC에 대해 신경쓰지 않는다.

 
 - [코드 출처](https://javaexpert.tistory.com/970)
~~~Dart
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Streams Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Provider 제공
        home: BlocProvider<IncrementBloc>(
          bloc: IncrementBloc(),
          child: CounterPage(),
        ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc bloc = BlocProvider.of<IncrementBloc>(context);
            // bloc 인스턴스 생성
    return Scaffold(
      appBar: AppBar(title: Text('Stream version of the Counter App')),
      body: Center(
        child: StreamBuilder<int>( // StreamBuilder
          stream: bloc.outCounter, //bloc을 등록
          initialData: 0,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot){
            return Text('You hit me: ${snapshot.data} times');
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          bloc.incrementCounter.add(null);
        },
      ),
    );
  }
}

class IncrementBloc implements BlocBase {
  int _counter;

  //
  // Stream to handle the counter
  //
  StreamController<int> _counterController = StreamController<int>();
  StreamSink<int> get _inAdd => _counterController.sink;
  Stream<int> get outCounter => _counterController.stream;

  //
  // Stream to handle the action on the counter
  //
  StreamController _actionController = StreamController();
  StreamSink get incrementCounter => _actionController.sink;

  //
  // Constructor
  //
  IncrementBloc(){
    _counter = 0;
    _actionController.stream
                     .listen(_handleLogic);
  }

  void dispose(){
    _actionController.close();
    _counterController.close();
  }

  void _handleLogic(data){
    _counter = _counter + 1;
    _inAdd.add(_counter);
  }
}

///
// Generic Interface for all BLoCs
abstract class BlocBase {
  void dispose();
}

// Generic BLoC provider
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }): super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

// of 라는 method 선언, provider class 내의 <T> type의 bloc을 return
  static T of<T extends BlocBase>(BuildContext context){
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>>{
  @override
  void dispose(){
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return widget.child;
  }
}

~~~


- EX) 로그인 상태 관리

    - 일반 : 메인페이지 -> 로딩 -> 로그인 확인 후, 로그인 화면 or 메인 화면
    - BLoC : 메인페이지 -> Auth(StreamBuilder) -> snapshot data가 없음 -> Loading -> 로그인 확인 후 , 로그인 화면 or 메인 화면    
    => 로그아웃 -> Auth에서 알아서 login page로 관리  
    => 간편함
- 문제점 => 애니메이션이 없다
-   


---
### Redux Pattern  

- Redux를 설명하기위해서는 MVC와 FLUX 패턴에 대한 설명이 필요하다.  
![MVC 패턴](Images/Patterns/MVC.png){: width="100%" heigh="60%"}
