import 'package:coinbase_auth_design_practice/signin.dart';
import 'package:coinbase_auth_design_practice/signup.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


/// The initial Home screen after you open the Coinbase Pro app.
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController scaleController;

  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..addStatusListener((status) {
        // Navigate to the Sign up screen after the animation has completed
        if (status == AnimationStatus.completed) {
          scaleController.reverse();
          Navigator.push(
            context,
            PageTransition(
              child: SignUp(),
              type: PageTransitionType.fade,
              curve: Curves.easeInOut,
            ),
          );
        }
      });

    // The scale animation being executed if you press "Get Started".
    scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 80.0,
    ).animate(scaleController);
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'coinbase | Pro',
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'The most trusted cryptocurrency exchange',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignIn();
                        }));
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    
                    // Kinda made a hack here. Couldn't fully replicate the animation they do
                    // pixel-by-pixel, so I just kinda made it work.
                    // A container is hidden behind the RaisedButton.
                    // Once the button is pressed, the container simply scales to fit the whole screen.
                    Stack(
                      children: <Widget>[
                        AnimatedBuilder(
                          animation: scaleAnimation,
                          builder: (context, child) => Transform.scale(
                            scale: scaleAnimation.value,
                            child: Container(
                              height: 40,
                              width: 45,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFF3232ff),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                          elevation: 0,
                          onPressed: () {
                            scaleController.forward();
                          },
                          textColor: Colors.white,
                          child: Text(
                            'Get started',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
