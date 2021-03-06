import 'package:buletin/models/account.dart';
import 'package:buletin/screens/explore_screen.dart';
import 'package:buletin/screens/home_screen.dart';
import 'package:buletin/screens/login_screen.dart';
import 'package:buletin/screens/profile_screen.dart';
import 'package:buletin/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:buletin/api/auth_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:buletin/utils/extension_image.dart';

class SideNavigationBar extends StatelessWidget {
  const SideNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future logout() async {
      Provider.of<AuthApi>(context, listen: false).authLogout();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }

    var accountFullname = 'Guest';
    var accountEmail = '';
    var isLoggedIn = context.watch<AuthApi>().isAuth;
    Account? account;
    if (isLoggedIn) {
      var acc = context.read<AuthApi>().account;
      if (acc is Account) {
        account = acc;
        accountFullname = acc.accountFullname;
        accountEmail = acc.accountEmail;
      }
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onTap: () {
              if (isLoggedIn) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfileScreen(account: account!)));
              }
            },
            child: UserAccountsDrawerHeader(
              accountName: Text(accountFullname),
              accountEmail: Text(accountEmail),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    isLoggedIn
                        ? "https://lh3.googleusercontent.com/ogw/ADea4I59lb97jZRtDffSpVpk2RXi52W5S0Y3cXq8VIrkCQ=s83-c-mo"
                        : "https://lh3.googleusercontent.com/a-/AOh14Gg45BDQLqBCroOjL85biknOs9kKwywRzw5rWoNw=s360-p-rw-no",
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (context, exeption, stackTrace) {
                      return Image.asset(
                        'placeholder'.jpg,
                        fit: BoxFit.cover,
                        height: 90,
                        width: 90,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'rotate-left'.svg,
            ),
            title: const Text("History"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HistoryScreen()));
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'home'.svg,
            ),
            title: const Text("Home"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'grid-4'.svg,
            ),
            title: const Text("Explore"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ExploreScreen()));
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.collections_bookmark_outlined),
          //   title: const Text("Reccomendation"),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => ForYouScreen()));
          //   },
          // ),
          // const Divider(),
          // ListTile(
          //   leading: SvgPicture.asset(
          //     'settings'.svg,
          //   ),
          //   title: const Text("Settings"),
          //   onTap: () {},
          // ),
          // ListTile(
          //   leading: SvgPicture.asset(
          //     'question-circle'.svg,
          //   ),
          //   title: const Text("Help & Suggestion"),
          //   onTap: () {},
          // ),
          const Divider(),
          if (isLoggedIn) ...[
            ListTile(
              leading: SvgPicture.asset(
                'logout'.svg,
              ),
              title: const Text("Logout"),
              onTap: () {
                logout();
              },
            )
          ] else ...[
            ListTile(
              leading: SvgPicture.asset(
                'login'.svg,
              ),
              title: const Text("Login"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ],
      ),
    );
  }
}
