class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Welcome',
      image: 'assets/images/lottie2.json',
      discription:
          "Welcome to the agenda app\n"
          "We hope you find what you're looking for and that you enjoy your stay."),
  UnbordingContent(
      title: 'To-Do',
      image: 'assets/images/lottie1.json',
      discription:
          
          "a collection of tasks that outlines the work a project manager or team plans to complete during a project."),
  UnbordingContent(
      title: 'Get Set Gooo.....',
      image: 'assets/images/lottie3.json',
      discription:"make sure that your tasks are written down all in one place so you don't forget anything important."
          
           ),
];
