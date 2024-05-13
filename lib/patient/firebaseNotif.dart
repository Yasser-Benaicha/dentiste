import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService{
FirebaseMessaging messaging = FirebaseMessaging.instance;
Future<void> initNotifications()async{
await messaging.requestPermission();
final fCMToken = await messaging.getToken();
print("this is your token: $fCMToken");
}
}