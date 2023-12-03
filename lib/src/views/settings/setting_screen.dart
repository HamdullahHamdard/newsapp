import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mime/mime.dart';
import 'package:newsapp/src/cubit/cubit.dart';
import 'package:newsapp/src/cubit/state.dart';
import 'package:newsapp/src/views/about.dart';
import 'package:newsapp/src/views/contact_us_screen.dart';
import 'package:newsapp/src/views/settings/select_font.dart';

import '../../cubit/font_cubit/font_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final List<String> languages = ['English'.tr(), 'Pashto'.tr(), 'Dari'.tr()];
  late double _deviceHeight;
  late double _deviceWidth;
  late String selectedIndex = 'Select your language';

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.sizeOf(context).height;
    _deviceWidth = MediaQuery.sizeOf(context).width;
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        String vid =
            'https://www.woolha.com/media/2021/03/flutter-display-image-from-file-1200x627.jpg';
        String? mimString = lookupMimeType(vid);
        var filetype = mimString?.split('/');
        print('File Type is $filetype');
        return Scaffold(
          appBar: AppBar(
            title: Text('Settings'.tr()),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _buildSettingCard(
                  title: 'Contact Us'.tr(),
                  subtitle: 'Adjust the app font size'.tr(),
                  onTap: () {
                    // Navigate to font size settings page
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext contect)=> ContactUsScreen()));
                  },
                ),
                _buildSettingCard(
                  title: 'Font Size'.tr(),
                  subtitle: 'Adjust the app font size'.tr(),
                  onTap: () {
                    // Navigate to font size settings page
                  },
                ),
                _buildSettingCard(
                  title: 'Select Font'.tr(),
                  subtitle: 'Choose the font for the app'.tr(),
                  onTap: () {
                    setState(() {
                      String? mimString = lookupMimeType(vid);
                      var filetype = mimString?.split('/');
                      print('File Type is $filetype');
                    });
                    // Navigate to font selection settings page
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                ),
                Container(
                  padding: EdgeInsets.only(left: 9, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Dark Theme".tr(),
                        style: GoogleFonts.alegreya(
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<NewsCubit>(context)
                                .changeThemeMode();
                          },
                          icon: Icon(BlocProvider.of<NewsCubit>(context).isDark
                              ? Icons.dark_mode
                              : Icons.light_mode)),
                    ],
                  ),
                ),
                SizedBox(height: _deviceHeight/40,),
                Container(
                  padding: EdgeInsets.only(left: 9, right: 9, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Text(
                      //   '',
                      //   style: GoogleFonts.alegreya(
                      //     fontSize: 18,
                      //   ),
                      // ),
                      PopupMenuButton(
                        constraints: BoxConstraints.expand(
                            width: _deviceWidth / 1.2,
                            height: _deviceHeight / 2.8,
                        ),
                        itemBuilder: (context) => [

                          PopupMenuItem(
                            child: Text('English'.tr()),
                            value: 'english',
                          ),
                          PopupMenuItem(
                            child: Text('Pashto'.tr()),
                            value: 'pashto',
                          ),
                          PopupMenuItem(
                            child: Text('Dari'.tr()),
                            value: 'dari',
                          ),
                          PopupMenuItem(
                            child: Text('Arabic'.tr()),
                            value: 'arabic',
                          ),
                          PopupMenuItem(
                            child: Text('Urdu'.tr()),
                            value: 'urdu',
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 'english') {
                            setState(() {
                              cubit.changeLanguageToEnglish(context);
                            });
                          } else if (value == 'pashto') {
                            setState(() {
                              cubit.changeLanguageToArabic(context);
                            });
                          } else if (value == 'dari') {
                            setState(() {
                              cubit.changeLanguageToArabic(context);
                            });
                          } else if (value == 'arabic') {
                            setState(() {
                              cubit.changeLanguageToArabic(context);
                            });
                          } else if (value == 'urdu') {
                            setState(() {
                              cubit.changeLanguageToArabic(context);
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Select your Language'.tr(),
                              style: GoogleFonts.alegreya(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox( width: EasyLocalization.of(context)!.locale == Locale('en', 'US') ?_deviceWidth/3.2: _deviceWidth/2.6 ,),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                    padding: EdgeInsets.only(top: 18),
                  child: _buildSettingCard(title: 'About', subtitle: "subtitle", onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext contex)=> AboutPage()));
                  }),
                ),

                // CustomDropdown<String>(
                //   hintText: "Select language",
                //   hideSelectedFieldWhenExpanded: true,
                //   items: const [
                //     'English',
                //     'Pashto',
                //     'Dari'
                //   ],
                //   initialItem: value,
                //   closedFillColor: cubit.isDark ? Colors.black12.withOpacity(0.001): Colors.white,
                //   onChanged: (value) {
                //     if (value == 'English'.tr()) {
                //       setState(() {
                //         selectedIndex = value;
                //         cubit.changeLanguageToEnglish(context);
                //       });
                //     } else if (value == 'Pashto'.tr()) {
                //       setState(() {
                //         cubit.changeLanguageToArabic(context);
                //         selectedIndex = value ;
                //       });
                //     }else if (value == 'Dari'.tr()) {
                //       setState(() {
                //         cubit.changeLanguageToArabic(context);
                //         selectedIndex = value ;
                //       });
                //     }
                //   },
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingCard(
      {required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.alegreya(
              fontSize: 18,
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
