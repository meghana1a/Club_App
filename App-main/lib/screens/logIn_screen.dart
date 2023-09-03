import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sem_5_project/screens/auth_screen1.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogInScreen extends StatefulWidget {
  // LogInScreen(this.submitFn,{Key? key}) : super(key: key);

  // final Future<UserCredential> Function(String email) submitFn;
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey= GlobalKey<FormState>();

  String _userEmail='';

  void _trySubmit()
  {
    final isValid=_formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _formKey.currentState!.save();
      // widget.submitFn(_userEmail);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 520,
              child: Stack(
                children: [
                  Positioned(
                      top: -55,
                      height: 520,
                      width: width+50,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.fill,
                            )
                        ),
                  )
                  ),
                  Positioned(
                      height: 520,
                      width: width+20,
                      child: Container(

                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/background-2.png'),
                              fit: BoxFit.fill,
                            )
                        ),
                      )
                  )
                ],
              )

            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                         Text("HELLO AGAIN!!",style: TextStyle(
                             color: Color.fromRGBO(49,39,79,1),
                         fontWeight: FontWeight.bold,
                           fontSize:26
                         ),
                         ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198,0.4),
                            blurRadius: 30,
                            offset: Offset(0,10),
                          )
                        ]
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Container(
                            //   padding: EdgeInsets.all(8),
                            //   decoration: BoxDecoration(
                            //     border: Border(bottom: BorderSide(
                            //       color: Colors.grey[200]!,
                            //     ))
                            //   ),
                              // child: Form(
                              //   key: _formKey,
                              //   child: TextFormField(
                              //     validator: (value){
                              //       if(value!.isEmpty || !value.contains('@'))
                              //         return 'Please enter valid email adddress';
                              //       return null;
                              //     },
                              //     keyboardType: TextInputType.emailAddress,
                              //     decoration: InputDecoration(
                              //       border:InputBorder.none,
                              //       hintText: "Email",
                              //       hintStyle: TextStyle(color: Colors.black54)
                              //     ),
                              //     onSaved: (value){
                              //          _userEmail=value!;
                              //     },
                              //   ),
                              // ),
                            //),
                            SizedBox(
                              height: 6,
                            ),
                            Center(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO((49), 39, 79, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0)
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 36, vertical: 3),
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                icon: Icon(FontAwesomeIcons.google,size: 30,color: Colors.red,),
                                label: Text("Login",style: TextStyle(color:Colors.white,fontSize: 23),),
                                onPressed: AuthService(context).signInWithGoogle,


                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
      )



          ],
        ),
        ),
      ),
    );
  }
}
