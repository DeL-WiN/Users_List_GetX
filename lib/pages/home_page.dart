import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_list/api_users_controler/api_client.dart';
import 'package:users_list/widgets/widget_text.dart';
import 'second_page.dart';

class MyHomePage extends StatelessWidget {
  final ApiClientController apiController = Get.put(ApiClientController());
  final ApiUserController apiUserController = Get.put(ApiUserController());

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Users"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (apiController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            itemCount: apiController.userList.length,
            itemBuilder: (context, i) {
              if (i < apiController.userList.length - 1) {
                final user = apiController.userList;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          apiUserController.number.value = user[i].id ?? 1;
                          await apiUserController.getUser();
                          Get.to(SecondPage());
                        },
                        child: Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                user[i].avatar ?? "",
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TitleText(
                                text: user[i].firstName ?? "",
                              ),
                              const SizedBox(width: 5),
                              TitleText(text: user[i].lastName ?? ""),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SecondText(text: user[i].email ?? ""),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                apiController.fetchNextPage();
                return const SizedBox
                    .shrink(); // Пустий контейнер, якщо більше немає даних для завантаження
              }
            });
      }),
    );
  }
}
