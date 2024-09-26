import 'package:contact_app/database.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'build_item.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index)=> SizedBox(height: 2.h,),
        itemCount: favorite.length,
        itemBuilder: (context , index) {
          return BuilderItem(item: favorite[index]);
        });
  }
  }

