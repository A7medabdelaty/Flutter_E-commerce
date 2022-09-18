import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardModel {
  String body;

  String title;

  String image;

  OnBoardModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardingController = PageController();

  final List<OnBoardModel> boardingList = [
    OnBoardModel(
        image: 'assets/images/onBoarding_Image_1.jpg',
        title: 'Title 1',
        body: 'Body 1'),
    OnBoardModel(
        image: 'assets/images/onBoarding_Image_2.jpg',
        title: 'Title 2',
        body: 'Body 2'),
    OnBoardModel(
        image: 'assets/images/onBoarding_Image_3.jpg',
        title: 'Title 3',
        body: 'Body 3'),
  ];

  bool isLastPage = false;
  Icon floatingIcon = const Icon(Icons.navigate_next);

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  void onSubmit() {
    CacheHelper.setData(key: 'onBoarding', value: true).then((value) {
      if (value == true) {
        return navigateAndReplace(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: onSubmit, child: const Text('SKIP'))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  if (index == boardingList.length - 1) {
                    isLastPage = true;
                    setState(() {
                      floatingIcon = const Icon(Icons.check);
                    });
                  } else {
                    isLastPage = false;
                    setState(() {
                      floatingIcon = const Icon(Icons.navigate_next);
                    });
                  }
                });
              },
              controller: boardingController,
              itemBuilder: (context, index) =>
                  onBoardingItem(boardingList[index]),
              itemCount: 3,
              physics: const BouncingScrollPhysics(),
            )),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boardingList.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: mainColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 3,
                    spacing: 10,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLastPage == false) {
                      boardingController.nextPage(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.decelerate);
                    } else {
                      onSubmit();
                    }
                  },
                  child: floatingIcon,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget onBoardingItem(OnBoardModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        Text(
          model.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          model.body,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
