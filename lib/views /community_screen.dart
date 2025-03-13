import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pay4me_assessment/provider/search_filter.dart';
import 'package:pay4me_assessment/provider/toggle_provider.dart';
import 'package:pay4me_assessment/utils%20/app_colors.dart';
import 'package:pay4me_assessment/utils%20/assets/app_assets.dart';
import 'package:pay4me_assessment/widgets/gap.dart';

import '../widgets/custom_text.dart';
import 'components/bottom_nav_bar.dart';
import 'components/community_post.dart';
import 'components/post_modal.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final (tabIndex) = ref.watch(toggleProviderProvider);
    var filteredCountries = ref.watch(searchProviderProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              headerWidget(tabIndex),
              // Search Bar
              TextView(
                text: 'Community',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              Gap(10),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: searchController,
                  style: TextStyle(color: AppColors.kBlack),
                  onChanged: (value) {
                    ref.read(searchProviderProvider.notifier).search(value);
                  },
                  decoration: InputDecoration(
                    hintText:
                        "Search keywords like SEVIS, United States, Canada",
                    hintStyle: TextStyle(
                      color: AppColors.kDarkGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: AppColors.kMidGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: AppColors.kMidGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: AppColors.kMidGrey),
                    ),
                    fillColor: AppColors.kMidGrey.withValues(alpha: .2),
                    filled: true,
                  ),
                ),
              ),

              Gap(20),
              if (searchController.text.isNotEmpty)
                SizedBox(
                  height: 100,
                  child: filteredCountries.isEmpty
                      ? const Center(
                          child: Text(
                            "No results found",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredCountries.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(filteredCountries[index]),
                              leading: const Icon(Icons.location_on),
                            );
                          },
                        ),
                ),

              /// Content Area
              Expanded(
                child: ListView(
                  children: [
                    CommunityPost(
                      username: "Paul Adah",
                      handle: "@paulsunday",
                      time: "11:23AM",
                      content:
                          "Paul Adah What is it like to study in Orlando with their What is it like to study in Orlando with their  ",
                      likes: 89,
                      comments: 4,
                    ),
                    CommunityPost(
                      username: "Paul Adah",
                      handle: "@paulsunday",
                      time: "11:23AM",
                      content: "Paul Adah just got a new laptop, hehe.",
                      likes: 89,
                      comments: 4,
                      images: [
                        'assets/images/laptop.png',
                        'assets/images/laptop.png'
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff7AC52D),
        shape: CircleBorder(),
        onPressed: () {
          _showBottomSheet(context);
        },
        child: SvgPicture.asset('assets/svg/edit.svg'),
      ),
    );
  }

  Widget headerWidget(tabIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.kbg, width: 2),
              image: DecorationImage(
                image: AssetImage(AppAssets.profileImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(10),
          Container(
            height: 35,
            width: 80,
            decoration: BoxDecoration(
              color: AppColors.kLightGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                tabChip(
                    icon: AppAssets.houseIcon, index: 0, tabIndex: tabIndex),
                tabChip(icon: AppAssets.chatIcon, index: 1, tabIndex: tabIndex),
              ],
            ),
          ),
          Spacer(),
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.kDarkGrey,
                child: Center(
                  child: SvgPicture.asset(AppAssets.foldIcon),
                ),
              ),
              Gap(15),
              Stack(
                children: [
                  CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.kLightGrey,
                      child:
                          Icon(Icons.notifications_none, color: Colors.grey)),
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text("3",
                          style: TextStyle(fontSize: 8, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget tabChip({icon, index, tabIndex}) {
    var provider = ref.watch(toggleProviderProvider.notifier);
    return GestureDetector(
      key: ValueKey('tab_$index'),
      onTap: () {
        provider.toggleTab(index);
      },
      child: Container(
        height: 35,
        width: 40,
        decoration: BoxDecoration(
            color: tabIndex == index ? AppColors.kBlue : AppColors.kTransparent,
            borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: SvgPicture.asset(icon,
            colorFilter: ColorFilter.mode(
                tabIndex == index ? AppColors.kWhite : AppColors.kDarkGrey,
                BlendMode.srcIn)),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.kWhite,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return PostModal();
      },
    );
  }
}
