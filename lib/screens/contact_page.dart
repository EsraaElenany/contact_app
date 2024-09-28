import 'package:contact_app/cubit/contact_cubit.dart';
import 'package:contact_app/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';


import 'build_item.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactCubit, ContactState>(
      builder: (context, state) {
        return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 2.h,),
            itemCount: ContactCubit.get(context).contacts.length,
            itemBuilder: (context, index) {
              return BuilderItem(item: ContactCubit.get(context).contacts[index]);
            });
      },
    );
  }

}
