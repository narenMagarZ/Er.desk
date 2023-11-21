import "package:firebase_storage/firebase_storage.dart";



Future<List<String>> fetchItemsInDirectory(String dir)async{
  List<String> items = [];
  final storageRef = FirebaseStorage.instance.ref();
  final storageDir = storageRef.child(dir);
  final ListResult result = await storageDir.listAll();
  for(final item in result.items){
    final fileName = item.name.replaceAll(".pdf","");
    items.add(fileName);
  }
  return items;
}