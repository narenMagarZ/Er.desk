import "package:firebase_storage/firebase_storage.dart";

Future<String> getResourceDownloadUrl(location) async{
  try{
    // pointer to a file in a cloud
    final storageRef = FirebaseStorage.instance
        .ref()
        .child(location);
    final url = await storageRef.getDownloadURL();
    return url;
  }
  catch(e){
    return "";
  }
}

