import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toggle_provider.g.dart';

@riverpod
class ToggleProvider extends _$ToggleProvider {
  @override
  int build() => 0;

  void toggleTab(int index) {
    state = index;
    debugPrint("Tab changed: $state");
  }
}

final postLikesProvider =
    StateNotifierProvider.family<PostLikeNotifier, (bool, int), String>(
  (ref, postId) => PostLikeNotifier(),
);

class PostLikeNotifier extends StateNotifier<(bool, int)> {
  PostLikeNotifier() : super((false, 0));

  void toggleLike(int initialLikes) {
    if (state.$1) {
      state = (false, initialLikes);
    } else {
      state = (true, initialLikes + 1);
    }
  }
}
