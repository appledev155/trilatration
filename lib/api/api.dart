import 'package:trilateration/repository/repository.dart';

class ApiProvider extends Repository{

  Future<dynamic> fetchData() async {
    print("=================================={}");
    final resultData =await requestGET(path: "devices");
    return resultData;
  }

}