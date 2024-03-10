import 'package:edu_track/Onboarding/onboarding_items.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomSheet: Row(
        children: [
          TextButton(onPressed: (){}, child: Text("Skip") ),
          TextButton(onPressed: (){}, child: Text("Next")),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image),
                  const SizedBox(height: 15),
                  Text(controller.items[index].title,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 15),
                  Text(controller.items[index].descriptions,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),textAlign: TextAlign.center,),
                ],
              );

        }
        ),
      ),
    );
  }
}
