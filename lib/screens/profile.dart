import "package:cloud_firestore/cloud_firestore.dart";
import "package:er_desk/widgets/log-out-button.dart";
import "package:er_desk/widgets/screen-appbar.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user ;
  @override
  void initState(){
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins"
      ),
      home: Scaffold(
        appBar: appBar(context, "Profile"),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ProfileInfo("Email","${user!.email}"),
              ProfileInfo("Company name", "Tesla"),
              ProfileInfo("PAN number", "4560-6789-0987"),
              ProfileInfo("Address", "Surkhet"),
              ProfileInfo("Contact number", "+9779822406053"),
              ProfileInfo("Registration date", "2076-12-23"),
              LogoutButton()
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String infoName;
  final String infoValue;
  const ProfileInfo(this.infoName,this.infoValue,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(infoName,style: const TextStyle(fontSize: 14)),
          Row(
            children: [
              Text(infoValue,style: const TextStyle(fontSize: 13)),
              IconButton(
                onPressed: ()=>_dialogBuilder(context,infoName,infoValue),
                icon: const Icon(Icons.edit),
                style: const ButtonStyle(iconSize: MaterialStatePropertyAll(14)),)
            ],
          )
        ],
      ),
    );
  }
}


void openEditForm(){

}


Future<void> _dialogBuilder(BuildContext context,String field,String value) {
  final controller = TextEditingController(text:value);
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Align(alignment: Alignment.center,child: Text("Edit",style: TextStyle(fontSize: 18))),
        content: Container(
          constraints: const BoxConstraints(
            maxHeight: 150,
            maxWidth: 200
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14
                ),
                controller: controller,
                decoration: InputDecoration(
                  hintText: field,
                  hintStyle: const TextStyle(color: Colors.grey),
                  label: Text(field,style: const TextStyle(fontSize: 20))
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.grey)
                    ),
                      onPressed: (){
                        discardEdit(context);
                      },
                      child: Text("Discard",style: TextStyle(fontSize: 12,color: Colors.white))),
                  SizedBox(width: 10),
                  const TextButton(
                      onPressed: update,
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))
                          )
                        ),
                        padding: MaterialStatePropertyAll(EdgeInsets.zero),
                          backgroundColor: MaterialStatePropertyAll(Color(0xFF7B5FEB))
                      ),
                      child: Text("Update",style: TextStyle(fontSize: 12,color: Colors.white)))
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

void update()async{
  try{
    final ref = FirebaseFirestore.instance.collection("users");
    final docRef = await ref.doc("narenmagarz98@gmail.com").get();
    print(docRef);
  }
  catch(err){
    print(err);
  }
}

void discardEdit(BuildContext context){
  Navigator.pop(context);
}