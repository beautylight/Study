
###2019.02.21

#### 1번째 삽질 (repository 만들고 local과 연결)
1. local 저장소를 만듦
2. repository를 만듦
3. pull과 push가안됨
4. repository를 만들 때 readme.md를 만들었고, local 저장소를 만들 때study_flutter 파일을 만들었더니 conflict 발생한거였음. pull할 때 history 어쩌고 하는 오류
5. history 무시하는 옵션 넣어서 pull, readme.md 파일이 local로 땡겨짐
6. push.


#### 2번 째 삽질 (gitignore)
1. md 파일을 intellij에서 열려고 함
2. .idea 폴더가 생김
3. ignore 파일을 아직 안만들었다는 것이 생각나 만들고 commit하고 push함
4. typo ... gitignore가 아니라 ignore이라고 씀..
5. git rm --cached -r filename 으로 github에서 삭제 (맞나?)
6. .gitignore 파일 만들고 다시 add, push, commit
tip. git rm -r --cached . -> add됐던 파일들을 다 삭제

#### 3번 째 삽질 (마크다운 내부링크)
1. Study_Flutter.md 파일 만들고 내부 링크 기능을 써보려 함
2. \#으로 하는 index가 안됨 그냥 \#으로 나옴(백스페이스 안했는데..)
3. 커밋 푸쉬 한 10번 함
4. \# 다음에 띄어쓰기 하니까 됨
5. 내부 링크하는 방법
`[링크이름](#제목-이름)`   
=> 띄어쓰기는 - 로 표기, \#이 붙은 제목으로만 이동 가능한듯?

6. (참고)인텔리제이 마크다운 창에서는 내부링크가 안먹힌다...
~~~
EX)
[Alert Dialog](#alert-dialog)
~중략~
#### Alert Dialog
~~~
