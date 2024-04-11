import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/Screens/loader.dart';
import 'package:mobile_application/Screens/mainScreen.dart';
import 'package:mobile_application/Services/message_helper.dart';
import 'package:mobile_application/controllers/chat_provider.dart';
import 'package:mobile_application/events/custom_appBar.dart';
import 'package:mobile_application/events/message_response.dart';
import 'package:mobile_application/events/messanging_text_field.dart';
import 'package:mobile_application/events/send_message.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CoversationPage extends StatefulWidget {
  const CoversationPage(
      {super.key,
      required this.title,
      required this.id,
      required this.profile,
      required this.user});

  final String title;
  final String id;
  final String profile;
  final List<String> user;

  @override
  State<CoversationPage> createState() => _CoversationPageState();
}

class _CoversationPageState extends State<CoversationPage> {
  TextEditingController messageController = TextEditingController();
  int offset = 1;
  IO.Socket? socket;
  late Future<List<ReceivedMessge>> msgList;
  List<ReceivedMessge> messages = [];
  String receiver = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getMessage(offset);
    connect();
    joinChat();
    handleNext();
    super.initState();
  }

  void getMessage(int offset) {
    msgList = MesssagingHelper.getMessages(widget.id, offset);
  }

  void handleNext() {
    _scrollController.addListener(() async {
      if (_scrollController.hasClients) {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          print("<<><><loading><><>>");
          if (messages.length >= 12) {
            getMessage(offset++);
            setState(() {});
          }
        }
      }
    });
  }

  void connect() {
    var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO.io('https://jobsl-production.up.railway.app', <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false,
    });
    socket!.emit("setup", chatNotifier.userId);
    socket!.connect();
    socket!.onConnect((_) {
      print("Connected to front end");
      socket!.on('online-users', (userId) {
        chatNotifier.online
            .replaceRange(0, chatNotifier.online.length, [userId]);
      });
      socket!.on('typing', (status) {
        chatNotifier.typingStatus = false;
      });
      socket!.on('stop typing', (status) {
        chatNotifier.typingStatus = true;
      });
      socket!.on('message received', (newMessageReceived) {
        sendStopTypingEvent(widget.id);
        ReceivedMessge receivedMessge =
            ReceivedMessge.fromJson(newMessageReceived);

        if (receivedMessge.sender.id != chatNotifier.userId) {
          setState(() {
            messages.insert(0, receivedMessge);
          });
        }
      });
    });
  }

  void sendMessage(String content, String chatId, String receiver) {
    SendMessage model =
        SendMessage(content: content, chatId: chatId, receiver: receiver);

    MesssagingHelper.sendMessage(model).then((response) {
      var emmission = response[2];
      socket!.emit('new message', emmission);
      sendStopTypingEvent(widget.id);
      setState(() {
        messageController.clear();
        messages.insert(0, response[1]);
      });
    });
  }

  void sendTypingEvent(String status) {
    socket!.emit('typing', status);
  }

  void sendStopTypingEvent(String status) {
    socket!.emit('stop typing', status);
  }

  void joinChat() {
    socket!.emit('join chat', widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatNotifier>(
      builder: (context, chatNotifier, child) {
        receiver = widget.user.firstWhere((id) => id != chatNotifier.userId);
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: CustomAppBar(
                text: !chatNotifier.typing ? widget.title : "Typing...",
                actions: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.profile),
                        ),
                        Positioned(
                            right: 3,
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor:
                                  chatNotifier.online.contains(receiver)
                                      ? Colors.green
                                      : Colors.grey,
                            ))
                      ],
                    ),
                  )
                ],
                child: Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => MainScreen());
                    },
                    child: const Icon(
                      MaterialCommunityIcons.arrow_left_circle,
                    ),
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h),
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<ReceivedMessge>>(
                          future: msgList,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                "Error${snapshot.error}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red),
                              );
                            } else if (snapshot.data!.isEmpty) {
                              return const SearchLoading(
                                text: "You don't have any chats",
                              );
                            } else {
                              final msgList = snapshot.data;
                              messages = messages + msgList!;
                              return ListView.builder(
                                  padding:
                                      EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
                                  itemCount: messages.length,
                                  reverse: true,
                                  controller: _scrollController,
                                  itemBuilder: (context, index) {
                                    final data = messages[index];
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(top: 8, bottom: 10.h),
                                      child: Column(
                                        children: [
                                          Text(
                                            chatNotifier.msgTime(
                                                data.chat.updatedAt.toString()),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ChatBubble(
                                            alignment: data.sender.id ==
                                                    chatNotifier.userId
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                            backGroundColor: data.sender.id ==
                                                    chatNotifier.userId
                                                ? Colors.blue
                                                : Colors.orange,
                                            elevation: 0,
                                            clipper: ChatBubbleClipper4(
                                                radius: 5,
                                                type: data.sender.id ==
                                                        chatNotifier.userId
                                                    ? BubbleType.sendBubble
                                                    : BubbleType
                                                        .receiverBubble),
                                            child: Container(
                                              constraints:
                                                  const BoxConstraints(maxWidth: 100),
                                              child: Text(
                                                data.content,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            }
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.bottomCenter,
                      child: MessagingField(
                          onSubmitted: (_) {
                            String msg = messageController.text;
                            sendMessage(msg, widget.id, receiver);
                          },
                          sufixIcon: GestureDetector(
                            onTap: () {
                              String msg = messageController.text;
                              sendMessage(msg, widget.id, receiver);
                            },
                            child: const Icon(
                              Icons.send,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          onTapOutside: (_) {
                            sendStopTypingEvent(widget.id);
                          },
                          onChanged: (_) {
                            sendTypingEvent(widget.id);
                          },
                          onEditingComplete: () {
                            String msg = messageController.text;
                            sendMessage(msg, widget.id, receiver);
                          },
                          messageController: messageController),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
