import 'package:chatgpt_powered_chatbot/core/api_service.dart';
import 'package:chatgpt_powered_chatbot/core/toast.dart';
import 'package:chatgpt_powered_chatbot/domain/chat_gpt_domain.dart';
import 'package:chatgpt_powered_chatbot/domain/message_model.dart';

class ChatGptInfrastructure extends ChatGptDomain {
  final ApiService apiService;
  ChatGptInfrastructure({required this.apiService});
  @override
  Future<MessageModel?> getResponse(String text) async {
    try {
      String? msg = await apiService.sendMessage(text);
      if (msg != null) {
        return MessageModel(
            message: msg.replaceFirst("\n\n", ""), isUser: false);
      }

      return null;
    } catch (e) {
      ToastMessage.error("error occured => $e");
      return null;
    }
  }
}
