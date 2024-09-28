import 'package:contact_app/cubit/contact_cubit.dart';
import 'package:contact_app/main.dart';
import 'package:contact_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../constant/constant.dart';
import '../database.dart';
import '../widgets/default_form_filed.dart';
import '../widgets/default_phone_filed.dart';
import '../widgets/default_text.dart';
import 'card_contact.dart';
import 'contact_page.dart';
import 'favorite_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});


  List<Widget> screen = const [
    ContactPage(), // 0
    FavoritePage(), // 1
  ];
  List<String> titles = [
    "Contact",
    "Favorite",
  ];




  @override
  Widget build(BuildContext context) {
    ContactCubit contactCubit = ContactCubit.get(context);

    return BlocBuilder<ContactCubit, ContactState>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: DefaultText(
              text: titles[contactCubit.currentIndex],
              color: Colors.teal,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: true,
          ),
          body: screen[contactCubit.currentIndex],
          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (contactCubit.isBottom) {
                if (formKey.currentState!.validate()) {
                  contactCubit.insertDataBase(name: nameController.text
                    , phone: "$myCountry${phoneController.text}",
                  );
                  Navigator.pop(context);
                  nameController.clear();
                  phoneController.clear();
                }
              }
              else {
                contactCubit.changeBottom(isShow: true, icon: Icons.add);
                scaffoldKey.currentState!.showBottomSheet((context) {
                  return const CardContact();
                }).closed.then((value) {
                  contactCubit.changeBottom(
                      isShow: false, icon: contactCubit.floatingIcon);
                });
              }
            },
            child: Icon(contactCubit.floatingIcon),
            shape: const CircleBorder(),
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: contactCubit.currentIndex,
              onTap: (index) {
                contactCubit.changeBottomNavBar(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: titles[0]),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: titles[1]),
              ]),
        );
      },
    );
  }
}
