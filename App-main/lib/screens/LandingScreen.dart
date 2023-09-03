import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sem_5_project/custom/BorderBox.dart';
import 'package:sem_5_project/utils/constants.dart';
import 'package:sem_5_project/utils/widget_functions.dart';
import '../utils/custom_functions.dart';
import '../utils/sample_data.dart';
import 'events_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sem_5_project/screens/Events_Details.dart';
class LandingScreen extends StatefulWidget{
  static const routeName='/Landing-screen';
  var userNamee="";
  LandingScreen(String userNm)
  {
    userNamee=userNm;

  }

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final CollectionReference _events=FirebaseFirestore.instance.collection('Events');
  @override
  Widget build(BuildContext context){
    final Size size=MediaQuery.of(context).size;
    final ThemeData themeData=Theme.of(context);
    final double padding=25;
    final sidePadding=EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
        backgroundColor: Colors.white,
        body : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(padding),

              Padding(
                padding: sidePadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BorderBox(
                      width: 50,height: 50,
                      child: Icon(Icons.menu,color: COLOR_BLACK),
                    ),
                    TextButton(
                      child: Icon(Icons.logout_outlined,color: COLOR_BLACK),
                      onPressed: (){},)

                  ],
                ),
              ),
              addVerticalSpace(padding),
              Padding(
                padding:sidePadding,
                child: Text("SSN",style:TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 14),
                ),),
              addVerticalSpace(10),

              Padding(padding: sidePadding,
                child: Row(
                    children: [Text("Welcome ${widget.userNamee}  ",
                        style: themeData. textTheme.headline1),
                      Icon(FontAwesomeIcons.faceSmile,color: Colors.amber,size: 30,)]
                ),

              ),

              Padding(padding: sidePadding,
                child: Divider(
                  height: padding,color: COLOR_GREY,),),
              addVerticalSpace(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: ["Attendance","Past events","Announcements"]
                        .map((filter) => ChoiceOption(text: filter)).toList()
                ),
              ),
              // addVerticalSpace(20),
              SizedBox(
                height: 38,
              ),
              Padding(padding: sidePadding,
                child: Text("Upcoming Events", style: themeData.textTheme.headline2),
              ),
              Padding(
                padding: EdgeInsets.all(1),
                child: StreamBuilder(

                    stream: _events.snapshots(),

                    builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        final documents = streamSnapshot.data!.docs;
                        print("documenttttttt");
                        print(documents);
                        print("Helllooooooooo");
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
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
                                              Navigator.of(context).pushNamed(EventDetails.routeName,arguments: documents[index].id);
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
                ),
              ),



            ],
          ),
        )
    );
  }
}

class ChoiceOption extends StatelessWidget{
  final String? text;
  const ChoiceOption({Key? key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context){
    final ThemeData themeData=Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: COLOR_GREY.withAlpha(25),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 13),
      margin: EdgeInsets.only(left: 22),
      child: Text(text!,style: themeData.textTheme.headline5,),
    );
  }
}





















class ProductDataItem extends StatelessWidget {
  final dynamic itemData;
  const ProductDataItem({Key? key,this.itemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themedata=Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(itemData["image"],
                      height: 150,
                      fit:BoxFit.fill
                  )),
              Positioned(
                top: 15,
                right: 15,
                child: BorderBox(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.favorite_border,color: COLOR_BLACK,),
                ),
              ),
            ],

          ),
          addVerticalSpace(2),
          Row(
            children: [
              Text("${formatCurrency(itemData["amount"])}",style: themedata.textTheme.headline1,),
              Text(
                " ${itemData["address"]}",
                style: themedata.textTheme.bodyText2,
              )
            ],
          ),
          addVerticalSpace(2),
          Text("${itemData["bedrooms"]} bedrooms / ${itemData["bathrooms"]} bathrooms / ${itemData["area"]} sqft",
            style: themedata.textTheme.headline5,)


        ],
      ),
    );
  }
}
