import 'package:contact_app/cubit/contact_cubit.dart';
import 'package:contact_app/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'build_item.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactCubit, ContactState>(
      listener: (context, state) {
       if(state is LoadingGetDataBaseStates){
         CircularProgressIndicator();
       }
       if(state is ErrorGetDataBaseStates){
         Center(child: Text("error Happend"));
       }
      },
      builder: (context, state) {
        return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 2.h,),
            itemCount: ContactCubit.get(context).favorite.length,
            itemBuilder: (context, index) {
              return BuilderItem(item: ContactCubit.get(context).favorite[index]);
            });
      },
    );
  }
}

