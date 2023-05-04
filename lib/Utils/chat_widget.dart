import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cardsaver/constants/constants.dart';
import 'package:cardsaver/services/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/services.dart';
import 'text_widget.dart';
import 'package:intl/intl.dart';
import '../../models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../providers/add_note_cubit.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget(
      {super.key,
      required this.msg,
      required this.chatIndex,
      this.shouldAnimate = false,
      this.ques = "ChatGpt"});

  final String msg;
  final String ques;
  final int chatIndex;
  final bool shouldAnimate;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit(),
      child: BlocConsumer<AddNoteCubit, AddNoteState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              Material(
                color:
                    widget.chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        widget.chatIndex == 0
                            ? AssetsManager.userImage
                            : AssetsManager.botImage,
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: widget.chatIndex == 0
                            ? TextWidget(
                                label: widget.msg,
                              )
                            : widget.shouldAnimate
                                ? DefaultTextStyle(
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                    child: AnimatedTextKit(
                                        isRepeatingAnimation: false,
                                        repeatForever: false,
                                        displayFullTextOnTap: true,
                                        totalRepeatCount: 1,
                                        animatedTexts: [
                                          TyperAnimatedText(
                                            widget.msg.trim(),
                                          ),
                                        ]),
                                  )
                                : Text(
                                    widget.msg.trim(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                      ),
                      widget.chatIndex == 0
                          ? const SizedBox.shrink()
                          : BlocBuilder<AddNoteCubit, AddNoteState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        // await Clipboard.setData(ClipboardData(text:ques));
                                        var currentDate = DateTime.now();
                                        var formattedCurrentDate =
                                            DateFormat('dd-mm-yyyy')
                                                .format(currentDate);
                                        var noteModel = NoteModel(
                                            title: widget.ques,
                                            subTitle: widget.msg,
                                            date: formattedCurrentDate,
                                            color: Colors.red.value);
                                        BlocProvider.of<AddNoteCubit>(context)
                                            .addNote(noteModel);
                                        Fluttertoast.showToast(
                                            msg: "Chat Saved to Notes",
                                            toastLength: Toast.LENGTH_SHORT,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black54,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      },
                                      child: const Icon(
                                        Icons.copy,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                );
                              },
                            )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
