import 'package:daily_nasa_image/data/models/data_model.dart';

import '../../data/models/register_model.dart';

abstract class MainStates {}
class InitialState extends MainStates {}
class GetDataSuccess extends MainStates {
  final DataModel dataModel;

  GetDataSuccess(this.dataModel);

}
class GetDataError extends MainStates {
  final String error;

  GetDataError(this.error);
}
class GetDataLoading extends MainStates {}
class SaveImageSuccess extends MainStates {}
class SaveImageError extends MainStates {}

class LoginLoadingState extends MainStates {}
class LoginSuccessState extends MainStates {
  final RegisterModel registerModel;

  LoginSuccessState(this.registerModel);
}
class LoginErrorState extends MainStates {
  final String error;

  LoginErrorState(this.error);
}