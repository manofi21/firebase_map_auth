import 'package:firebase_map_auth/model/getterSetter.dart';

class Valid {
  /*contructor untuk meminta "object" getter setter yang sama*/
  GetLoginUsersInput controllerValidation;
  Valid(this.controllerValidation);

  Function saveUsername(String name) {
    controllerValidation.email = name;
  }

  Function savePassword(String pass) {
    controllerValidation.password = pass;
  }
}
