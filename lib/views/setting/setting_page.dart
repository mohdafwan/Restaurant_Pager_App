import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/controllers/dashboard_controller/dashboard_controller.dart';
import '../../widgets/alert_dialog.dart';
import '../FeedBack/FeedBackSheet.dart';
import '../main_screens/home_screen/componentes/refer_card.dart';
import 'components/profile_card.dart';
import 'components/setting_group.dart';
import 'components/setting_tile.dart';

class SettingsPagex extends StatelessWidget {
  const SettingsPagex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
              onPressed: () {
                Get.find<DashboardController>().changeTabIndex(0);
              },
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
                size: 24,
              )),
        ),
        backgroundColor: Colors.white,
        // title: const Text(
        //   'Settings',
        //   style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
        // ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            ProfileCard(),
            const SizedBox(height: 16),
            SettingsGroup(
              settingsGroupTitle: 'Account',
              items: [
                SettingTile(
                  title: 'Profile',
                  icon: Icons.person_outline_rounded,
                  onTap: () {
                    Get.find<DashboardController>().changeTabIndex(3);

                  },
                ),
                SettingTile(
                  title: 'Notification',
                  icon: Icons.notifications_none_rounded,
                  onTap: () {
                    Get.toNamed("/onsettingnotification");
                  },
                ),
                SettingTile(
                  title: 'FAQ',
                  icon: Icons.help_outline,
                  onTap: () {
                    Get.toNamed("/faq");
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SettingsGroup(
              settingsGroupTitle: 'More',
              items: [
                SettingTile(
                  title: 'Send Feedback',
                  icon: Icons.feedback_outlined,
                  onTap: () {
                    showFeedBackForm(context);
                  },
                ),
                SettingTile(
                  title: 'Raise Ticket',
                  icon: Icons.airplane_ticket_outlined,
                  onTap: () {
                    Get.find<DashboardController>().changeTabIndex(5);
                  },
                ),
                SettingTile(
                  title: 'Ticket History',
                  icon: Icons.history_outlined,
                  onTap: () {
                    Get.find<DashboardController>().changeTabIndex(6);
                  },
                ),
                SettingTile(
                  title: 'About',
                  icon: Icons.info_outline,
                  onTap: () {
                    Get.toNamed('/about');
                  },
                ),
                SettingTile(
                  title: 'Sign Out',
                  icon: Icons.logout_outlined,
                  onTap: () {
                    showCustomAlertDialog(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const ReferFriendCard(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// To show the dialog
void showCustomAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ReusableAlertDialog(
        title: 'Logout',
        icon: Icons.logout,
        subtitle: 'Are you sure you want to log out?',
        onYesPressed: () {
          Get.find<AuthMethods>().signOut();
        },
        onNoPressed: () {
          // Handle No button action
          Navigator.of(context).pop();
        },
        yesButtonText: 'Yes',
        noButtonText: 'No',
        backgroundColor: Colors.orange[200],
      );
    },
  );
}
