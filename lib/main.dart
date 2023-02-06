import 'package:flutter/material.dart';
import 'package:flutter_notifications_app/screens/home_screen.dart';
import 'package:flutter_notifications_app/screens/message_screen.dart';
import 'package:flutter_notifications_app/services/push_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationsService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //context.
    PushNotificationsService.messageStream.listen((message) {
      print("MyApp: $message");
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'message': (_) => const MessageScreen()
      },
    );
  }
}
