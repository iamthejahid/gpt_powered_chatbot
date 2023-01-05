import 'package:chatgpt_powered_chatbot/domain/message_model.dart';

abstract class ChatGptDomain {
  Future<MessageModel?> getResponse(String text);
}
