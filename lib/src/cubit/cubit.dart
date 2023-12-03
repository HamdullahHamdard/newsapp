import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/src/cubit/state.dart';

class NewsCubit extends Cubit<NewsState>{
  NewsCubit(): super(InitialState());

  static NewsCubit get(context) => BlocProvider.of(context);



  void changeLanguageToEnglish(BuildContext context){
    if(EasyLocalization.of(context)!.locale == Locale('ar', 'EG' )){
      context.locale = Locale('en', 'US');
    }
    emit(ChangeLanguageToEnglishState());
  }

  void changeLanguageToArabic(BuildContext context){
    if(EasyLocalization.of(context)!.locale == Locale('en', 'US')){
      context.locale = Locale('ar', 'EG');
    }
    emit(ChangeLanguageToArabicState()
    );
  }

  bool isDark = false;
  void changeThemeMode(){
    isDark = !isDark;
    emit(ChangeAppModeState());
  }
}