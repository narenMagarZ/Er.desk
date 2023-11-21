import 'package:er_desk/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import "package:firebase_storage/firebase_storage.dart";
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // fetchData();
    return MaterialApp(
      title: 'Er.Desk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins'
      ),
      home: const Home(),
    );
  }
}

Future<void> fetchData()async{
  try{
    // pointer to a file in a cloud
    final storageRef = FirebaseStorage.instance
        .ref()
        // .child('valuation')
        .child("land-property-valuation.pdf")
    ;
    final url = await storageRef.getDownloadURL();
    print(url);
    // final data = await storageRef.getData();
    // print(data);
  }
  catch(e){
    throw e;
  }
}

