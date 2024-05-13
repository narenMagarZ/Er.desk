import "package:er_desk/screens/home.dart";
import "package:er_desk/screens/signup.dart";
import "package:er_desk/utils/validation.dart";
import "package:er_desk/widgets/go-home.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";

class LoginFormProvider extends ChangeNotifier {
  String _email = "";
  String _password = "";

  String get email=>_email;
  String get password=>_password;

  set email(value){
    _email=value;
    notifyListeners();
  }
  set password(value){
    _password=value;
    notifyListeners();
  }
}

class LoginFormErrorProvider extends ChangeNotifier{
  String? _emailError;
  String? _passwordError;
  String? _error;
  String? get emailError=>_emailError;
  String? get passwordError=>_passwordError;
  String? get error=>_error;

  set emailError(value){
    _emailError=value;
    notifyListeners();
  }
  set passwordError(value){
    _passwordError=value;
    notifyListeners();
  }

  set error(value){
    _error=value;
    notifyListeners();
  }

}

class LoginFormSubmissionProvider extends ChangeNotifier{
  bool _isFormSubmissionOnProgress = false;
  bool get isFormSubmissionOnProgress=>_isFormSubmissionOnProgress;
  set isFormSubmissionOnProgress(bool value){
    _isFormSubmissionOnProgress = value;
    notifyListeners();
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>LoginFormProvider()),
        ChangeNotifierProvider(create: (context)=>LoginFormErrorProvider()),
        ChangeNotifierProvider(create: (context)=>LoginFormSubmissionProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Poppins"
        ),
        home: Scaffold(
          appBar: AppBar(
            leading: goHome(context)
          ),
          body: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 300
              ),
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const InputField(false,"Email"),
                  const SizedBox(height: 10),
                  const InputField(true,"Password"),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Placeholder()));
                      },
                      child: const Text("Forget password?")),
                  const SizedBox(height: 10),
                  const LoginButton(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",style: TextStyle(fontSize: 12)),
                      TextButton(
                          onPressed:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Signup()));
                          },
                          child: const Text("Signup",style: TextStyle(fontSize: 12)))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class InputField extends StatelessWidget {
  final bool hideText;
  final String hintText;
  const InputField(this.hideText,this.hintText,{super.key});

  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginFormProvider>(context,listen: false);
    return Consumer<LoginFormErrorProvider>(builder: (context,loginFormErrorProvider,_)=>
        TextField(
      onChanged: (newValue){
        if(hintText=="Email"){
          loginFormErrorProvider.emailError = Validation.validateEmail(newValue);
          loginFormProvider.email = newValue;
        }else {
          loginFormProvider.password = newValue;
        }
      },
      obscureText: hideText,
      decoration: InputDecoration(
        prefixIcon: hintText=="Email"?const Icon(Icons.email):const Icon(Icons.lock),
        hintText: hintText,
        errorText: hintText=="Email"?loginFormErrorProvider.emailError:loginFormErrorProvider.passwordError,
      ),
    ));
  }

}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginFormSubmissionProvider>(builder: (context,provider,_)=>
        SizedBox(
          width: 100,
          child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF7B5FEB))
              ),
              onPressed: ()async{
                final loginFormProvider = Provider.of<LoginFormProvider>(context,listen: false);
                final loginFormErrorProvider = Provider.of<LoginFormErrorProvider>(context,listen: false);
                final bool isLoginSucceed = await login(loginFormProvider,loginFormErrorProvider,provider);
                if(isLoginSucceed){
                  final preferences = await SharedPreferences.getInstance();
                  await preferences.setString("userInfo", "userData");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
                }
                else {
                  showErrorSnackBar(context,loginFormErrorProvider.error!);
                }
              },
              child: provider.isFormSubmissionOnProgress?
              const SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(strokeWidth: 2),
              ): const Text("Login",style: TextStyle(color: Colors.white))
          ),
        )
    );
  }
}

Future<bool> login(LoginFormProvider loginFormProvider,
    LoginFormErrorProvider loginFormErrorProvider,
    LoginFormSubmissionProvider loginFormSubmissionProvider,
    )async{
  loginFormErrorProvider.emailError = null;
  loginFormErrorProvider.passwordError = null;
  bool isLoginSucceed = false;
  final emailError = Validation.validateEmail(loginFormProvider.email);
  if(emailError!=null){
    loginFormErrorProvider.emailError = emailError;
    return isLoginSucceed;
  }
  if(loginFormProvider.password.isEmpty){
    loginFormErrorProvider.passwordError = "Password cannot be empty";
    return isLoginSucceed;
  }
  loginFormSubmissionProvider.isFormSubmissionOnProgress = true;
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginFormProvider.email,
        password: loginFormProvider.password);
    isLoginSucceed = true;
  } on FirebaseAuthException catch(e){
    loginFormErrorProvider.error = "Invalid email or password";
  }
  catch(err){
    loginFormErrorProvider.error = "Something wrong, try again later";
  }
  finally{
    loginFormSubmissionProvider.isFormSubmissionOnProgress = false;
  }
  return isLoginSucceed;
}
void showErrorSnackBar(BuildContext context,String errorMessage) {
  final snackBar = SnackBar(
    content: Text(errorMessage),
    backgroundColor: Colors.red,
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}