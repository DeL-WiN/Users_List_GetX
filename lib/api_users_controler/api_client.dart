import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:users_list/model/user.dart';
import 'package:users_list/model/users.dart';
import 'package:users_list/providers/local_provider.dart';

class ApiClientController extends GetxController {
  final LocalProvider localProvider = LocalProvider();
  ApiClientController();
  final Dio dio = Dio();
  var isLoading = false.obs;
  int currentPage = 1;
  RxList<Datum> userList = RxList<Datum>([]);
  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      final savedData = await localProvider.getApiData();
      if (savedData != null) {
        final posts =
            Map<String, dynamic>.from(json.decode(savedData))["data"] as List;
        final addUser =
            posts.map((jsonModel) => Datum.fromJson(jsonModel)).toList();
        userList.addAll(addUser);
      } else {
        getListUsers();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchNextPage() async {
    try {
      currentPage++;
      final response =
          await dio.get("https://reqres.in/api/users?page=$currentPage");
      final getUserList = response.data['data'] as List<dynamic>;
      if (getUserList.isNotEmpty) {
        final newUsers =
            getUserList.map((userData) => Datum.fromJson(userData)).toList();
        userList.addAll(newUsers);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getListUsers() async {
    try {
      isLoading(true);
      var response =
          await dio.get("https://reqres.in/api/users?page=$currentPage");
      Map<String, dynamic> post = response.data;
      final posts = post["data"] as List;
      final addUser =
          posts.map((jsonModel) => Datum.fromJson(jsonModel)).toList();
      userList.addAll(addUser);
      final String jsonString = jsonEncode(post);
      await localProvider.saveApiData(jsonString);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}

class ApiUserController extends GetxController {
  var isLoadingUser = false.obs;
  UserModel? userModel;
  RxInt number = RxInt(0);
  @override
  Future<void> onInite() async {
    super.onInit();
  }

  Future<UserModel?> getUser() async {
    try {
      String id = number.toString();
      isLoadingUser(true);
      var response = await Dio().get("https://reqres.in/api/users/$id");
      Map<String, dynamic> post = response.data;
      userModel = UserModel.fromJson(post);
    } catch (e) {
      print(e);
    } finally {
      isLoadingUser(false);
    }
  }
}
