import 'package:cc/models/chat_room.dart';
import 'package:flutter/material.dart';

// 예시 데이터, 실제 앱에서는 서버에서 데이터를 가져옵니다.
List<ChatRoom> chatRooms = [
  ChatRoom(id: '1', name: '채팅방 1', lastMessage: '안녕하세요!'),
  ChatRoom(id: '2', name: '채팅방 2', lastMessage: '오늘 계획은?'),
  ChatRoom(id: '3', name: '채팅방 3', lastMessage: '내일 만나요.'),
];

class ChatRoomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅방 목록'),
      ),
      body: ListView.builder(
        itemCount: chatRooms.length,
        itemBuilder: (context, index) {
          ChatRoom room = chatRooms[index];
          return ListTile(
            title: Text(room.name),
            subtitle: Text(room.lastMessage),
            onTap: () {
              // 여기에서 채팅방으로 이동하는 로직을 구현합니다.
              // 예시: 채팅방 상세 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatDetailScreen(chatRoom: room)),
              );
            },
          );
        },
      ),
    );
  }
}

// 이 예제에서는 실제 채팅 상세 화면이 구현되어 있지 않기 때문에
// 대신 비어 있는 ChatDetailScreen을 생성합니다. 실제 앱에서는 상세 채팅 내용을 보여주는 화면을 구현해야 합니다.
class ChatDetailScreen extends StatelessWidget {
  final ChatRoom chatRoom;

  ChatDetailScreen({required this.chatRoom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatRoom.name),
      ),
      body: Center(
        child: Text('채팅방 "${chatRoom.name}"의 상세 화면입니다.'),
      ),
    );
  }
}
