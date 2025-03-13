import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils /app_colors.dart';
import '../../utils /assets/app_assets.dart';
import '../../utils /screen_utils.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/gap.dart';

class CommunityPost extends StatefulWidget {
  final String username;
  final String handle;
  final String time;
  final String content;
  final int likes;
  final int comments;
  final List<String>? images;

  const CommunityPost({
    super.key,
    required this.username,
    required this.handle,
    required this.time,
    required this.content,
    required this.likes,
    required this.comments,
    this.images,
  });

  @override
  State<CommunityPost> createState() => _CommunityPostState();
}

class _CommunityPostState extends State<CommunityPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.kLightGrey)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                    AppAssets.profileImg), // Replace with actual image
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: widget.username,
                    fontWeight: FontWeight.w500,
                  ),
                  TextView(
                    text: widget.handle,
                    fontSize: 10,
                    color: AppColors.kDarkGrey,
                  ),
                ],
              ),
              Spacer(),
              TextView(text: widget.time, color: AppColors.kGrey),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  _showBottomSheet(context);
                },
                child: Icon(
                  Icons.more_horiz,
                  color: AppColors.kGrey,
                ),
              ),
            ],
          ),
          Gap(10),
          // Post Content
          TextView(
            text: widget.content,
            fontWeight: FontWeight.w100,
            fontSize: 14,
            color: AppColors.kBlackText,
            textOverflow: TextOverflow.ellipsis,
          ),
          Gap(20),
          if (widget.images != null) SizedBox(height: 10),

          // Post Images
          if (widget.images != null)
            Row(
              children: widget.images!
                  .map((img) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(img, fit: BoxFit.cover),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          Gap(10),
          // Interaction Buttons
          Row(
            children: [
              socialWidgets(icon: AppAssets.messageIcon, text: '4'),
              socialWidgets(icon: AppAssets.likeIcon, text: '89'),
              socialWidgets(icon: AppAssets.shareIcon, text: '4'),
            ],
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.kWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            height: fullHeight(context) * .4,
            width: fullWidth(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: fullWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(
                        text: 'Actions',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: SvgPicture.asset(AppAssets.cancelIcon))
                    ],
                  ),
                ),
                Gap(20),
                actionsListTile(
                    text: 'Notify Me', icon: AppAssets.notificationsIcon),
                actionsListTile(text: 'Edit Post', icon: AppAssets.editIcon),
                actionsListTile(text: 'Flag Post', icon: AppAssets.flagIcon),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget actionsListTile({text, icon}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, top: 10, bottom: 10),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            width: fullWidth(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 30, child: SvgPicture.asset(icon)),
                Gap(20),
                Align(
                  alignment: Alignment.center,
                  child: TextView(
                    text: text,
                    fontWeight: FontWeight.w500,
                    color: AppColors.kBlackText,
                  ),
                ),
                Spacer(),
                VerticalDivider(
                  width: 2,
                  thickness: 1,
                  color: AppColors.kGrey.withValues(alpha: .3),
                ),
                Gap(15),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.kGrey,
                  size: 20,
                )
              ],
            ),
          ),
          Divider(
            color: AppColors.kGrey.withValues(alpha: .2),
          )
        ],
      ),
    );
  }

  Widget socialWidgets({icon, text}) {
    return Row(children: [
      SvgPicture.asset(icon),
      Gap(5),
      TextView(
        text: text,
      ),
      Gap(15)
    ]);
  }
}
