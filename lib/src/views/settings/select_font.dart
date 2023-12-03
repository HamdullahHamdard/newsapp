import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/font_cubit/font_bloc.dart';
import '../../cubit/font_cubit/font_event.dart';
import '../../cubit/font_cubit/font_state.dart';

class MyHomePage extends StatelessWidget {
  String _fontFamily = 'Proxima';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FontBloc, FontState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: DropdownButton<String>(
              value: state.selectedFont,
              onChanged: (String? newValue) {
                // You can add more logic here if needed
                context.read<FontBloc>().add(FontEvent.selectFont);
              },
              items: <String>['DefaultFont', _fontFamily, 'Font2', 'Font3', 'Font4', 'Font5']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}