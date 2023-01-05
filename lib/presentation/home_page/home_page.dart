import 'package:chatgpt_powered_chatbot/dependency_injection.dart';
import 'package:chatgpt_powered_chatbot/domain/message_model.dart';
import 'package:flutter/material.dart';
import 'package:chatgpt_powered_chatbot/presentation/home_page/widgets/chat_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  HomePage({super.key});

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  _scrollAnimation() => Future.delayed(
      const Duration(milliseconds: 300),
      () => _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatGptnotifierProvider);
    final controller = ref.read(chatGptnotifierProvider.notifier);

    ref.listen(
        chatGptnotifierProvider,
        (p, n) => {
              _messageController.text = n.textFromMic,
              if (p!.messages.length < n.messages.length) {_scrollAnimation()}
            });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat GPT Powered Bot'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: IconButton(
              onPressed: () => controller.speakerToogle(),
              icon: Icon(
                state.isSpeakEnabled ? Icons.volume_up : Icons.volume_off,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              // do something
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  return chatMessageModel(
                    msg: state.messages[index].message,
                    isUser: state.messages[index].isUser,
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter message',
                    ),
                  ),
                ),
                if (!state.isLoading)
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          _scrollAnimation();
                          controller.addMessageForUser(MessageModel(
                              message: _messageController.text, isUser: true));
                          controller.stopVoice();
                          controller.clearText();
                          _messageController.text = "";
                          _messageController.clear();
                          _scrollAnimation();
                        },
                      ),
                      if (!state.isRecording)
                        IconButton(
                          icon: const Icon(Icons.mic_sharp),
                          onPressed: () => controller.startVoice(),
                        )
                      else
                        GestureDetector(
                          onTap: () => controller.stopVoice(),
                          onDoubleTap: () => controller.stopVoice(),
                          child: Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.mic_sharp),
                                onPressed: () {
                                  controller.stopVoice();
                                },
                              ),
                              const SizedBox(
                                  height: 5,
                                  width: 15,
                                  child: LinearProgressIndicator()),
                            ],
                          ),
                        ),
                    ],
                  )
                else
                  const SizedBox(
                    height: 12,
                    width: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
