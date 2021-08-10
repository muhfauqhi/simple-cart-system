import 'package:dekornata_app_test/models/user.dart';

class UserDataProvider {
  Future<User> getUser() async {
    User user = User(
      0,
      'Fauqhi',
      'Perumahan Cluster Mutiara Land, Blok A No. 5, Kec. A, Kota B, Sulawesi Selatan, Indonesia',
      '081234567890',
      [],
    );
    return user;
  }
}
