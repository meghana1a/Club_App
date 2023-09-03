import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsDisp extends StatelessWidget {
  EventsDisp({Key? key}) : super(key: key);

  final CollectionReference _events=FirebaseFirestore.instance.collection('Events');

  @override
  Widget build(BuildContext context) {
    // final Size size=MediaQuery.of(context).size;
    print(_events);

    return StreamBuilder(

        stream: _events.snapshots(),

        builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            final documents = streamSnapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: documents.length,
                itemBuilder: (ctx,index)=>
                    Card(
                        margin: EdgeInsets.only(bottom:15,left: 6,right: 6),
                elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                color: Colors.tealAccent,
                  // margin: EdgeInsets.only(top: 8,bottom: 8,left:1,right:1),
                  child:Column(
                    children:<Widget>[
                      ListTile(
                        // margin: EdgeInsets.only(bottom:10,left: 6,right: 6),
                      title: Text(documents[index]['title'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black87),),
                      leading: Icon(Icons.wysiwyg_rounded),
                      subtitle: Text("date: ${documents[index]['Date']}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500)),
                        onTap: (){
                        print("iddddddddddddddddddddddddddddddd");
                         print(documents[index].id);
                          Navigator.of(context).pushNamed(EventDetails.routeName,arguments: documents[index]);
                        },
                    ),
              ]
                  )
                  )
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }
}
