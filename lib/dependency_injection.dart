import 'package:chatgpt_powered_chatbot/application/home_app/cha_gpt_notifier.dart';
import 'package:chatgpt_powered_chatbot/application/home_app/cha_gpt_stat.dart';
import 'package:chatgpt_powered_chatbot/core/api_service.dart';
import 'package:chatgpt_powered_chatbot/domain/chat_gpt_domain.dart';
import 'package:chatgpt_powered_chatbot/infrastructure/chat_gpt_infrastructure.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // api
  sl.registerLazySingleton<ApiService>(
    () => ApiService(),
  );

  sl.registerLazySingleton<ChatGptDomain>(
    () => ChatGptInfrastructure(apiService: sl()),
  );
}

final chatGptnotifierProvider =
    StateNotifierProvider<ChatGptNotifier, ChatGptState>((ref) {
  return ChatGptNotifier(chatGptDomain: sl());
});
