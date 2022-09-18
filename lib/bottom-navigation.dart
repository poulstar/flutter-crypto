import 'package:flutter/material.dart';

class Nav{
  static const iconSize = 24.0;
  static const selectedIconSize = 40.0;
  var icon;
  var text;
  var route;
  Nav({var this.icon, var this.text, var this.route});
}

class BottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomNavigationState();
  }
}

class BottomNavigationState extends State<BottomNavigation> {
  var navs = [
    Nav(icon: Icons.home, text: "Home", route: ""),
    Nav(icon: Icons.alarm_rounded, text: "Notification", route: "/notification"),
    Nav(icon: Icons.account_circle, text: "Profile", route: "/profile"),
    Nav(icon: Icons.settings, text: "Settings", route: "/settings")
  ];
  Nav? selected = null;

  BottomNavigationState() {
    this.selected = navs[0];
  }

  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16)
          ),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
            children: [
            for (var nav in navs)
              Expanded(child:
                  TextButton(onPressed: () {
                    setState(() {
                      selected = nav;
                    });
                    Navigator.of(context).pushNamed(nav.route);
                  },
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: nav == selected ? 8 : 15),
                          child: Column(
                              children: [
                                Icon(nav.icon, size: (nav == selected) ? Nav.selectedIconSize : Nav.iconSize),
                                Text(nav.text)
                              ]
                          ),
                      )
                  )
              )
            ]
        )
      );
  }
}