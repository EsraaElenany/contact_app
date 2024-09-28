import 'package:contact_app/constant/constant.dart';
import 'package:contact_app/cubit/contact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets/default_Text.dart';
import 'card_contact.dart';

class EditeContact extends StatelessWidget {
  Map itemId;
   EditeContact({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[200],
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const CardContact(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: (){
                  ContactCubit.get(context).updateDataBase(
                    name: nameController.text,
                    phone: "$myCountry${phoneController.text}",
                    id: itemId['id']
                  );
                  nameController.clear();
                  phoneController.clear();
                  Navigator.pop(context);
                }, child: const DefaultText(text: "Save",)),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: DefaultText(text: "cancel",)),

              ],
            )
          ],
        )
      ),
    );
  }
}
