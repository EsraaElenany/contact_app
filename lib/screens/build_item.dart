import 'package:contact_app/constant/constant.dart';
import 'package:contact_app/cubit/contact_cubit.dart';
import 'package:contact_app/database.dart';
import 'package:contact_app/widgets/default_Text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'edite_contact.dart';

class BuilderItem extends StatelessWidget {
  Map item;
  BuilderItem({super.key ,required this.item});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (dissmiss){
          ContactCubit.get(context).deleteContact(id: item['id']);
          Fluttertoast.showToast(
              msg: "Delete this contact ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        },
        child: InkWell(
          onTap: (){
            Fluttertoast.showToast(
                msg: "When swap Left Or Right Delete Contact ,"
                    " When double click  edite contact ,"
                    " and on long press call the contact ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          },
         onDoubleTap: (){
            showDialog(context: context, builder: (context)=> EditeContact(itemId: item,));
         },
         onLongPress: ()async{
         final Uri phoneLaunchUri = Uri(
           scheme: 'tel',
           path: "${item['phone']}",
         );
         final Uri smsLaunchUri = Uri(
           scheme: 'sms',
           path: "${item['phone']}",
         );

        await launchUrl(phoneLaunchUri);
             },
        child:
            Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end:Alignment.bottomLeft,
                    colors:  [
                  Colors.pink,
                  Colors.white10 ,
                  Colors.deepPurple
                ],),
              ),
              child:  ListTile(
                title: DefaultText(text: item['name'],
                fontSize: 15.sp,
                ) ,
                subtitle:  DefaultText(text:item['phone'],
                  fontSize: 15.sp,
                ) ,
                trailing:  Visibility(
                  visible: item['status']== "favorite",
                    replacement:IconButton(onPressed: (){

                        ContactCubit.get(context).updateStatus(status: "favorite", id: item['id']);

                    }, icon: const Icon(Icons.favorite , color: Colors.grey,)) ,
                    child: IconButton(onPressed: (){

                        ContactCubit.get(context).updateStatus(status: "NOFavorite", id: item['id']);

                    }, icon: const Icon(Icons.favorite, color: Colors.red,))),
              ),
            ),

        ),
      ),
    );
  }
}
