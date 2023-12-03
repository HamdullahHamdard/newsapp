import 'dart:io';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:newsapp/src/widgets/youtube_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../widgets/text_style.dart';
import 'create_post/view_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  late double _deviceHeight;
  late double _deviceWidth;
  bool _isLiked = false;

  final url =
      'https://img.freepik.com/free-photo/closeup-macaw-parrot-perched-branch_181624-45970.jpg?w=1380&t=st=1701585777~exp=1701586377~hmac=075d4f593d636497f97226ef0b119c1291ddc275c131dbcf429d12045f68afa3';
 // Insert your music URL
  var player = AudioPlayer();
  bool loaded = false;
  bool playing = false;

  void loadMusic() async {
    await player.setAsset('assets/images/TempFile.mp3');
    setState(() {
      loaded = true;
    });
  }

  void playMusic() async {
    setState(() {
      playing = true;
    });
    await player.play();
  }

  void pauseMusic() async {
    setState(() {
      playing = false;
    });
    await player.pause();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadMusic();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.sizeOf(context).height;
    _deviceWidth = MediaQuery.sizeOf(context).width;
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (BuildContext context, Object? state) {
        var cubit = NewsCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.white70,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  scrolledUnderElevation: 3,
                  toolbarHeight: MediaQuery.sizeOf(context).height / 12,
                  surfaceTintColor: Colors.lightBlueAccent,
                  title: Text(
                    'Mirror of Information'.tr(),
                    style: GoogleFonts.acme(
                        fontSize: 25, color: Colors.lightBlueAccent),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications_outlined,
                          color: Colors.lightBlueAccent,
                          size: 30,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    // BlocBuilder<NewsCubit, NewsState>(
                    //   builder: (BuildContext context, state) {
                    //     return IconButton(
                    //         onPressed: () {
                    //             BlocProvider.of<NewsCubit>(context)
                    //                 .changeThemeMode();
                    //         },
                    //         icon: Icon(BlocProvider.of<NewsCubit>(context).isDark ? Icons.dark_mode : Icons.light_mode), color: Colors.lightBlueAccent,);
                    //   },
                    // ),
                  ],
                  floating: true,
                  pinned: true,
                  bottom: TabBar(
                    indicatorColor: Colors.blue,
                    isScrollable: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    labelColor: Colors.lightBlueAccent,
                    tabs: <Tab>[
                      Tab(text: 'Images'.tr()),
                      Tab(text: 'Videos'.tr()),
                      Tab(text: 'Audios'.tr()),
                    ],
                    controller: _tabController,
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 18, left: 8, right: 8),
                        child: Card(
                          // color: cubit.isDark ? Colors.black : Colors.white, // Change the color as per your requirement
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Adjust the border radius
                          ),
                          // elevation: 1,
                          // elevation: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ImageView(image: 'assets/images/post.jpg')));
                                },
                                child: Container(
                                  height: _deviceHeight / 3.8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/post.jpg'))),
                                  child: Align(
                                    alignment: Alignment(1, -1),
                                    //Alignment(1, -1) place the image at the top & far left.
                                    //Alignment (0, 0) is the center of the container
                                    //You can change the value of x and y to any number between -1 and 1
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isLiked = !_isLiked;
                                        });
                                      },
                                      icon: Icon(
                                          _isLiked
                                              ? Icons.push_pin
                                              : Icons.push_pin_outlined,
                                          color: _isLiked
                                              ? Colors.lightBlue
                                              : Colors.white,
                                          size: 35),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: TextSelectionTheme(
                                  data: TextSelectionThemeData(
                                    selectionColor: Colors.blue.shade100,
                                    selectionHandleColor: Colors.blue.shade100,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: SelectableText(
                                      'Could X go bankrupt under Elon Musk',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: TextSelectionTheme(
                                  data: TextSelectionThemeData(
                                    selectionColor: Colors.blue.shade100,
                                    cursorColor: Colors.blue.shade100,
                                    selectionHandleColor: Colors.blue.shade100,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ReadMoreText.selectable(
                                      'Parrot Security provides a huge arsenal of tools, utilities and libraries that IT and security professionals can use to test and assess the security of their assets in a reliable, compliant and reproducible way. From information gathering to the final report. The Parrot system gets you covered with the most flexible environment.',
                                      numLines: 3,
                                      readMoreText: 'more'.tr(),
                                      readLessText: 'less'.tr(),
                                      textAlign: TextAlign.justify,
                                      readMoreAlign: Alignment.centerLeft,
                                      cursorColor: Colors.amber,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    // top: _deviceHeight / 80,
                                    left: _deviceHeight / 90),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/profile.JPG'),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    SizedBox(
                                      width: _deviceWidth / 40,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hamdullah Hamdard',
                                          style: GoogleFonts.acme(),
                                        ),
                                        Text(
                                          '2 Second ago',
                                          style: GoogleFonts.acme(
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: _deviceWidth / 6,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 20,
                                        ),
                                        Text(
                                          '0',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          final url =
                                              'https://img.freepik.com/free-photo/closeup-macaw-parrot-perched-branch_181624-45970.jpg?w=1380&t=st=1701585777~exp=1701586377~hmac=075d4f593d636497f97226ef0b119c1291ddc275c131dbcf429d12045f68afa3';
                                          final urlI = Uri.parse(url);
                                          final response = await http.get(urlI);
                                          final bytes = response.bodyBytes;
                                          final temp =
                                              await getTemporaryDirectory();
                                          final path = '${temp.path}/image.jpg';
                                          Share.shareXFiles([XFile(path)],
                                              text: 'create parrot image share',
                                              subject: 'Create a file',
                                              sharePositionOrigin:
                                                  Rect.fromCenter(
                                                      center: Offset.infinite,
                                                      width: 22,
                                                      height: 33));
                                        },
                                        icon: Icon(FontAwesomeIcons.share)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: _deviceHeight / 80,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 18, left: 8, right: 8),
                        child: Card(
                          // color: cubit.isDark ? Colors.black : Colors.white, // Change the color as per your requirement
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Adjust the border radius
                          ),
                          // elevation: 1,
                          // elevation: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: _deviceHeight / 3.8,
                                width: _deviceWidth,
                                child: SafeArea(child: VideoPlayerScreen(videoId: 'https://youtu.be/HvmwbaGZ97g?si=Tazq1IcL_qKWPhWr')),

                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: TextSelectionTheme(
                                  data: TextSelectionThemeData(
                                    selectionColor: Colors.blue.shade100,
                                    selectionHandleColor: Colors.blue.shade100,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: SelectableText(
                                      'Could X go bankrupt under Elon Musk',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: TextSelectionTheme(
                                  data: TextSelectionThemeData(
                                    selectionColor: Colors.blue.shade100,
                                    cursorColor: Colors.blue.shade100,
                                    selectionHandleColor: Colors.blue.shade100,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: const ReadMoreText.selectable(
                                      'Parrot Security provides a huge arsenal of tools, utilities and libraries that IT and security professionals can use to test and assess the security of their assets in a reliable, compliant and reproducible way. From information gathering to the final report. The Parrot system gets you covered with the most flexible environment.',
                                      numLines: 3,
                                      readMoreText: 'more',
                                      readLessText: 'lees',
                                      textAlign: TextAlign.justify,
                                      readMoreAlign: Alignment.centerLeft,
                                      cursorColor: Colors.amber,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    // top: _deviceHeight / 80,
                                    left: _deviceHeight / 90),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/profile.JPG'),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    SizedBox(
                                      width: _deviceWidth / 40,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hamdullah Hamdard',
                                          style: GoogleFonts.acme(),
                                        ),
                                        Text(
                                          '2 Second ago',
                                          style: GoogleFonts.acme(
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: _deviceWidth / 6,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 20,
                                        ),
                                        Text(
                                          '0',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          final url =
                                              'https://img.freepik.com/free-photo/closeup-macaw-parrot-perched-branch_181624-45970.jpg?w=1380&t=st=1701585777~exp=1701586377~hmac=075d4f593d636497f97226ef0b119c1291ddc275c131dbcf429d12045f68afa3';
                                          final urlI = Uri.parse(url);
                                          final response = await http.get(urlI);
                                          final bytes = response.bodyBytes;
                                          final temp =
                                              await getTemporaryDirectory();
                                          final path = '${temp.path}/image.jpg';
                                          Share.shareXFiles([XFile(path)],
                                              text: 'create parrot image share',
                                              subject: 'Create a file',
                                              sharePositionOrigin:
                                                  Rect.fromCenter(
                                                      center: Offset.infinite,
                                                      width: 22,
                                                      height: 33));
                                        },
                                        icon: Icon(FontAwesomeIcons.share)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: _deviceHeight / 80,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 18, left: 8, right: 8),
                        child: Card(
                          // color: cubit.isDark ? Colors.black : Colors.white, // Change the color as per your requirement
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Adjust the border radius
                          ),
                          // elevation: 1,
                          // elevation: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: StreamBuilder(
                                    stream: player.positionStream,
                                    builder: (context, snapshot1) {
                                      final Duration duration = loaded
                                          ? snapshot1.data as Duration
                                          : const Duration(seconds: 0);
                                      return StreamBuilder(
                                          stream: player.bufferedPositionStream,
                                          builder: (context, snapshot2) {
                                            final Duration bufferedDuration =
                                                loaded
                                                    ? snapshot2.data as Duration
                                                    : const Duration(
                                                        seconds: 0);
                                            return SizedBox(
                                              height: 30,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: ProgressBar(
                                                  progress: duration,
                                                  total: player.duration ??
                                                      const Duration(
                                                          seconds: 0),
                                                  buffered: bufferedDuration,
                                                  timeLabelPadding: -1,
                                                  timeLabelTextStyle:
                                                      const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                  progressBarColor: Colors.red,
                                                  baseBarColor:
                                                      Colors.grey[200],
                                                  bufferedBarColor:
                                                      Colors.grey[350],
                                                  thumbColor: Colors.red,
                                                  onSeek: loaded
                                                      ? (duration) async {
                                                          await player
                                                              .seek(duration);
                                                        }
                                                      : null,
                                                ),
                                              ),
                                            );
                                          });
                                    }),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [

                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.download),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red),
                                    child: IconButton(
                                        onPressed: loaded
                                            ? () {
                                                if (playing) {
                                                  pauseMusic();
                                                } else {
                                                  playMusic();
                                                }
                                              }
                                            : null,
                                        icon: Icon(
                                          playing
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Align(
                                    alignment: Alignment(1, -1),
                                    //Alignment(1, -1) place the image at the top & far left.
                                    //Alignment (0, 0) is the center of the container
                                    //You can change the value of x and y to any number between -1 and 1
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isLiked = !_isLiked;
                                        });
                                      },
                                      icon: Icon(
                                          _isLiked
                                              ? Icons.push_pin
                                              : Icons.push_pin_outlined,
                                          color: _isLiked
                                              ? Colors.lightBlue
                                              : Colors.lightBlue,
                                          size: 25),
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: TextSelectionTheme(
                                  data: TextSelectionThemeData(
                                    selectionColor: Colors.blue.shade100,
                                    selectionHandleColor: Colors.blue.shade100,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: SelectableText(
                                      'Could X go bankrupt under Elon Musk',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: TextSelectionTheme(
                                  data: TextSelectionThemeData(
                                    selectionColor: Colors.blue.shade100,
                                    cursorColor: Colors.blue.shade100,
                                    selectionHandleColor: Colors.blue.shade100,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: const ReadMoreText.selectable(
                                      'Parrot Security provides a huge arsenal of tools, utilities and libraries that IT and security professionals can use to test and assess the security of their assets in a reliable, compliant and reproducible way. From information gathering to the final report. The Parrot system gets you covered with the most flexible environment.',
                                      numLines: 3,
                                      readMoreText: 'more',
                                      readLessText: 'lees',
                                      textAlign: TextAlign.justify,
                                      readMoreAlign: Alignment.centerLeft,
                                      cursorColor: Colors.amber,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    // top: _deviceHeight / 80,
                                    left: _deviceHeight / 90),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/profile.JPG'),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    SizedBox(
                                      width: _deviceWidth / 40,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hamdullah Hamdard',
                                          style: GoogleFonts.acme(),
                                        ),
                                        Text(
                                          '2 Second ago',
                                          style: GoogleFonts.acme(
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: _deviceWidth / 6,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 20,
                                        ),
                                        Text(
                                          '0',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          final url =
                                              'https://img.freepik.com/free-photo/closeup-macaw-parrot-perched-branch_181624-45970.jpg?w=1380&t=st=1701585777~exp=1701586377~hmac=075d4f593d636497f97226ef0b119c1291ddc275c131dbcf429d12045f68afa3';
                                          final urlI = Uri.parse(url);
                                          final response = await http.get(urlI);
                                          final bytes = response.bodyBytes;
                                          final temp =
                                              await getTemporaryDirectory();
                                          final path = '${temp.path}/image.jpg';
                                          Share.shareXFiles([XFile(path)],
                                              text: 'create parrot image share',
                                              subject: 'Create a file',
                                              sharePositionOrigin:
                                                  Rect.fromCenter(
                                                      center: Offset.infinite,
                                                      width: 22,
                                                      height: 33));
                                        },
                                        icon: Icon(FontAwesomeIcons.share)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: _deviceHeight / 80,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                // Center(
                //   child: Text('name'),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
