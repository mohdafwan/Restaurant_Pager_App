import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/color_palette.dart';
import 'package:restuarant_pager_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/routes/routes.dart';
import 'package:restuarant_pager_app/views/splashScreen/splash_screen.dart';
import 'controllers/notification/notification_settrings_controller.dart';
import 'firebase/firebase_api.dart';
import 'firebase_options.dart';

void main() async {
  await initApp();
  runApp(const MyApp());
}

Future<void> initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(NotificationsSettingsController());
  Get.put(DashboardController(), permanent: true);
  Get.put(AuthMethods(), permanent: true);
  await FirebaseApi().initNotifications();
  FirebaseAuth.instance.setLanguageCode('en');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        title: "Restaurant Pager App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const SplashScreen(),
        getPages: AppRoutes.routes,
      ),
    );
  }
}


