import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:daily_nasa_image/business_logic/main_cubit/main_cubit.dart';
import 'package:daily_nasa_image/business_logic/main_cubit/main_states.dart';
import 'package:daily_nasa_image/presentation/style/custom_app_bar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class MainScreen extends StatefulWidget {
   MainScreen({Key? key}) : super(key: key);

   static late ConnectivityResult connectivity;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var fapKey = GlobalKey<ScaffoldState>();

  // final bool connected = MainScreen.connectivity != ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> subscription;
   String? result;
   bool isNetworkAvailable=false;

   @override
  void initState() {

      subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
print(result.name);
//MainCubit.get(context).getData();
setState(() {
  this.result = result.name;
});

        print(this.result);

        // if(result.name=='ConnectivityResult.none'){
        //   isNetworkAvailable = !isNetworkAvailable;
        // }
if(result.name != 'none'){
  isNetworkAvailable = true;
  MainCubit.get(context).getData();
}else {
  isNetworkAvailable = false;
}
print(subscription);
     });


     super.initState();
  }
  @override
  void dispose() {
     subscription.cancel();

    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if(state is SaveImageSuccess){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text
            ('Photo Saved Successfully'),backgroundColor: Colors.lightBlueAccent),);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Daily Images By NASA'),
          ),
          //appBar: BlurredAppBar(url:MainCubit.get(context).dataModel.url ,),
          floatingActionButton: isNetworkAvailable? Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              if(MainCubit.get(context).i>0)
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: FloatingActionButton(
                  onPressed: () {
                    MainCubit.get(context).getPrevData();
                  },
                  child: Icon(Icons.navigate_before),
                ),
              ),

              FloatingActionButton(
                onPressed: () {
                  MainCubit.get(context).getNextData();
                },
                child: Icon(Icons.navigate_next),
              ),
            ],
          ):SizedBox(),
          body: OfflineBuilder(
            connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
                ) {
              final bool connected = connectivity != ConnectivityResult.none;
              if(connected){
                return builderConsumer();
              }
              else {
                return Center(
                  child: Lottie.asset('assets/json/no-internet.json'),
                );
              }
            },
            child: Center(child: CircularProgressIndicator(),),
          ),
        );
      },
    );
  }
}

Widget builderConsumer(){
  return

BlocConsumer<MainCubit, MainStates>(
listener: (context, state) {},
builder: (context, state) {
if (state is GetDataSuccess) {
return SingleChildScrollView(
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Dismissible(
  onDismissed: (DismissDirection direction){
    print(direction);
    if(direction ==DismissDirection.endToStart){

      MainCubit.get(context).getPrevData();
    }
    if(direction == DismissDirection.startToEnd) {
      MainCubit.get(context).getNextData();
    }
  },
  key: UniqueKey(),
  child:   Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(state.dataModel.title,
  style: Theme.of(context).textTheme.headline5),
  SizedBox(
  height: 5,
  ),
  if (state.dataModel.copyright != null)
  Text('Copyright : ${state.dataModel.copyright}'),
  SizedBox(
  height: 5,
  ),
  Text('date : ${state.dataModel.date}'),
  SizedBox(
  height: 20,
  ),
  Center(
  child: Stack(
  children: [
  InkWell(
  onTap: () {
  showDialog(
  context: context,
  builder: (context) => PinchZoom(
  onZoomStart: () {
  print('Start Zoom');
  },
  onZoomEnd: () {
  print('End Zoom');
  },
  zoomEnabled: true,
  resetDuration:
  const Duration(milliseconds: 100),
  maxScale: 2.5,
  child: Image.network(
  state.dataModel.url,
  ),
  ),
  );
  },
  child: ClipRRect(
  borderRadius: BorderRadius.circular(30),
  child: Image.network(
  state.dataModel.mediaType =='video' ?
  state.dataModel.thumbs!:state.dataModel.url,
  width: 300,
  ),
  ),
  ),
  InkWell(
  onTap: () {
  MainCubit.get(context)
      .saveNetworkImage(state.dataModel.url);
  },
  child: const CircleAvatar(
  child: const Icon(
  Icons.save_alt_rounded,
  ),
  backgroundColor: Colors.lightBlueAccent,
  radius: 15),
  ),
  ],
  ),
  ),
  //Text(state.dataModel.title),
  SizedBox(
  height: 10,
  ),
  ExpandablePanel(
  header: Text(state.dataModel.title),
  collapsed: Text(
  state.dataModel.explanation,
  softWrap: true,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  ),
  expanded: Text(
  state.dataModel.explanation,
  softWrap: true,
  ),
  ),
  ],
  ),
),
),
);
}
return const Center(child: CircularProgressIndicator());
},
);

}

//
// BlocConsumer<MainCubit, MainStates>(
// listener: (context, state) {},
// builder: (context, state) {
// if (state is GetDataSuccess) {
// return SingleChildScrollView(
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(state.dataModel.title,
// style: Theme.of(context).textTheme.headline5),
// SizedBox(
// height: 5,
// ),
// if (state.dataModel.copyright != null)
// Text('Copyright : ${state.dataModel.copyright}'),
// SizedBox(
// height: 5,
// ),
// Text('date : ${state.dataModel.date}'),
// SizedBox(
// height: 20,
// ),
// Center(
// child: Stack(
// children: [
// InkWell(
// onTap: () {
// showDialog(
// context: context,
// builder: (context) => PinchZoom(
// onZoomStart: () {
// print('Start Zoom');
// },
// onZoomEnd: () {
// print('End Zoom');
// },
// zoomEnabled: true,
// resetDuration:
// const Duration(milliseconds: 100),
// maxScale: 2.5,
// child: Image.network(
// state.dataModel.url,
// ),
// ),
// );
// },
// child: ClipRRect(
// borderRadius: BorderRadius.circular(30),
// child: Image.network(
// state.dataModel.mediaType =='video' ?
// state.dataModel.thumbs!:state.dataModel.url,
// width: 300,
// ),
// ),
// ),
// InkWell(
// onTap: () {
// MainCubit.get(context)
//     .saveNetworkImage(state.dataModel.url);
// },
// child: const CircleAvatar(
// child: const Icon(
// Icons.save_alt_rounded,
// ),
// backgroundColor: Colors.lightBlueAccent,
// radius: 15),
// ),
// ],
// ),
// ),
// //Text(state.dataModel.title),
// SizedBox(
// height: 10,
// ),
// ExpandablePanel(
// header: Text(state.dataModel.title),
// collapsed: Text(
// state.dataModel.explanation,
// softWrap: true,
// maxLines: 2,
// overflow: TextOverflow.ellipsis,
// ),
// expanded: Text(
// state.dataModel.explanation,
// softWrap: true,
// ),
// ),
// ],
// ),
// ),
// );
// }
// return const Center(child: CircularProgressIndicator());
// },
// ),
