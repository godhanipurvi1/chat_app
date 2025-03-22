import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/firestore_service.dart';
import '../model/chat_mode.dart';
import '../model/user_model.dart';
import '../services/Firebase_Cloud_messaging_Services.dart';
import '../services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = Get.arguments;
    TextEditingController msgController = TextEditingController();
    TextEditingController editMSGController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user.image),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 22, // Updated font size
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2575fc),
                      ),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black, // Lighter email color
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 6),
                // IconButton(
                //   onPressed: () async {
                //     await NotificationService.notificationService
                //         .showBigPictureNotification(
                //       title: user.name,
                //       body: user.email,
                //       url: "https://your-image-url.jpg", // Adjusted image URL
                //     );
                //   },
                //   icon: Icon(
                //     Icons.notifications_active_outlined,
                //     color: Colors.purple.shade400, // Adjusted icon color
                //   ),
                // ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FireStoreService.fireStoreService.fetchChats(
                      sender: AuthService.instance.currentUser!.email ?? "",
                      receiver: user.email),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      var data = snapShot.data;
                      List<QueryDocumentSnapshot<Map<String, dynamic>>>
                          allData = data!.docs;

                      List<ChatModal> allChats = allData
                          .map(
                            (e) => ChatModal.fromMap(data: e.data()),
                          )
                          .toList();

                      return (allChats.isNotEmpty)
                          ? ListView.builder(
                              itemCount: allChats.length,
                              itemBuilder: (context, index) {
                                DateTime time = allChats[index].time.toDate();
                                return (allChats[index].receiver == user.email)
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            child: GestureDetector(
                                              onLongPress: () {
                                                Get.defaultDialog(
                                                  content: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          Get.back();
                                                          FireStoreService
                                                              .fireStoreService
                                                              .deleteChat(
                                                            sender: AuthService
                                                                    .instance
                                                                    .currentUser!
                                                                    .email ??
                                                                "",
                                                            receiver:
                                                                user.email,
                                                            id: allData[index]
                                                                .id,
                                                          );
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: Colors.red
                                                              .shade400, // Updated red color
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          editMSGController
                                                                  .text =
                                                              allChats[index]
                                                                  .msg;
                                                          Get.back();
                                                          Get.bottomSheet(
                                                            Container(
                                                              height:
                                                                  120, // Increased height
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          15), // Updated radius
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15),
                                                                ),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      16), // Added more padding
                                                              child: TextField(
                                                                controller:
                                                                    editMSGController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  suffixIcon:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      String
                                                                          msg =
                                                                          editMSGController
                                                                              .text;

                                                                      if (msg
                                                                          .isNotEmpty) {
                                                                        FireStoreService.fireStoreService.updateChat(
                                                                            sender: AuthService.instance.currentUser!.email ??
                                                                                "",
                                                                            receiver:
                                                                                user.email,
                                                                            id: allData[index].id,
                                                                            msg: msg);
                                                                      }

                                                                      Get.back();
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .update),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        icon: Icon(
                                                          Icons.edit,
                                                          color:
                                                              Color(0xffffffff),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.all(
                                                    8), // Increased margin
                                                padding: const EdgeInsets.all(
                                                    12), // Increased padding
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18), // Updated border radius
                                                  color: Color(0xff2575fc),
                                                ),
                                                child: Text(
                                                  allChats[index].msg,
                                                  style: TextStyle(
                                                      color: Colors
                                                          .white), // Adjusted text color
                                                ),
                                              ),
                                            ),
                                          ),
                                          Transform.translate(
                                            offset: const Offset(0, 5),
                                            child: Text(
                                              "${time.hour % 12}:${time.minute}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey
                                                    .shade500, // Lighter text color
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(
                                                8), // Increased margin
                                            padding: const EdgeInsets.all(
                                                12), // Increased padding
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  18), // Updated border radius
                                              color: Color(0xff2575fc),
                                            ),
                                            child: Text(
                                              allChats[index].msg,
                                              style: TextStyle(
                                                  color: Colors
                                                      .black87), // Adjusted text color
                                            ),
                                          ),
                                        ],
                                      );
                              })
                          : Center(
                              child: Image.network(
                                  'https://cdn.dribbble.com/users/172747/screenshots/3135893/peas-nochats.gif'),
                            );
                    }
                    return Container();
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: msgController,
                    onSubmitted: (val) async {
                      if (val.isNotEmpty) {
                        String senderEmail =
                            AuthService.instance.currentUser!.email ?? "";
                        FireStoreService.fireStoreService.sentChat(
                          chatModal: ChatModal(
                            msg: val,
                            sender: senderEmail,
                            receiver: user.email,
                            time: Timestamp.now(),
                          ),
                        );
                        await FirebaseCloudMessagingService.instance
                            .sendNotification(
                          notificationTitle:
                              AuthService.instance.currentUser!.email ?? "",
                          notificationBody: val,
                          deviceToken: user.token,
                        );
                      }

                      msgController.clear();
                    },
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.all(12), // Added padding
                      fillColor: Colors.white, // Input field background color
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  width: 20,
                ),
                IconButton.filled(
                  onPressed: () async {
                    String msg = msgController.text;
                    String senderEmail =
                        AuthService.instance.currentUser!.email ?? "";

                    if (msg.isNotEmpty) {
                      FireStoreService.fireStoreService.sentChat(
                        chatModal: ChatModal(
                          msg: msg,
                          sender: senderEmail,
                          receiver: user.email,
                          time: Timestamp.now(),
                        ),
                      );

                      await FirebaseCloudMessagingService.instance
                          .sendNotification(
                        notificationTitle:
                            AuthService.instance.currentUser!.email ??
                                "", // Correct parameter name
                        notificationBody: msg, // Correct parameter name
                        deviceToken: user.token, // Correct parameter name
                      );
                    }

                    msgController.clear();
                  },
                  icon: const Icon(Icons.send),
                  style: IconButton.styleFrom(
                    backgroundColor: Color(0xff2575fc),
                    padding: const EdgeInsets.all(15), // Increased padding
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
