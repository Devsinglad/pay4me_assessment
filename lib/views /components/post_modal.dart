import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils /app_colors.dart';
import '../../utils /assets/app_assets.dart';
import '../../utils /screen_utils.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/gap.dart';

class PostModal extends StatefulWidget {
  const PostModal({super.key});

  @override
  State<PostModal> createState() => _PostModalState();
}

class _PostModalState extends State<PostModal> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: bottomInset > 0 ? bottomInset + 16 : 16,
        ),
        child: SizedBox(
          height: fullHeight(context) * .4,
          width: fullWidth(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      AppAssets.cancelIcon,
                      key: Key('close'),
                    ),
                  ),
                  const TextView(
                    text: 'Cancel',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
              const Gap(20),
              Expanded(
                child: Container(
                  width: fullWidth(context),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColors.kMidGrey,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          style: const TextStyle(color: AppColors.kBlack),
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 10,
                            ),
                            prefixIcon: Visibility(
                              visible: _textController.text.isEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SvgPicture.asset(
                                  AppAssets.editOutlineIcon,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 20,
                            ),
                            hintText: "Write your post...",
                            hintStyle: const TextStyle(
                              color: AppColors.kDarkGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide:
                                  const BorderSide(color: AppColors.kMidGrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide:
                                  const BorderSide(color: AppColors.kMidGrey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide:
                                  const BorderSide(color: AppColors.kMidGrey),
                            ),
                            fillColor: AppColors.kMidGrey.withValues(alpha: .2),
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            SvgPicture.asset(AppAssets.galleryIcon),
                            Gap(20),
                            SvgPicture.asset(AppAssets.camIcon),
                            Gap(20),
                            SvgPicture.asset(AppAssets.gifIcon),
                            Gap(20),
                            SvgPicture.asset(AppAssets.alignIcon),
                            Spacer(),
                            Container(
                              height: 40,
                              width: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.kbg,
                                  borderRadius: BorderRadius.circular(15)),
                              child: TextView(
                                text: 'Post',
                                color: AppColors.kWhite,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
