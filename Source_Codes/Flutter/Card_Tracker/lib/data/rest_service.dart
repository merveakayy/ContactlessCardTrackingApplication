import 'package:card_tracker/model/create_user_request.dart';
import 'package:card_tracker/model/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_service.g.dart';

@RestApi()
abstract class RestService {
  factory RestService(Dio dio) = _RestService;

  @POST('https://localhost:8080/controller/user')
  Future<User> createUser(@Body() CreateUserRequest req);

  @PUT('https://localhost:8080/controller/user')
  Future<void> updateBeacons(User user);
}
