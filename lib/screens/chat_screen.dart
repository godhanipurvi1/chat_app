// import 'dart:developer';
//
// import 'package:chat_app/Route/app_route.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controllers/home_controller.dart';
// import '../model/user_model.dart';
// import '../services/firestore_service.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
//   HomeController controller = Get.put(HomeController());
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//
//     log("App Lifecycle State: $state");
//
//     switch (state) {
//       case AppLifecycleState.resumed:
//         log("Resumed State...");
//         break;
//       case AppLifecycleState.inactive:
//         log("Inactive State...");
//         break;
//       case AppLifecycleState.hidden:
//         log("Hidden State...");
//         break;
//       case AppLifecycleState.paused:
//         log("Paused State...");
//         break;
//       case AppLifecycleState.detached:
//       // TODO: Handle this case.
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(
//         child: Column(
//           children: [
//             FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//               future: FireStoreService.fireStoreService.fetchSingleUser(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text("Error: ${snapshot.error}"));
//                 } else if (snapshot.hasData) {
//                   var user =
//                       UserModel.fromMap(data: snapshot.data?.data() ?? {});
//                   return UserAccountsDrawerHeader(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Colors.blue, Colors.green],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                     ),
//                     accountName: Text(
//                       user.name,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     accountEmail: Text(
//                       user.email,
//                       style: TextStyle(color: Colors.white70),
//                     ),
//                     currentAccountPicture: CircleAvatar(
//                       backgroundImage: NetworkImage(user.image),
//                     ),
//                   );
//                 }
//                 return const Center(child: Text("No user data found"));
//               },
//             ),
//             Divider(),
//             ListTile(
//               onTap: () {
//                 controller.signOut();
//                 Get.offNamed(AppRoute.logIn);
//               },
//               leading: const Icon(Icons.logout, color: Colors.red),
//               title: const Text("Log Out", style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Home Page"),
//         backgroundColor: Colors.teal,
//         elevation: 0,
//       ),
//       body: StreamBuilder(
//         stream: FireStoreService.fireStoreService.fetchUsers(),
//         builder: (context, snapShot) {
//           if (snapShot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapShot.hasError) {
//             return Center(child: Text("Error: ${snapShot.error}"));
//           } else if (snapShot.hasData) {
//             QuerySnapshot<Map<String, dynamic>>? data = snapShot.data;
//
//             List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
//                 data?.docs ?? [];
//
//             List<UserModel> allUsers = allDocs
//                 .map(
//                   (e) => UserModel.fromMap(data: e.data() ?? {}),
//                 )
//                 .toList();
//
//             return ListView.separated(
//               itemCount: allUsers.length,
//               itemBuilder: (context, index) {
//                 var user = allUsers[index];
//
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: ListTile(
//                     onTap: () {
//                       Get.toNamed(AppRoute.chatroompage, arguments: user);
//                     },
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(user.image),
//                       radius: 30,
//                     ),
//                     title: Text(user.name, style: TextStyle(fontSize: 18)),
//                     subtitle: Text(user.email),
//                     trailing: Icon(Icons.arrow_forward_ios),
//                   ),
//                 );
//               },
//               separatorBuilder: (context, index) => Divider(),
//             );
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }
import 'dart:developer';
import 'package:chat_app/Route/app_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../model/user_model.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log("App Lifecycle State: $state");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light gray background
      drawer: Drawer(
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FireStoreService.fireStoreService.fetchSingleUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  var user =
                      UserModel.fromMap(data: snapshot.data?.data() ?? {});

                  return UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff6a11cb), Color(0xff2575fc)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    accountName: Text(
                      user.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    accountEmail: Text(
                      user.email,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(user.image),
                    ),
                  );
                }
                return const Center(child: Text("No user data found"));
              },
            ),
            const Divider(),
            ListTile(
              onTap: () {
                controller.signOut();
                Get.offNamed(AppRoute.logIn);
              },
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Log Out", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff6a11cb), Color(0xff2575fc)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
      ),
      body: StreamBuilder(
        stream: FireStoreService.fireStoreService.fetchUsers(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapShot.hasError) {
            return Center(child: Text("Error: ${snapShot.error}"));
          } else if (snapShot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? data = snapShot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
                data?.docs ?? [];

            List<UserModel> allUsers = allDocs
                .map((e) => UserModel.fromMap(data: e.data() ?? {}))
                .toList();

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: allUsers.length,
              itemBuilder: (context, index) {
                var user = allUsers[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.toNamed(AppRoute.chatroompage, arguments: user);
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.image),
                      radius: 30,
                    ),
                    title: Text(
                      user.name,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    ),
                    subtitle: Text(user.email,
                        style: const TextStyle(color: Colors.black54)),
                    trailing: const Icon(Icons.chat_bubble_outline,
                        color: Colors.deepPurple),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
