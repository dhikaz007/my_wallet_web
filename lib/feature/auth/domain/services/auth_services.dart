part of 'services.dart';

class AuthServices with BaseServices {
  Future<LoginModel> fetchLogin(String email, String password) async {
    try {
      Dio http = await dio();

      Response response = await http.post(
        '${UrlApp.authUrl}/token',
        queryParameters: {"grant_type": "password"},
        data: {
          "email": email,
          "password": password,
        },
        options: Options(extra: {'noAuth': true}),
      );

      final data = response.data;

      if (response.statusCode == 200) {
        final datas = LoginModel.fromJSON(data);
        print('INI DATA');
        print(datas);
        print('SAMPE SINI');
        return LoginModel.fromJSON(data);
      }

      throw 'Error in Auth';
    } on DioException catch (e) {
      throw e.toString();
    }
  }

  Future<void> fetchLogout() async {
    try {
      Dio http = await dio();

      Response response = await http.post('${UrlApp.authUrl}/logout');

      final data = response.data;

      if (response.statusCode == 204 || response.statusCode == 200) {
        print('INI DATA');
        print('Logout Success $data');
        print('SAMPE SINI');
      }

      throw 'Error in logout';
    } on DioException catch (e) {
      throw e.toString();
    }
  }
}
