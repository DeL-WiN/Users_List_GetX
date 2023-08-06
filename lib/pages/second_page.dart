import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_list/api_users_controler/api_client.dart';
import 'package:users_list/widgets/widget_text.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ApiUserController apiUserController = Get.put(ApiUserController());
    final data = apiUserController.userModel?.data;
    final support = apiUserController.userModel?.support;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("User"),
      ),
      body: Obx(() => apiUserController.isLoadingUser.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              data?.avatar ?? "",
                            ),
                            fit: BoxFit.fitHeight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(
                                text: "${data?.firstName}  ${data?.lastName}"),
                            SecondText(text: data?.email ?? ""),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  TitleText(text: support?.text ?? ""),
                ],
              ),
            )),
    );
  }
}
