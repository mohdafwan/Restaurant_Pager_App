import 'package:get/get.dart';
import 'package:restuarant_pager_app/views/LoginView/loginPage.dart';
import 'package:restuarant_pager_app/views/SignUpView/signUpPage.dart';
import 'package:restuarant_pager_app/views/main_screens/history_screen/history_screen.dart';
import 'package:restuarant_pager_app/views/main_screens/scanner_screen/scanner_screen.dart';
import 'package:restuarant_pager_app/views/notifaicatio/notification_screen_page_priyanka.dart';
import 'package:restuarant_pager_app/views/pages/dashboard/dashboard.dart';
import 'package:restuarant_pager_app/views/pages/dashboard/dashboard_binding.dart';
import 'package:restuarant_pager_app/views/pages/onboarding/boarding_screen.dart';
import 'package:restuarant_pager_app/views/setting/setting_page.dart';
import 'package:restuarant_pager_app/views/tickets/raise_ticket.dart';

import '../views/FrequentlyAskedQuestion/FrequentlyAskedQuestion.dart';
import '../views/Privacy/Privacy.dart';
import '../views/TermsAndCondition/TermsAndConditonView.dart';
import '../views/setting/about_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      transition: Transition.fadeIn,
      name: '/boarding_screens',
      page: () => BoardingScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
    ),
    GetPage(
      name: '/signup',
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => const Dashboard(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: '/scanner',
      page: () => ScannerScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: '/orderview',
      page: () => OrderHistoryView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: '/appsetting',
      page: () => const SettingsPagex(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),

    // ----------SettingScreen Routes
    // GetPage(
    //   name: '/onsettingprofile',
    //   page: () => const (),
    // ),
    // GetPage(
    //   name: '/onsettingpasswordreset',
    //   page: () => const (),
    // ),
    GetPage(
      name: '/onsettingnotification',
      page: () => const NotificationsSettingsPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    // GetPage(
    //   name: '/onsettingrate&review',
    //   page: () => const (),
    // ),
    // GetPage(
    //   name: '/onsettinghelp',
    //   page: () => const (),
    // ),
    GetPage(
      name: '/onsettingsubmitissue',
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
      page: () => const SubmitIssuePage(),
    ),
    GetPage(
      name: '/faq',
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
      page: () => const FrequentlyAskedQuestion(),
    ),
    GetPage(
      name: '/t&c',
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
      page: () => const TermsAndConditionView(),
    ),
    GetPage(
      name: '/privacy',
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
      page: () => const PrivacyPoliciesView(),
    ),
    GetPage(
      name: '/about',
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
      page: () => const AboutPage(),
    ),
  ];
}
