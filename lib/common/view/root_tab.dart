import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/product/view/product_tab.dart';
import 'package:flutter/material.dart';

import '../../restaurant/view/restaurant_screen.dart';
import '../const/colors.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin{
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: Center(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            RestaurantScreen(),
            ProductTab(),
            Center(
              child: Container(
                child: Text('주문'),
              ),
            ),
            Center(
              child: Container(
                child: Text('프로필'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined),
              label: '음식'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              label: '주문'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: '프로필'
          ),
        ]
      ),
    );
  }
}
