import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/text_style.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLiked = false;
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.sizeOf(context).height;
    _deviceWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(width: 2)),
            contentPadding: EdgeInsets.only(left: 25, right: 25),
            hintText: 'Search'.tr(),
            suffixIconColor: Colors.white,
            suffixIcon: IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.lightBlueAccent,
                ),
              ),
              onPressed: () async {
                // search some thing logic here
              },
              icon: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ),
          maxLines: 1,
        ),
        toolbarHeight: MediaQuery.sizeOf(context).height / 15.5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 50,
              ),
              SizedBox(
                height: 1000,
                child: ListView.builder(
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
                              Container(
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
                                height: _deviceHeight / 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/post.jpg'))),
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
                                      width: _deviceWidth/6,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 25,
                                        ),
                                        Text(
                                          '0',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
