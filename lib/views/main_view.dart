import 'package:flutter/material.dart';
import 'package:cc/views/chat_room_view.dart';
import 'package:cc/views/dict_room_view.dart';
import 'package:cc/views/meeting_room_view.dart';
import 'package:cc/views/place_room_view.dart';
import 'package:cc/views/profile_view.dart'; // 추가: ProfileView import

// MainView StatefulWidget 정의
class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

// _MainViewState 정의
class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    MeetingRoomView(),
    ChatRoomView(),
    PlaceRoomView(),
    DictRoomView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_widgetOptions
            .elementAt(_selectedIndex)
            .runtimeType
            .toString()
            .replaceAll('View', '')),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[800],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.meeting_room), label: '미팅방'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: '채팅방'),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: '장소방'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '사전방'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // 네비게이션 바 타입 설정
      ),
    );
  }
}
