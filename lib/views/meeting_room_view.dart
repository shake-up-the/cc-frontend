import 'package:flutter/material.dart';

// 미팅방 정보를 나타내는 클래스 (모의 데이터를 위한)
class MeetingRoom {
  final String title;
  final int participationRate;

  MeetingRoom({required this.title, required this.participationRate});
}

class MeetingRoomView extends StatefulWidget {
  @override
  _MeetingRoomViewState createState() => _MeetingRoomViewState();
}

class _MeetingRoomViewState extends State<MeetingRoomView> {
  // 모의 데이터
  List<MeetingRoom> meetingRooms = [
    MeetingRoom(title: '미팅방 1', participationRate: 20),
    MeetingRoom(title: '미팅방 2', participationRate: 50),
    MeetingRoom(title: '미팅방 3', participationRate: 70),
  ];

  // 정렬 상태
  bool sortByParticipation = false;

  void sortRooms() {
    if (sortByParticipation) {
      meetingRooms
          .sort((a, b) => b.participationRate.compareTo(a.participationRate));
    } else {
      meetingRooms.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  @override
  Widget build(BuildContext context) {
    // 리스트 정렬
    sortRooms();

    return Scaffold(
      appBar: AppBar(
        title: Text('미팅방'),
        actions: [
          // 정렬 선택 바
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                sortByParticipation = value == '참여율 순';
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: '최신순', child: Text('최신순')),
                PopupMenuItem(value: '참여율 순', child: Text('참여율 순')),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0), // 마진 적용
        child: ListView.builder(
          itemCount: meetingRooms.length,
          itemBuilder: (context, index) {
            // 각 미팅방 정보를 리스트 타일로 표시
            return Card(
              child: ListTile(
                title: Text(meetingRooms[index].title),
                trailing: Text('${meetingRooms[index].participationRate}% 참여'),
              ),
            );
          },
        ),
      ),
    );
  }
}
