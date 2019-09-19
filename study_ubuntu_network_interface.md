# 우분투 네트워크 인터페이스
주제 : 우분투에서 네트워크 인터페이스를 만져서 특정 wireless 네트워크에만
연결되도록 하고 싶다.   
시나리오 : 최초에는 유선랜으로 연결, 인터페이스를 변경하여 wireless 네트워크에만 기기가 연결되도록
설정을 바꿔준다.

## index  

[우분투 네트워크 명령어 정리](#우분투-인터페이스-관련-명령어)  
[삽질](#삽질)   
[MVVM Pattern](#MVVM-Pattern)

---

### 우분투 인터페이스 관련 명령어

##### 연결된 wlan0 확인 (SSID 확인) - wireless 만 확인 가능하다
~~~
iw wlan0 link
~~~ 
  
##### 연결된 eth0, wlan0 확인
~~~
ip a show wlan0 up
~~~
##### 인터페이스 on/off
~~~
ip link set wlan0 up
ifconfig wlan0 up
ifup wlan0
~~~
 - 3가지
 - ifconfig는 interface를 직접 통제한다.
 - ifup은 /etc/network/interfaces 의 내용을 사용한다. 
 - up / down 으로 바꿔서 사용하면 된다
 
 ##### 네트워크 서비스 재시작
 ~~~
 service networking restart
 /etc/init.d/networking restart
 ~~~
 - 2가지 
 
 ##### 네트워크 인터페이스 관련 파일
 /etc/wpa_supplicant.conf
 /etc/NetworkManager/NetworkManager.conf (Manager였는지 manager였는지)
 /etc/network/interfaces
 
 ### 삽질

1. /etc/network/interface 의 내용을 바꿔주면 네트워크 연결을 설정할 수 있다.

~~~
auto lo
iface lo inet loopback

auto wlan0
allow-hotplug wlan0
iface wlan0 inet dhcp
    wpa-ssid thisisWIfiname
    wpa-psk thisispassword
    
~~~

- 문제점 : 유선랜 연결을 끊어도 와이파이가 바로 잡히지 않음
- 문제점 : 네트워크 서비스를 재시작하려고 해도 failed, 에러남
- 재부팅하면 적용됨
- 그러나 재부팅 없이 서비스를 조작하여 설정이 바로 적용되도록 하고 싶다.