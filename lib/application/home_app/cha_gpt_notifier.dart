import 'package:chatgpt_powered_chatbot/core/toast.dart';
import 'package:chatgpt_powered_chatbot/domain/chat_gpt_domain.dart';
import 'package:chatgpt_powered_chatbot/domain/message_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chatgpt_powered_chatbot/application/home_app/cha_gpt_stat.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ChatGptNotifier extends StateNotifier<ChatGptState> {
  final ChatGptDomain chatGptDomain;
  ChatGptNotifier({required this.chatGptDomain}) : super(ChatGptState.init());

  stateMaker(ChatGptState newState) => state = newState;

  final SpeechToText _speechToText = SpeechToText();
  TextToSpeech tts = TextToSpeech();

  addMessageForUser(MessageModel msg) {
    stateMaker(state.copyWith(messages: [...state.messages, msg]));
    loadMessageFromChatGpt(msg.message);
  }

  addMessageForBot(MessageModel msg) {
    stateMaker(state.copyWith(messages: [...state.messages, msg]));
    if (state.isSpeakEnabled) {
      speak(msg.message);
    }
  }

  speak(String text) async {
    tts.speak(text);
  }

  loadMessageFromChatGpt(String text) async {
    stateMaker(state.copyWith(isLoading: true));
    await chatGptDomain.getResponse(text).then((v) {
      if (v != null) {
        addMessageForBot(v);
      } else {
        ToastMessage.error("error occured");
      }
    });
    stateMaker(state.copyWith(isLoading: false));
  }

  startVoice() async {
    await _speechToText.initialize().then((v) {
      if (v == false) {
        ToastMessage.error(" voice Service not available");
      }
    });
    stateMaker(state.copyWith(isRecording: true));
    await _speechToText.listen(onResult: _onSpeechResult);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    stateMaker(state.copyWith(textFromMic: result.recognizedWords));
  }

  stopVoice() async {
    await _speechToText.stop();
    stateMaker(state.copyWith(
      isRecording: false,
    ));
  }

  clearText() => stateMaker(state.copyWith(textFromMic: ""));

  speakerToogle() =>
      stateMaker(state.copyWith(isSpeakEnabled: !state.isSpeakEnabled));
}
