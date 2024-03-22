import 'package:edu_track/Onboarding/onboarding_items.dart';
import 'package:edu_track/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage? getstarted() : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: ()=>pageController.jumpToPage(controller.items.length-1), child: const Text("Skip") ),
        
            SmoothPageIndicator(
              controller: pageController, 
              count: controller.items.length,
              onDotClicked: (index) => pageController.animateToPage(index, 
              duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
              effect: const WormEffect(

                activeDotColor: Colors.green,
              ),
              ),
        
            TextButton(onPressed: ()=>pageController.nextPage(
              duration: const Duration(milliseconds: 600), curve: Curves.easeIn), 
              child: const Text("Next")),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) => setState(()=> isLastPage = controller.items.length-1 == index),
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
  Widget getstarted(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.green),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(onPressed: () {
            // Navigate to the new page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  FormPage()),
            );
          }, 
      child: const Text("Get Started", style: TextStyle(color: Colors.white),)));
  }
}
