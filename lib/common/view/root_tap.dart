import 'package:flutter/material.dart';
import 'package:untitled1/common/const/colors.dart';
import 'package:untitled1/common/layout/default_layout.dart';
import 'package:untitled1/restaurant/view/restaurant_screen.dart';

class RootTap extends StatefulWidget {
  const RootTap({super.key});

  @override
  State<RootTap> createState() => _RootTapState();
}

class _RootTapState extends State<RootTap> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);

    controller.addListener(tapListener);
  }

  @override
  void dispose() {
    controller.removeListener(tapListener);

    super.dispose();
  }

  void tapListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "코팩 딜리버리",
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),

          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
        ],
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        type: BottomNavigationBarType.fixed,
      ),
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          RestaurantScreen(),

          Container(child: Text("음식 ")),

          Container(child: Text("주문")),

          Container(child: Text("프로필")),
        ],
      ),
    );
  }
}
