# Let's Flutter 
## index
##### Widgets
[잡다한 내용들](#잡다한-내용들)    
[Alert Dialog](#alert-dialog)  
[Show Dialog](#show-dialog)  
[Future](#futre)  
[of method](#of-method)
[TextFormField](#textformfield)  
[Testing](#testing)  
##### Terms

----
#### 잡다한 내용들  
- Appbar는 context에 따라서 route가 아닌 경우 자동으로 back button을 생성하는 것 같다.
- Appbar 사이즈 조절은 PreferredSize 이용
- TextFormField의 Border를 설정할 때에는 InputDecoration의 enabled, focused Border 파라미터를 손대야 한다.
#### Alert Dialog
~~~dart
    return AlertDialog(
      title: new Text("Alert Dialog title"),
      content: new Text("Alert Dialog body"),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
~~~


#### show Dialog
~~~Dart
  return showDialog(
    context: context,
    builder: (BuildContext context){
      return DetailPage(chatRoom, roomCard) ;
    }
  );
  
  //chat room : room에 대한 정보가 들어있는 class
  //room Card : 만들어둔 
  ~~~
  ~~~
  //DetailPage class 내용
  
  class DetailPage extends StatelessWidget {
  
    final ChatRoom room ;
    final Container roomCard ;
  
    DetailPage(this.room, this.roomCard) ;
  
    @override
    Widget build(BuildContext context) {

      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          roomCard,
          ],
       );
     }
  }
~~~
---
#### Future  
- Dart는 single thread로 동작하기 때문에 instruction 중에 오래걸리는 것이 있으면 모든 화면이 freezing 한다.
- Future는 그러한 상황에서 비동기식 접긍을 위해 사용된다.  
- delayed computation을 나타냄(potential value, error 등 )
  
예제코드
~~~Dart
// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

Future<void> printDailyNewsDigest() async {
  var newsDigest = await gatherNewsReports();
  print(newsDigest);
} // await가 붙으면 비동기가 되면서 다른 instruction들을 먼저 수행하는 것 같다??

main() {
  printDailyNewsDigest();
  printWinningLotteryNumbers();
  printWeatherForecast();
  printBaseballScore();
}

printWinningLotteryNumbers() {
  print('Winning lotto numbers: [23, 63, 87, 26, 2]');
}

printWeatherForecast() {
  print("Tomorrow's forecast: 70F, sunny.");
}

printBaseballScore() {
  print('Baseball score: Red Sox 10, Yankees 0');
}

const news = '<gathered news goes here>';
const oneSecond = Duration(seconds: 1);

// Imagine that this function is more complex and slow. :)
Future<String> gatherNewsReports() =>
    Future.delayed(oneSecond, () => news);

// Alternatively, you can get news from a server using features
// from either dart:io or dart:html. For example:
//
// import 'dart:html';
//
// Future<String> gatherNewsReportsFromServer() => HttpRequest.getString(
//      'https://www.dartlang.org/f/dailyNewsDigest.txt',
//    );
~~~
위의 code를 실행하면 결과는 아래와 같다
~~~
Winning lotto numbers: [23, 63, 87, 26, 2]
Tomorrow's forecast: 70F, sunny.
Baseball score: Red Sox 10, Yankees 0
<gathered news goes here>
~~~  
가장 먼저 실행되는   printDailyNewsDigest();의 결과가 가장 나중에 반영되는 것을 볼 수 있다.
- 순서도  

![Future Async](Images/Future%20async-await.png)

1. The app begins executing.
2. The main() function calls the async function printDailyNewsDigest(), which begins executing synchronously.
3. printDailyNewsDigest() uses await to call the function gatherNewsReports(), which begins executing.
4. The gatherNewsReports() function returns an uncompleted future (an instance of Future<String>).
5. Because printDailyNewsDigest() is an async function and is awaiting a value, it pauses its execution and returns an uncompleted future (in this case, an instance of Future<void>) to its caller (main()).
6. The remaining print functions execute. Because they’re synchronous, each function executes fully before moving on to the next print function. For example, the winning lottery numbers are all printed before the weather forecast is printed.
7. When main() has finished executing, the asynchronous functions can resume execution. First, the future returned by gatherNewsReports() completes. Then printDailyNewsDigest() continues executing, printing the news.
8. When the printDailyNewsDigest() function body finishes executing, the future that it originally returned completes, and the app exits.
  
    
또 다른 예제이다
![Future example](Images/Future%20example.png)
  
[출처](https://medium.com/@changjoopark/%ED%94%8C%EB%9F%AC%ED%84%B0-flutter-%EC%95%B1-%EB%A7%8C%EB%93%A4%EA%B8%B0-%EB%B8%94%EB%A1%9C%EA%B7%B8-%EA%B8%80-%EC%83%81%EC%84%B8-dc1ba68d4cef)  




---



#### of method
~~~dart
@override
Widget build(BuildContext context) {
  return Text(
    'Example',
    style: Theme.of(context).textTheme.title,
  );
}
~~~
- of method에서는  제공받은 context를 통해 context.inheritFromWidgetOfExactType(type)
mthod를 사용한다.
- context에 of 내에 저장되어있는 widget을 등록시켜서 widget이 변경될 때 context를 rebuild한다.  
- 만약 위의 예제에서 Theme이 같은 build function 안에 생성된다면 of method가 Theme을 찾을 수 없기 때문에
Builder를 사용하여 아래와 같이 만들어준다.
~~~dart
@override
Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.light(),
    body: Builder(
      // Create an inner BuildContext so that we can refer to
      // the Theme with Theme.of().
      builder: (BuildContext context) {
        return Center(
          child: Text(
            'Example',
            style: Theme.of(context).textTheme.title,
          ),
        );
      },
    ),
  );
}
~~~
- 이유 : the context argument to the build function can't be used to find the Theme (since it's "above" the widget being returned)

----  

#### TextFormField  

- Form 과 함께 쓰인다
- Form의 key를 통해서 TextFormField의 state를 확인할 수 있다.

~~~dart

final formKey = GlobalKey<FormState>() ; //key 선언
/*
class ....
 */
  Form(
      key: formKey,
      child: TextFormField(
                 validator: (str) => str.isEmpty ? '제목을 입력해주세요!' : null,
                 //validator를 통해 text로 입력받은 값을 validation 한다. 
                 //반환 값이 null이 아닌 경우 border가 빨간색으로 칠해지면서 입력칸 하단에 '제목을 입력해주세요!' 라고 나온다
                 onSaved: (str) {
                  // text form field에 입력된 값이 str로 들어온다.
                 }
                 //어딘가에서 key를 가지고 save를 시키는 경우 실행된다.
                 //아래 validate method 참고
            ),
  )
  /*
  ....
   */
  
  // 완료버튼이 눌리면 validate method 실행
  FlatButton(
      child: Text(
          '완료',
      ),
      onPressed: (){
        validate(context) ;
      },
  )
  
  //validate에서 우리가 Form에 사용했던 formKey를 이용해
  void validate(context){
      final form = formKey.currentState ;
      if(form.validate()){
        form.save() ; 
        //formKey가 key로 적용되어 있는 Form 내부의 FormField들이 onSaved
      }
    }

~~~  

----

#### Testing  

- 3가지 종류가 있다. Unit tests, Widget tests, Integration tests [참고](https://flutter.dev/docs/testing#unit-tests)
    - unit tests: single function, method, class 의 작은 단위를 테스트하는 것을 말한다.
    - widget tests: component test 라고도 불리며 Widget 단위로 테스트하는 것을 말한다.
    - integration tests: 전체의 어플리케이션 단위의 테스트를 말한다.
- Flutter Test를 자동으로 해주는 [codemagic](https://codemagic.io/start/) 이라는 사이트도 있다.

##### Widget Test  

- Material App으로 widget을 감싸주지 않으면 Medeia query error가 발생한다.
~~~

    await tester.pump();
    // rebuild 되는 것을 보장한다.

~~~