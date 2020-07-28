import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_kminh/resources/dimens.dart';
import 'package:iot_kminh/resources/strings.dart';
import 'package:iot_kminh/resources/styles.dart';
import 'package:iot_kminh/utils/lang.dart';
import 'package:iot_kminh/widget/none_scroll_behavior.dart';
import 'package:iot_kminh/widget/progress_button.dart';
import '../../main.dart';
import '../routes.dart';
import 'onboarding_bloc.dart';
import 'onboarding_event.dart';

class OnboardingScreen extends StatefulWidget {

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingScreen> {

  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  int numOfPage = 3;

  /// Rounded Rectangle(Default) or Circle(Pass it as true for Circle)
  bool isPageIndicatorCircle = false;
  String nextText = '';

  void _changeLanguage(String language) async {
    Locale _locale = await setLocale(language);
    JocoApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, int>(
      builder: (context, state){
        if(state < 2){
          nextText = translate(context, Strings.next);
        } else {
          nextText = translate(context, Strings.signIn);
        }
        return Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.4, 0.7, 0.9],
                  colors: [
                    Color(0xFF3594DD),
                    Color(0xFF4563DB),
                    Color(0xFF5036D5),
                    Color(0xFF5B16D0),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Dimens.xlarge),
                child: Column(
                  children: <Widget>[
                    skipButton(),
                    pageView(),
                    pageIndicator(),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    nextButton(),
                    progressButton(),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    languageButton(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  /// Skip Button
  Widget skipButton(){
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        child: Text(
          translate(context, Strings.skip),
          style: textWhite,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.signIn);
        },
      ),
    );
  }

  /// Next Button
  Widget nextButton(){
    return Container(
      child: FlatButton(
        child: Text(
          nextText,
          style: textWhite,
        ),
        onPressed: () {
          pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
      ),
    );
  }

  /// Language Button
  Widget languageButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Text(Strings.vietnamese),
          onPressed: () {
            _changeLanguage('vi');
          },
        ),
        FlatButton(
          child: Text(Strings.english),
          onPressed: () {
            _changeLanguage('en');
          },
        )
      ],
    );
  }

  /// Progress Button
  Widget progressButton(){
    return ProgressButton(
      defaultWidget: const Text('Progress Button'),
      type: ProgressButtonType.Outline,
      animate: false,
      borderRadius: 20,
      progressWidget: const CircularProgressIndicator(),
      width: 196,
      height: 40,
      onPressed: () async {
        int score = await Future.delayed(
            const Duration(milliseconds: 1000), () => 42);
        // After [onPressed], it will trigger animation running backwards, from end to beginning
        return () {
            Navigator.of(context).pushNamed(Routes.home);
          // Optional returns is returning a VoidCallback that will be called
          // after the animation is stopped at the beginning.
          // A best practice would be to do time-consuming task in [onPressed],
          // and do page navigation in the returned VoidCallback.
          // So that user won't missed out the reverse animation.
        };
      },
    );
  }

  /// Page Indicator
  Widget pageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pageIndicatorList(numOfPage, currentPage, isPageIndicatorCircle),
    );
  }
  List<Widget> pageIndicatorList(
      int numOfPages,
      int currentPage,
      bool isPageIndicatorCircle,
      ) {
    List<Widget> list = [];

    for (int i = 0; i < numOfPages; i++) {
      list.add(i == currentPage
          ? currentPageIndicator(true, isPageIndicatorCircle)
          : currentPageIndicator(false, isPageIndicatorCircle));
    }
    return list;
  }
  Widget currentPageIndicator(bool isActive, bool isPageIndicatorCircle) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isPageIndicatorCircle ? 8 : 24,
      decoration: pageIndicatorBoxDecoration(isActive, isPageIndicatorCircle),
    );
  }
  Decoration pageIndicatorBoxDecoration(isActive, isPageIndicatorCircle) {
    return BoxDecoration(
      color: isActive ? Colors.white : Color(0xFF7B51D3),
      borderRadius: BorderRadius.all(
        Radius.circular(
          isPageIndicatorCircle ? 5 : 100,
        ),
      ),
    );
  }

  /// Page Indicator
  Widget pageView(){
    return Container(
      height: 400,
      child: ScrollConfiguration(
        behavior: NoneScrollBehavior(),
        child: PageView(
          physics: ClampingScrollPhysics(),
          controller: pageController,
          onPageChanged: (int page) {
            setState(() {
              if(currentPage <= page){
                BlocProvider.of<OnboardingBloc>(context).add(OnboardingEvent.next);
              } else {
                BlocProvider.of<OnboardingBloc>(context).add(OnboardingEvent.prev);
              }
              currentPage = page;
            });
          },
          children: pageScreen(),
        ),
      ),
    );
  }
  List<Widget> pageScreen() {
    List<Widget> page = [];
    List<PageContent> screenContent =[];
    for( var i = 1 ; i <= numOfPage; i++ ) {
      String heading = translate(context, 'heading$i');
      String sub = translate(context, 'sub_heading$i');
      String image = 'assets/images/onboarding$i.png';
      screenContent.add(PageContent(heading, sub, image));
    }
    for (int i = 0; i < numOfPage; i++) {
      try {
        page.add(getScreenPage(screenContent, i));
      } catch (e) {
        print("You should provide enough content for all screens");
      }
    }
    return page;
  }
  Widget getScreenPage(List<PageContent> content, int index){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image(
              width: 250.0,
              height: 250.0,
              image: AssetImage(content[index].pathImage),
            ),
          ),
          SizedBox(height: Dimens.medium),
          Text(
            content[index].title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26.0,
              height: 1.5,
            ),
          ),
          SizedBox(height: Dimens.medium),
          Text(
            content[index].subTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

}

class PageContent {
  String title;
  String subTitle;
  String pathImage;
  PageContent(this.title, this.subTitle, this.pathImage);
}