import 'package:contact_app/database.dart';
import 'package:contact_app/widgets/default_Text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuilderItem extends StatefulWidget {
  Map item;
  BuilderItem({super.key ,required this.item});

  @override
  State<BuilderItem> createState() => _BuilderItemState();
}

class _BuilderItemState extends State<BuilderItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(

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
          title: DefaultText(text: widget.item['name'],
          fontSize: 15.sp,
          ) ,
          subtitle:  DefaultText(text: widget.item['phone'],
            fontSize: 15.sp,
          ) ,
          trailing:  Visibility(
            visible: widget.item['status']== "favorite",
              replacement:IconButton(onPressed: (){
                setState(() {
                  updateStatus(status: "favorite", id: widget.item['id']);

                });
              }, icon: const Icon(Icons.favorite , color: Colors.red,)) ,
              child: IconButton(onPressed: (){
                setState(() {
                  updateStatus(status: "NOFavorite", id: widget.item['id']);

                });
              }, icon: const Icon(Icons.favorite))),
        ),
      ),
    );
  }
}
