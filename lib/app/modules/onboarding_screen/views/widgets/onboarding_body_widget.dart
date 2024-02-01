class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Manage Your Tasks Efficiently",
    image: "assets/images/image1.png",
    desc: "Keep track of your tasks and stay organized with our app.",
  ),
  OnboardingContents(
    title: "Collaborate with Your Team",
    image: "assets/images/image2.png",
    desc:
        "Work together with your colleagues to achieve your goals and projects.",
  ),
  OnboardingContents(
    title: "Stay Informed with Task Notifications",
    image: "assets/images/image3.png",
    desc:
        "Receive notifications for important tasks and never miss a deadline.",
  ),
];
