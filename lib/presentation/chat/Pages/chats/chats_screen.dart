import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import '../../../../Widgets/custom_image_view.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../Model/ChatModel.dart';
import '../chat_room/chat_room_page.dart';
import 'chats_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ChatsScreen extends StatefulWidget {
  ChatsScreen({Key? key, required this.chatmodels,}) : super(key: key);
  final List<ChatModel> chatmodels;

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {



  ChatScreenController controller = Get.put(ChatScreenController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getchats();

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
                appBar: messageAppbar(context: context,title: "Messages".tr,showImage: true,imagepath: null,back: false),
                body:  Obx(
                      () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator(
                      ),)
                      : controller.chatsModel.chats!.length==0 ? const Center(child: Text("No Chats Found"),) : ListView.builder(
                  itemCount: controller.chatsModel.chats!.length,
                  itemBuilder: (context, index) => customCard(index),
                ),
              ),
      ),
    );
  }

  Widget customCard(int  index){
   int indexxx =  "${controller.chatsModel.chats![index].participants![0].id}" == PrefUtils().getUserId() ? 1 : 0 ;

    return InkWell(
      onTap: () {
        Get.to( ()=>ChatRoomPage(participant:controller.chatsModel.chats![index].participants![indexxx], chatId: controller.chatsModel.chats![index].id.toString(),));
      },
      child: Column(
        children: [
          ListTile(
            leading: CustomImageView(
              radius: BorderRadius.circular(30),
               height: 55,
               width: 55,
             imagePath: controller.chatsModel.chats![index].participants![indexxx].avatarUrl,
              fit: BoxFit.cover,
            ),
            title: Text(
             "${controller.chatsModel.chats![index].participants![indexxx].fullName}".capitalizeFirst!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [

                 if(controller.chatsModel.chats![index].unreadCount == 0)if(controller.chatsModel.chats![index].lastMessage?.content != null)const Icon(Icons.done_all),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  controller.chatsModel.chats![index].lastMessage?.content ?? "",
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(DateFormat('hh:mm a').format(controller.chatsModel.chats![index].lastMessage?.createdAt!.toLocal() ?? DateTime.now()),),
                const SizedBox(height: 8,),
                if(controller.chatsModel.chats![index].unreadCount != 0)Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyColor.primaryColor
                      ),
                      child: Center(child: Padding(
                        padding: const EdgeInsets.only(top: 4.0,bottom: 4,left: 9,right: 9),
                        child: Text("${controller.chatsModel.chats![index].unreadCount}" , style: TextStyle(fontSize: 12.adaptSize,color: Colors.white),),
                      )),
                    ),
                  ],
                )

              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

}
