import 'package:daily_nasa_image/business_logic/main_cubit/main_cubit.dart';
import 'package:daily_nasa_image/business_logic/main_cubit/main_states.dart';
import 'package:daily_nasa_image/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestScreen extends StatelessWidget {
   TestScreen({Key? key}) : super(key: key);
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainStates>(
      listener: (context, state) {
        if(state is LoginSuccessState){
          if(state.registerModel.data!.user!.type==1){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute
              (builder: (context) => MainScreen(),), (route) => false).then(
                    (value) {MainCubit.get(context).getData();});
          }
        }
      },
      builder: (context,state){
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController ,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      hintText: 'Name'
                  ),
                ),
                TextFormField(
                  controller: emailController ,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: 'Email'
                  ),
                ),
                TextFormField(
                  controller: phoneController ,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      hintText: 'Phone'
                  ),
                ),
                TextFormField(
                  controller: passwordController ,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: 'Password'
                  ),
                ),
                TextFormField(
                  controller: passwordConfirmController ,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: 'PasswordConfirm'
                  ),
                ),
                SizedBox(height: 30,),
                TextButton(onPressed: (){
                  MainCubit.get(context).login(phone: phoneController.text,
                      password: passwordController.text,email: emailController
                        .text,passwrordConfrim: passwordConfirmController.text,
                      name: nameController.text);
                }, child: Text('Register'),),
              ],
            ),
          ),
        );
      },
    );
  }
}
