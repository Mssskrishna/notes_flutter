import 'package:get/get.dart';
import '../screens/home_screen.dart';
import '../screens/note_screen.dart';
import '../bindings/note_binding.dart';

class AppPages {
  static const initial = '/';

  static final routes = [
    GetPage(
      name: '/',
      page: () => HomeScreen(),
      binding: NoteBinding(),
    ),
    GetPage(
      name: '/note',
      page: () => NoteScreen(),
      binding: NoteBinding(),
    ),
  ];
}
