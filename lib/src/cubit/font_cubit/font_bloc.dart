import 'package:bloc/bloc.dart';

import 'font_event.dart';
import 'font_state.dart';

class FontBloc extends Bloc<FontEvent, FontState> {
  FontBloc() : super(FontState('DefaultFont'));

  @override
  Stream<FontState> mapEventToState(FontEvent event) async* {
    if (event == FontEvent.selectFont) {
      // Add logic here to handle font selection
      // You can fetch the selected font from shared preferences or any other storage mechanism
      // For simplicity, I'm using a hardcoded list of fonts
      List<String> availableFonts = ['DefaultFont', 'Font1', 'Font2', 'Font3', 'Font4', 'Font5'];

      // Logic to get the next font from the list
      int currentIndex = availableFonts.indexOf(state.selectedFont);
      int nextIndex = (currentIndex + 1) % availableFonts.length;

      yield FontState(availableFonts[nextIndex]);
    }
  }
}