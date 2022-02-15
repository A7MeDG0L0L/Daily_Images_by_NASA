import 'package:daily_nasa_image/business_logic/main_cubit/main_cubit.dart';
import 'package:daily_nasa_image/presentation/screens/main_screen.dart';
import 'package:daily_nasa_image/presentation/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../business_logic/main_cubit/main_states.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:
          (context) =>   MainScreen(),), (route) => false);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MainCubit,MainStates>(
      listener: (context, state) {

      },
      builder: (context,state){
        return  Scaffold(
          body: Container(
            color: Colors.lightBlueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/splash.png'),
                const SizedBox(height: 30,),
                RichText(text: TextSpan(
                  style: Theme.of(context).textTheme.headline5?.copyWith(color:
                  Colors.deepPurple),
                  children: const <TextSpan>[
                    TextSpan(text: 'Daily Image by', style: TextStyle(fontWeight:
                    FontWeight
                        .bold,color: Colors.white)),
                    TextSpan(text: ' Nasa',style: TextStyle(
                      fontFamily: 'Nasa',),),

                  ],
                ),),
              ],
            ),
          ),
        );
      } ,
    );
  }
}
