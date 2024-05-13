import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.only(left: 0,right: 12))
      ),
        onPressed: (){
          logout();
        },
        child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Logout",style: TextStyle(color: Colors.black)),
                SizedBox(width: 10,),
                Icon(Icons.logout,size: 16,)
              ],
            )
    );
  }
}

void logout()async{
  try{
    await FirebaseAuth.instance.signOut();
  }
  catch(err){
    print(err);
  }
}