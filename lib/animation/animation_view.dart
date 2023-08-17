import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_fetch/animation/animation_view_model.dart';

class PageAnimationView extends GetView<AnimationViewModel> {
  const PageAnimationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          style: BorderStyle.solid,
                          width: 4,
                          color: Colors.grey.shade50,
                        )),
                    child: SizedBox(
                      height: 300 + controller.progress * 140,
                      child: PageView(
                        controller: controller.pageController,
                        children: [
                          landingContent(),
                          signUp()
                          // SignUpForm(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                height: 56,
                top: ((Get.height / 2) - 100) - controller.progress * 30,
                // bottom: Get.height + 100,
                right: 16,
                child: InkWell(
                  onTap: () {
                    if (controller.pageController.page == 0) {
                      controller.pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.ease,
                      );

                      //
                    }
                    if (controller.pageController.page == 1) {
                      Get.back();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [0.4, 0.8],
                        colors: [
                          Color.fromARGB(255, 239, 104, 80),
                          Color.fromARGB(255, 139, 33, 146)
                        ],
                      ),
                    ),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80 + controller.progress * 32,
                            child: Stack(
                              children: [
                                Opacity(
                                    opacity: 1 - controller.progress.value,
                                    child: const Text("Get Started")),
                                Opacity(
                                    opacity: controller.progress.value,
                                    child: const Text(
                                      "Create account",
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                    )),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            size: 24,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

extension Views on PageAnimationView {
  landingContent() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Find local community events",
            style: TextStyle(
              // fontWeight: ,
              fontSize: 42,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Get involved with what's happening near you.",
            style: TextStyle(fontSize: 24, color: Colors.blueGrey.shade300),
          )
        ],
      ),
    );
  }

  signUp() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create an account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const _TextField(label: 'Email address', icon: Icons.email),
            const SizedBox(height: 16),
            const _TextField(
              label: 'Password',
              icon: Icons.lock,
              hidden: true,
            ),
            Text(
              "Already have an account? Sign in.",
              style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade300),
            )
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool hidden;

  const _TextField({
    Key? key,
    required this.label,
    required this.icon,
    this.hidden = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              cursorColor: Colors.pink.shade400,
              obscureText: hidden,
              autocorrect: !hidden,
              enableSuggestions: !hidden,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 18,
                ),
                suffixIcon: Icon(
                  icon,
                  color: Colors.grey.shade400,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink.shade400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
