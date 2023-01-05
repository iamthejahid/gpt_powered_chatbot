import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chatgpt_powered_chatbot/routes/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return ScreenUtilInit(
      builder: ((_, c) => MaterialApp.router(
            routerConfig: AppRoutes.router,
            title: 'Chat GPT powered chat bot',
          )),
      designSize: const Size(187.5, 406),
    );
  }
}
