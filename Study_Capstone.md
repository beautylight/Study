# Let's Capstone
## index
### 
[Firebase 연동](#Firebase-연동)   
[Firestore Provider]($Firesotre-Provider)  

----
#### Firebase 연동
- FireBase 프로젝트 생성
- Flutter 프로젝트 내의 'AnfroidManifest.xml' file에서 'com.project.name' 과 같은 package 이름 확인
- FireBase 프로젝트 콘솔에서 어플리케이션 생성
- json파일 삽입 : Android의 경우 google-services.json 파일을, IOS의 경우 GoogleService-Info.plist 파일을 FireBase에서 제공해줌
    - Android: Flutter Project 내에서 /android/app 폴더에 google-services.json 넣음, 
    - IOS: Flutter Project 내에서 /ios/Runner 폴더에 GoogleService-Info.plist 파일을 넣음
- package gradle 수정    

- Android: android/build.gradle에 
~~~  

dependencies {
    classpath 'com.android.tools.build:gradle:3.2.1'
    //classpath 'com.google.gms:google-services:3.2.1' 추가
}
~~~    
    
- android/app/build.gradle에      

~~~
dependencies {
    testImplementation 'junit:junit:4.12'
    androidTestImplementation 'com.android.support.test:runner:1.0.2'
    androidTestImplementation 'com.android.support.test.espresso:espresso-core:3.0.2'
    //implementation 'com.google.firebase:firebase-core:16.0.1' 추가
}

//apply plugin: 'com.google.gms.google-services'   추가

~~~

- pubspec.yaml 파일에
~~~
dependencies:

  //cloud_firestore: 추가

  flutter:
    sdk: flutter
  //firebase_core: ^0.3.1+1  # add dependency for Firebase Core 추가
  //firebase_analytics: ^2.1.0  # add dependency for Google Analytics for Firebase 선택적추가

~~~

- flutter get package.
- 근데 IOS는 옳게 된건지 모르겠다..

- 이후 bloc에 Fire store 추가
~~~Dart
import 'package:cloud_firestore/cloud_firestore.dart' ;
 //....
class RoomBloc extends Object{
  final _roomInfo = Firestore.instance.collection('roomInfo').snapshots() ;
  // roomInfo 는 FireBase에 있는 컬렉션(?) 이름
~~~
- 이후에 방 list build하는 부분에 stream builder 추가
~~~Dart
return StreamBuilder(
      stream: BlocProvider.of(context).roomBloc.roomInfo,
      builder: (context, snapshot) {
        if(!snapshot.hasData) return const Text('Loading..') ;
        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
          ),
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, int) {
            return new RoomCard(context, snapshot.data.documents[int]);
          },
        );
      }
    );
~~~

----  

#### Firestore Provider  
- bloc처럼 Provider를 두었다.
- 정보를 받아오는 Stream이나 정보를 입력할 때에도 provider를 통해 통신한다.
- bloc의 코드가 한결 간결해졌다(firestore와 통신하는 부분을 bloc에서 했었다.)

~~~dart
class FirestoreProvider {

  Firestore _firestore = Firestore.instance ;

  //firestore에서 정보를 받아오는 부분
  Stream<QuerySnapshot> get roomList => _firestore.collection('roomInfo').snapshots() ;
  
  //firestore에 정보를 insert하는 부분
  Future<void> registerRoom(RoomInfo roomInfo) async {
    return _firestore.collection('roomInfo').document().setData({
      'name' : roomInfo.roomName,
      'dateNtime' : roomInfo.dateNTime,
      'currentnumber' : 2,
      'totalnumber' : 4,
    }) ;
  }
}
~~~
