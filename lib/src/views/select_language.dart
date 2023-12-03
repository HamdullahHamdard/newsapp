import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/src/cubit/cubit.dart';
import 'package:newsapp/src/cubit/state.dart';
class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (BuildContext context, state){},
        builder: (BuildContext context, Object? state){
          return Scaffold(
            appBar: AppBar(),
          );
        }
    );


  }
}
