import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class FormDetail extends StatefulWidget {

  static const routeName='/Form_Detail';
  @override
  State<FormDetail> createState() => _FormDetailState();

}

class _FormDetailState extends State<FormDetail> {
  final formKey = GlobalKey<FormState>();

  String RegNo = '';
  String Year = '';
  String Dept = '';

  @override
  Widget build(BuildContext context) {
    final _EventId = ModalRoute
        .of(context)
        ?.settings
        .arguments as String;
    return Scaffold(

      appBar: AppBar(
        title: Text('Enter the details'),
      ),
      body: Form(
        key: formKey,

        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(height: 50,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Register Number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Register Number cannot be empty!';
                } else {
                  return null;
                }
              },
              onSaved: (value) => setState(() => RegNo = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Department',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Year cannot be empty!';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.number,
              onSaved: (value) => setState(() => Year = value!),
            ),
            const SizedBox(height: 32),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Year',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Department cannot be empty';
                } else {
                  return null;
                }
              },
              onSaved: (value) => setState(() => Dept = value!),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),

            const SizedBox(height: 32),

            Builder(
              builder: (context) =>
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO((49), 39, 79, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 60, vertical: 10),
                            textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        // icon: Icon(Icons.app_registration,size: 30,color: Colors.red,),
                        child: Text("Submit",
                          style: TextStyle(color: Colors.white, fontSize: 23),),

                        onPressed: () {
                          final isValid = formKey.currentState!.validate();
                          FocusScope.of(context).unfocus();

                          if (isValid) {
                            formKey.currentState!.save();
                            DocumentReference _documentReference=FirebaseFirestore.instance.collection('Events').doc(_EventId);
                            CollectionReference _reference=_documentReference.collection('Registered_Users');
                            _reference.add({
                              'Email id': FirebaseAuth.instance.currentUser!.email,
                              'Name':FirebaseAuth.instance.currentUser!.displayName,'RegNo': RegNo,'Year': Year,'Department':Dept},
                               );
                            Navigator.of(context).pop();
                          }
                        }


                    ),
                  ),


            ),
          ],
        ),
      ),


    );
  }
}
