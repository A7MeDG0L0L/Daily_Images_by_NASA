import 'package:daily_nasa_image/business_logic/main_cubit/main_states.dart';
import 'package:daily_nasa_image/data/dio_helper/dio_helper.dart';
import 'package:daily_nasa_image/data/models/test_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';

import '../../data/models/data_model.dart';
import '../../data/models/register_model.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(InitialState());
  static MainCubit get(context) => BlocProvider.of(context);




  List<DataModel> data = [];
  late DataModel dataModel;
  void getData() {
    emit(GetDataLoading());
    DioHelper.dio.get('apod', queryParameters: {
      'thumbs':true,
    }).then((value) {
      //print(value);
      dataModel = DataModel.fromJson(value.data);
      print(dataModel);
      emit(GetDataSuccess(dataModel));
    });
  }
  int i= 0;

  void getNextData() {
    late String day = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().toUtc().subtract(
      Duration(days: ++i),
    ))
        .toString();
print(i);
    print(day);
    DioHelper.dio.get('apod', queryParameters: {
      'date':
          day,
       'thumbs':true,
    }).then((value) {
    //  print(value.data);
      dataModel = DataModel.fromJson(value.data);
      //print(dataModel);
      emit(GetDataSuccess(dataModel));
    });
  }



  void getPrevData() {
    late String day = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().toUtc().subtract(
      Duration(days: --i),
    ))
        .toString();
    print(i);
    print(day);
    DioHelper.dio.get('apod', queryParameters: {
      'date':
      day,
      'thumbs':true,
    }).then((value) {
     // print(value.data);
      dataModel = DataModel.fromJson(value.data);
      //print(dataModel);
      emit(GetDataSuccess(dataModel));
    });
  }

  void saveNetworkImage(String path) async {
    GallerySaver.saveImage(path).then((value) {
      emit(SaveImageSuccess());
      getData();
    }).catchError((error) {
      emit(SaveImageError());
    });
  }


  // late TestModel testModel;
  // late RegisterModel registerModel;
  // void login({required String phone,required String password,required String
  // passwrordConfrim,required String name,required String email}){
  //   emit(LoginLoadingState());
  //   dio2.post('client-register',data:{'phone':phone,'password':password,'name':name,
  //       'password':password,'password_confirmation':passwrordConfrim,'email':
  //     email} )
  //       .then(
  //           (value)
  //   {
  //     registerModel = RegisterModel.fromJson(value.data);
  //     print(registerModel);
  //     //testModel = TestModel.fromJson(value.data);
  //     //print(testModel);
  //     print(value);
  //     emit(LoginSuccessState(registerModel));
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(LoginErrorState(error.toString()));
  //   });
  // }
}
