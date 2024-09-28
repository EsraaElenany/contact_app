import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constant/constant.dart';
import '../widgets/default_form_filed.dart';
import '../widgets/default_phone_filed.dart';

class CardContact extends StatelessWidget {
  const CardContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.h),
      height: 30.h,
      width: 90.w,
      color: Colors.grey[200],
      child: Form(
        key: formKey,
        child: Column(
          children: [
            DefaultFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter name";
                }
                return null;
              },
              controller: nameController,
              keyboardType: TextInputType.text,
              labelText: "Name",
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 2.h,),
            DefaultPhoneField(
              keyBoardType: TextInputType.phone,
              controller: phoneController,
              validator: (value) {
                if (value!.length != 10) {
                  return "please enter 11 number ";
                }
                return null;
              },
              labelText: "Phone",
              onChange: (countryCode) {
                myCountry = countryCode;
              },


            )
          ],
        ),
      ),
    );;
  }
}
