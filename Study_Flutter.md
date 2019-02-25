# Let's Flutter 
## index
##### Widgets
[Alert Dialog](#alert-dialog)

##### Terms

----

#### Alert Dialog
~~~
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

#### Future
+ delayed computation을 나타냄
+ potential value, error 등