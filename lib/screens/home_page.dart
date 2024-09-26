import 'package:contact_app/main.dart';
import 'package:contact_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constant/constant.dart';
import '../database.dart';
import '../widgets/default_form_filed.dart';
import '../widgets/default_phone_filed.dart';
import '../widgets/default_text.dart';
import 'contact_page.dart';
import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> screen = const [
    ContactPage(), // 0
    FavoritePage(), // 1
  ];
  List<String> titles = [
    "Contact",
    "Favorite",
  ];

  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var isBottom= false;
IconData  floatingIcon= Icons.account_circle_sharp;
  void changeBottom({required bool isShow,required IconData icon}){
    setState(() {
      isBottom = isShow;
      floatingIcon = icon;
    });

  }
@override
  void initState() {
  createDataBase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: DefaultText(
          text: titles[currentIndex],
          color: Colors.teal,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: screen[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          if(isBottom) {
            if (formKey.currentState!.validate()) {
              insertDataBase(name: nameController.text
                  ,phone: "$myCountry${phoneController.text}",
                  );
              Navigator.pop(context);
              nameController.clear();
              phoneController.clear();
            }}
            else {
             changeBottom(isShow: true, icon: Icons.add);
              scaffoldKey.currentState!.showBottomSheet((context) {
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
                );
              }).closed.then((value){
                changeBottom(isShow: false, icon: floatingIcon);

              });
            }

          },
        child: Icon(floatingIcon),
       shape: const CircleBorder(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: titles[0]),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: titles[1]),
          ]),
    );
  }
}
