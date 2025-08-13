part of 'services.dart';

class ProfileServices with BaseServices {
  Future<UserModel> fetchUser() async {
    try {
      Dio http = await dio();

      Response response = await http.get('${UrlApp.authUrl}/user');

      final data = response.data;

      if (response.statusCode == 200) {
        final datas = UserModel.fromJSON(data);
        print('INI DATA');
        print(datas);
        print('SAMPE SINI');
        return datas;
      }

      throw 'Error in get user';
    } on DioException catch (e) {
      throw e.toString();
    }
  }
}
