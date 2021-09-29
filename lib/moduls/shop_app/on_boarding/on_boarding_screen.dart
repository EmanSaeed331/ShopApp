import 'package:flutter/material.dart';
import 'package:shopapp/moduls/shop_app_login/login_screen.dart';
import 'package:shopapp/shared/styles/colors.dart';
import 'package:shopapp/shared/styles/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';




class BoardingModel {
  final String image ;
  final String title;
  final String body;
  BoardingModel({
   @required this.image,
   @required this.title,
   @required this.body,
});
}

class OnBoardingScreen  extends StatefulWidget
{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
var boardController =PageController();

List<BoardingModel> boarding = [
  BoardingModel(
    image:'assets/images/on_boarding.jpg',
    title:'On Board 1 Title',
    body :'On Board 1 Body',

  ),
  BoardingModel(
    image:'assets/images/onboarding.jpg',
    title:'On Board 2 Title',
    body :'On Board 2 Body',

  ),
  BoardingModel(
    image:'assets/images/shoping.jpg',
    title:'On Board 3 Title',
    body :'On Board 3 Body',

  ),
];
bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(onPressed:(){
            navigateAndFinish(context, LoginScreen());
          },child:Text(
            'SKIP',
          ),),
        ],
      ),
      body :Padding(
      padding : const EdgeInsets.all(30.0),
      child:Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (int index){
                if(index == boarding.length -1 )
                {
                  setState(() {
                    isLast = true;
                  });
                  print('Last');
                }
                else{
                  print('not Last');

                  setState(() {
                    isLast = false;

                  });

                }
              } ,
              physics: BouncingScrollPhysics(),
              controller: boardController,
              itemBuilder: (context,index) => buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),

          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              SmoothPageIndicator(
                  controller : boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing:5,
                    activeDotColor: defaultColor,
                  ),
                  count:boarding.length,

              ),
              Spacer(),
              FloatingActionButton(
                  onPressed: () {
                    if(isLast)
                      {
                        navigateAndFinish(context,LoginScreen());
                      }else
                        {
                      boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }

                  },
              child: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),

        ],
      ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children : [
      Expanded(
        child: Image(
          image : AssetImage('${model.image}'),

        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),


    ],
  );
}
