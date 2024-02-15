import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

 class MyHomePage extends ConsumerWidget {
    MyHomePage({super.key});





  final firstProvider = Provider((ref) =>"First Provider");
   @override
   Widget build(BuildContext context , WidgetRef ref) {

     final dataProvider =ref.watch(firstProvider);

     return Scaffold(

       appBar: AppBar(
         centerTitle: true,
         backgroundColor: Colors.blue,

         title: const Text("Riverpod"),
       ),
       body: Container(
         padding: EdgeInsets.only(top: 150,left: 150),
         child: Text(dataProvider,style: TextStyle(fontSize: 25)),
       ),
     );
   }
   }

