import 'package:daily_nasa_image/business_logic/main_cubit/main_states.dart';
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

  static late Dio dio;
  static late Dio dio2;

  static initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.nasa.gov/planetary/',
        receiveDataWhenStatusError: true,
      ),
    );
    dio2 = Dio(
      BaseOptions(
        baseUrl: 'http://cleaning.3m-erp.com/khadamaty/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  List<DataModel> data = [];
  late DataModel dataModel;
  void getData() {
    emit(GetDataLoading());
    dio.get('apod', queryParameters: {
      'api_key': 'BlQpLIIVzTsUEAWI5Hn7Y6cbWjT4a2OTUBDbYA9R',
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
    dio.get('apod', queryParameters: {
      'api_key': 'BlQpLIIVzTsUEAWI5Hn7Y6cbWjT4a2OTUBDbYA9R',
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
    dio.get('apod', queryParameters: {
      'api_key': 'BlQpLIIVzTsUEAWI5Hn7Y6cbWjT4a2OTUBDbYA9R',
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
  late TestModel testModel;
  late RegisterModel registerModel;
  void login({required String phone,required String password,required String
  passwrordConfrim,required String name,required String email}){
    emit(LoginLoadingState());
    dio2.post('client-register',data:{'phone':phone,'password':password,'name':name,
        'password':password,'password_confirmation':passwrordConfrim,'email':
      email} )
        .then(
            (value)
    {
      registerModel = RegisterModel.fromJson(value.data);
      print(registerModel);
      //testModel = TestModel.fromJson(value.data);
      //print(testModel);
      print(value);
      emit(LoginSuccessState(registerModel));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
