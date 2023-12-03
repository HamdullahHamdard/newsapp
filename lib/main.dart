import 'package:after_layout/after_layout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/src/cubit/cubit.dart';
import 'package:newsapp/src/cubit/font_cubit/font_bloc.dart';
import 'package:newsapp/src/cubit/state.dart';
import 'package:newsapp/src/views/contact_us_screen.dart';
import 'package:newsapp/src/views/create_post/create_post.dart';
import 'package:newsapp/src/views/favorites/favorite_screen.dart';
import 'package:newsapp/src/views/home_screen.dart';
import 'package:newsapp/src/views/search_screen.dart';
import 'package:newsapp/src/views/settings/setting_screen.dart';
import 'package:newsapp/src/widgets/text_style.dart';
import 'package:newsapp/src/widgets/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ar', 'EG'),
      ],
      fallbackLocale: Locale('en', 'US'),
      path: 'assets/translations',
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // final FontBloc _fontBloc;
  // MyApp({required SharedPreferences prefs})
  //     : _fontBloc = FontBloc(prefs),
  //       super();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NewsCubit()),
          BlocProvider(create: (context) => FontBloc()),
        ],
        child: BlocBuilder<NewsCubit, NewsState>(
            builder: (BuildContext context, state) {
              var cubit = NewsCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: Splash(),
          );
        }));
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Home()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Setting',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late double _deviceHeight;
  late double _deviceWidth;


  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.sizeOf(context).height;
    _deviceWidth = MediaQuery.sizeOf(context).width;
    return BlocConsumer<NewsCubit, NewsState>(
  listener: (context, state) {},
  builder: (BuildContext context, Object? state) {
    var cubit = NewsCubit.get(context);
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white , Colors.lightBlueAccent.withOpacity(0.5), Colors.lightBlueAccent,  Colors.lightBlue, Colors.blue,],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png', // replace with your SVG asset
                    height: 120,
                    width: 120,
                  ),
                  SizedBox(height: _deviceHeight/25),
                  Text(
                    'Welcome to Mubariz News App!'.tr(),
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: _deviceHeight/25),
                  Text(
                    'Start building amazing apps with Flutter.',
                    style: TextStyle(fontSize: 18.0,),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: _deviceHeight/5),
                  ElevatedButton(
                    onPressed: () {
                      // Add navigation logic here
                      // cubit.changeLanguageToEnglish(context);
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Home()), (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 18.0, color: Colors.lightBlueAccent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Text(
        //       'ښه راغلاست',
        //       style: googleStyle(FontWeight.w400, 23),
        //     ),
        //     Text(
        //       'خوش امدید',
        //       style: googleStyle(FontWeight.w400, 23),
        //     ),
        //     // SizedBox(
        //     //   height: _deviceHeight / 30,
        //     // ),
        //     Text(
        //       'Welcome',
        //       style: googleStyle(FontWeight.w900, 23),
        //     ),
        //     SizedBox(
        //       height: _deviceWidth/4,
        //     ),
        //     Text('Select your language', style: googleStyle(FontWeight.w400, 23)),
        //     SizedBox(
        //       height: _deviceWidth/15,
        //     ),
        //     Container(
        //       width: _deviceWidth/2,
        //       child: ElevatedButton.icon(
        //         icon: Icon(
        //           Icons.language_outlined,
        //           color: Colors.lightBlueAccent,
        //         ),
        //         onPressed: () {},
        //           style: ButtonStyle(
        //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //                   RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(12),
        //                       side: BorderSide(color: Colors.lightBlueAccent)
        //                   )
        //               )
        //           ),
        //         label: Text('پښتو', style: GoogleFonts.aBeeZee(
        //           color: Colors.lightBlueAccent,
        //           fontSize: 20
        //         ),),
        //       ),
        //     ),
        //     Container(
        //       width: _deviceWidth/2,
        //       child: ElevatedButton.icon(
        //         icon: Icon(
        //             Icons.language_outlined,
        //           color: Colors.lightBlueAccent,
        //         ),
        //         onPressed: () {},
        //         style: ButtonStyle(
        //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //                 RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(12),
        //                     side: BorderSide(color: Colors.lightBlueAccent)
        //                 )
        //             )
        //         ),
        //         label: Text('دری', style: GoogleFonts.aBeeZee(
        //             color: Colors.lightBlueAccent,
        //             fontSize: 20
        //         ),),
        //       ),
        //     ),
        //     Container(
        //       width: _deviceWidth/2,
        //       child: ElevatedButton.icon(
        //         icon: Icon(
        //             Icons.language_outlined,color: Colors.lightBlueAccent,
        //         ),
        //         onPressed: () {},
        //         style: ButtonStyle(
        //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //                 RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(12),
        //                     side: BorderSide(color: Colors.lightBlueAccent)
        //                 )
        //             )
        //         ),
        //         label: Text('English', style: GoogleFonts.aBeeZee(
        //             color: Colors.lightBlueAccent,
        //             fontSize: 20
        //         ),),
        //       ),
        //     ),
        //     SizedBox(
        //       height: _deviceHeight / 4.5,
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(right: _deviceWidth / 20),
        //       child: Align(
        //         alignment: Alignment.centerRight,
        //         child: ElevatedButton(
        //           onPressed: () {
        //             Navigator.of(context).pushAndRemoveUntil(
        //               MaterialPageRoute(builder: (context) => Home()),
        //               (route) => false,
        //             );
        //           },
        //           style: ElevatedButton.styleFrom(
        //             padding: EdgeInsets.only(
        //                 right: 25, left: 25, top: 18, bottom: 18),
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(12), // <-- Radius
        //                 side: BorderSide(
        //                     width: 2, color: Colors.lightBlueAccent)),
        //           ),
        //           child: Text(
        //             'Start Reading...!',
        //             style: GoogleFonts.aBeeZee(
        //                 color: Colors.black, letterSpacing: 1),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
    );
  },
);
  }
}
