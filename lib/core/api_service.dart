import 'dart:convert';

import 'package:chatgpt_powered_chatbot/core/toast.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = "https://api.openai.com/v1/completions";

  Map<String, String>? header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${dotenv.env['API_KEY']}',
  };

  sendMessage(String? message) async {
    try {
      var res = await http.post(
        headers: header,
        Uri.parse(baseUrl),
        body: jsonEncode({
          // The ID of the GPT-3 model to use for generating text
          "model": "text-davinci-003",
          // The text prompt to use as the starting point for generating text
          "prompt": "$message",
          // A value between 0 and 1 that controls the randomness of the generated text.
          // A temperature of 0 will produce text that is more deterministic, while a temperature of 1 will produce text that is more random.
          "temperature": 0,
          // The maximum number of tokens (words and punctuation) to generate in the response
          "max_tokens": 100,
          // A value between 0 and 1 that controls the probability of the generated tokens.
          // A value of 1 will generate text that is more likely to use the most probable tokens, while a value of 0 will generate text that is more likely to use less probable tokens.

          "top_p": 1,
          // A value between 0 and 1 that penalizes tokens that appear frequently in the generated text.
          // A value of 1 will penalize frequent tokens more heavily, while a value of 0 will not penalize them at all.
          "frequency_penalty": 0.0,
          // A value between 0 and 1 that penalizes tokens that appear frequently in the prompt.
          // A value of 1 will penalize frequent tokens more heavily, while a value of 0 will not penalize them at all.
          "presence_penalty": 0.0,
          // A list of strings that, when encountered in the generated text, will cause the text generation to stop.
          "stop": [" Human:", " AI:"],
        }),
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        var msg = data['choices'][0]['text'];

        return msg;
      }
    } catch (e) {
      ToastMessage.error(e.toString());
    }
  }
}
