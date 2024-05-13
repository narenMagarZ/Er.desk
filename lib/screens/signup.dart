import "package:er_desk/screens/home.dart";
import "package:er_desk/screens/login.dart";
import "package:er_desk/utils/form-submission-provider.dart";
import "package:er_desk/utils/validation.dart";
import "package:er_desk/widgets/go-home.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";



class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>SignupFormProvider()),
        ChangeNotifierProvider(create: (context)=>SignupFormErrorProvider()),
        ChangeNotifierProvider(create: (context)=>FormSubmissionProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: "Poppins"
        ),
        home: Scaffold(
          appBar: AppBar(
            leading: goHome(context),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(
                    maxWidth: 300
                ),
                padding: const EdgeInsets.all(4),
                child: Consumer<SignupFormProvider>(builder: (context,provider,_)=>
                    Consumer<SignupFormErrorProvider>(builder: (context,errorProvider,_)=>
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("SIGN UP",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            InputField("companyName",Icons.home_work_outlined,false,"Company name",errorProvider.companyNameError),
                            InputField("panNumber",Icons.credit_card,false,"Pan no.",errorProvider.panNumberError),
                            InputField("registrationDate",Icons.app_registration,false,"Registration date",errorProvider.registrationDateError),
                            InputField("address",Icons.home,false,"Address",errorProvider.addressError),
                            InputField("email",Icons.email,false,"Email",errorProvider.emailError),
                            InputField("contactNumber",Icons.phone,false,"Contact no.",errorProvider.contactNumberError),
                            InputField("password",Icons.lock,true,"Password",errorProvider.passwordError),
                            InputField("reTypedPassword",Icons.lock,true,"Retype Password",errorProvider.reTypedPassword),
                            const SizedBox(height: 20),
                            signupButton(context),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account?",style: TextStyle(fontSize: 12)),
                                TextButton(
                                    onPressed:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
                                    },
                                    child: const Text("Login",style: TextStyle(fontSize: 12)))
                              ],
                            )
                          ],
                        ),
                    )
              
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class SignupFormErrorProvider extends ChangeNotifier {
  dynamic _companyNameError;
  dynamic _panNumberError;
  dynamic _registrationDateError;
  dynamic _addressError;
  dynamic _emailError;
  dynamic _contactNumberError;
  dynamic _passwordError;
  dynamic _reTypedPasswordError;

  dynamic get companyNameError=>_companyNameError;
  dynamic get panNumberError=>_panNumberError;
  dynamic get registrationDateError=>_registrationDateError;
  dynamic get addressError=>_addressError;
  dynamic get emailError=>_emailError;
  dynamic get contactNumberError=>_contactNumberError;
  dynamic get passwordError=>_passwordError;
  dynamic get reTypedPassword=>_reTypedPasswordError;

  set companyNameError(value){
    _companyNameError=value;
    notifyListeners();
  }
  set addressError(value){
    _addressError=value;
    notifyListeners();
  }  set panNumberError(value){
    _panNumberError=value;
    notifyListeners();
  }  set registrationDateError(value){
    _registrationDateError=value;
    notifyListeners();
  }  set contactNumberError(value){
    _contactNumberError=value;
    notifyListeners();
  }  set emailError(value){
    _emailError=value;
    notifyListeners();
  }  set passwordError(value){
    _passwordError=value;
    notifyListeners();
  }  set reTypedPasswordError(value){
    _reTypedPasswordError=value;
    notifyListeners();
  }
  bool get hasErrors {
    return _companyNameError != null ||
        _panNumberError != null ||
        _registrationDateError != null ||
        _addressError != null ||
        _emailError != null ||
        _passwordError != null ||
        _reTypedPasswordError != null ||
        _contactNumberError != null;
  }

}

Future<bool> signup(String email,String password,BuildContext context)async{
  final errorProvider = Provider.of<SignupFormErrorProvider>(context,listen: false);
  final signupFormProvider = Provider.of<SignupFormProvider>(context,listen: false);
  final formSubmissionProvider = Provider.of<FormSubmissionProvider>(context,listen: false);
  bool isSignupSucceed = false;
  validateField(errorProvider, "companyName", signupFormProvider.companyName, null);
  validateField(errorProvider, "address", signupFormProvider.address, null);
  validateField(errorProvider, "email", signupFormProvider.email, null);
  validateField(errorProvider, "contactNumber", signupFormProvider.contactNumber, null);
  validateField(errorProvider, "panNumber", signupFormProvider.panNumber, null);
  validateField(errorProvider, "password", signupFormProvider.password, null);
  validateField(errorProvider, "registrationDate", signupFormProvider.registrationDate, null);
  validateField(errorProvider, "reTypedPassword", signupFormProvider.reTypedPassword, signupFormProvider.password);
  if(errorProvider.hasErrors){
    return isSignupSucceed;
  }
  formSubmissionProvider.isFormSubmissionOnProgress = true;
  resetError(errorProvider);
  try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
    isSignupSucceed = true;
  } on FirebaseException catch(e){
    if(e.code == "email-already-in-use"){
      errorProvider.emailError = "Email already in use";
    }
    else if(e.code=="weak-password"){
      errorProvider.passwordError = "Weak password";
    }
  }
  catch(err){
    // print(err);
  }
  finally{
    formSubmissionProvider.isFormSubmissionOnProgress = false;
  }
  return isSignupSucceed;
}

class SignupFormProvider extends ChangeNotifier{
  String _companyName = "";
  String _panNumber = "";
  String _registrationDate = "";
  String _address = "";
  String _email = "";
  String _contactNumber = "";
  String _password = "";
  String _reTypedPassword = "";

  String get companyName=>_companyName;
  String get panNumber=>_panNumber;
  String get registrationDate=>_registrationDate;
  String get address=>_address;
  String get email=>_email;
  String get contactNumber=>_contactNumber;
  String get password=>_password;
  String get reTypedPassword=>_reTypedPassword;

  set companyName(value){
    _companyName=value;
    notifyListeners();
  }
  set panNumber(value){
    _panNumber=value;
    notifyListeners();
  }
  set registrationDate(value){
    _registrationDate=value;
    notifyListeners();
  }
  set address(value){
    _address=value;
    notifyListeners();
  }
  set email(value){
    _email=value;
    notifyListeners();
  }
  set contactNumber(value){
    _contactNumber=value;
    notifyListeners();
  }
  set password(value){
    _password=value;
    notifyListeners();
  }
  set reTypedPassword(value){
    _reTypedPassword=value;
    notifyListeners();
  }

  String? validateCompanyName(String value) {
    _companyName = value;
    return Validation.validateCompanyName(value);
  }

  String? validatePanNumber(String value) {
    _panNumber = value;
    return Validation.validatePanNumber(value);
  }

  String? validateRegistrationDate(String value) {
    _registrationDate = value;
    return Validation.validateRegistrationDate(value);
  }

  String? validateAddress(String value) {
    _address = value;
    return Validation.validateAddress(value);
  }

  String? validateEmail(String value) {
    _email = value;
    return Validation.validateEmail(value);
  }

  String? validatePassword(String value) {
    _password = value;
    return Validation.validatePassword(value);
  }

  String? validateRetypedPassword(String password, String retypedPassword) {
    _reTypedPassword = retypedPassword;
    return Validation.validateRetypedPassword(password, retypedPassword);
  }

  String? validateContactNumber(String value) {
    _contactNumber = value;
    return Validation.validateContactNumber(value);
  }
  String? validateSignupForm() {
    if (_companyName == null || _companyName!.isEmpty ||
        _panNumber == null || _panNumber!.isEmpty ||
        _registrationDate == null || _registrationDate!.isEmpty ||
        _address == null || _address!.isEmpty ||
        _email == null || _email!.isEmpty ||
        _password == null || _password!.isEmpty ||
        _reTypedPassword == null || _reTypedPassword!.isEmpty ||
        _contactNumber == null || _contactNumber!.isEmpty) {
      return 'Please fill in all required fields';
    }
  }
}
class InputField extends StatelessWidget {
  final String fieldName ;
  final IconData icon;
  final bool hideText;
  final String hintText;
  final dynamic errorText;
  const InputField(this.fieldName,this.icon,this.hideText,this.hintText,this.errorText,{super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupFormProvider>(context,listen: false);
    final signupFormErrorProvider = Provider.of<SignupFormErrorProvider>(context,listen: false);
    return TextField(
      onChanged: (newValue){
        updateField(provider,signupFormErrorProvider, fieldName, newValue);
        if(fieldName=="reTypedPassword"){
          validateField(signupFormErrorProvider, fieldName,newValue,provider.password);
        }else {
          validateField(signupFormErrorProvider, fieldName,newValue,null);
        }
      },
      obscureText: hideText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        errorText: errorText,
      ),
    );
  }

}

void updateField(SignupFormProvider provider,SignupFormErrorProvider errorProvider, String field,String value){
  switch(field){
    case "companyName":
      provider.companyName = value;
      break;
    case "panNumber":
      provider.panNumber = value;
      errorProvider.panNumberError = Validation.validatePanNumber(value);
      break;
    case "registrationDate":
      provider.registrationDate = value;
      break;
    case "address":
      provider.address = value;
      break;
    case "email":
      provider.email = value;
      break;
    case "contactNumber":
      provider.contactNumber = value;
      break;
    case "password":
      provider.password = value;
      break;
    case "reTypedPassword":
      provider.reTypedPassword = value;
      break;
    default:
      break;
  }
}

Consumer<FormSubmissionProvider> signupButton(BuildContext context){
  final provider = Provider.of<SignupFormProvider>(context,listen: false);
  final errorProvider = Provider.of<SignupFormErrorProvider>(context,listen: false);
  return Consumer<FormSubmissionProvider>(builder: (context,formSubmissionProvider,_)=>
      SizedBox(
        width: 150,
        child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF7B5FEB))
            ),
            onPressed: (){
              // updateField(provider, errorProvider, field, value)
              signup(provider.email,provider.password,context);
            },
            child: formSubmissionProvider.isFormSubmissionOnProgress ? const SizedBox(
              height: 10,
              width: 10,
              child: CircularProgressIndicator(strokeWidth: 2),
            ):
            const Text("Confirm",style: TextStyle(color: Colors.white))),
      )
  );
}

void resetError(SignupFormErrorProvider errorProvider){
  errorProvider.companyNameError = null;
  errorProvider.panNumberError = null;
  errorProvider.registrationDateError = null;
  errorProvider.addressError = null;
  errorProvider.emailError = null;
  errorProvider.contactNumberError = null;
  errorProvider.passwordError = null;
  errorProvider.reTypedPasswordError = null;
}


bool validateField(SignupFormErrorProvider signupFormErrorProvider,String field,String value,String? value0){
  switch(field){
    case "companyName":
      signupFormErrorProvider.companyNameError = Validation.validateCompanyName(value);
      break;
    case "panNumber":
      signupFormErrorProvider.panNumberError = Validation.validatePanNumber(value);
      break;
    case "address":
      signupFormErrorProvider.addressError = Validation.validateAddress(value);
      break;
    case "email":
      signupFormErrorProvider.emailError = Validation.validateEmail(value);
      break;
    case "contactNumber":
      signupFormErrorProvider.contactNumberError = Validation.validateContactNumber(value);
      break;
    case "password":
      signupFormErrorProvider.passwordError = Validation.validatePassword(value);
      break;
    case "registrationDate":
      signupFormErrorProvider.registrationDateError = Validation.validateRegistrationDate(value);
      break;
    case "reTypedPassword":
      signupFormErrorProvider.reTypedPasswordError = Validation.validateRetypedPassword(value0,value);
      break;
  }
  return false;
}