import 'package:contact_app/database.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


import 'build_item.dart';
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index)=> SizedBox(height: 2.h,),
      itemCount: contacts.length,
        itemBuilder: (context , index) {
      return BuilderItem(item: contacts[index]);
    });
  }

}
