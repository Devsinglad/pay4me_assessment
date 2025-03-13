import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pay4me_assessment/provider/toggle_provider.dart';
import 'package:pay4me_assessment/views%20/community_screen.dart';
import 'package:pay4me_assessment/views%20/components/post_modal.dart';

class MockPostModal extends StatelessWidget {
  const MockPostModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Mock Post Modal');
  }
}

void main() {
  testWidgets('CommunityScreen FloatingActionButton test',
      (WidgetTester tester) async {
    // Build the CommunityScreen widget wrapped in a ProviderScope
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: CommunityScreen(),
        ),
      ),
    );

    /// this Verify that the FloatingActionButton exists
    expect(find.byType(FloatingActionButton), findsOneWidget);

    /// Tap the FloatingActionButton
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    /// Verify that the bottom sheet is shown
    expect(find.byType(PostModal), findsOneWidget);

    /// finding specific text or buttons inside the PostModal
    expect(find.text('Post'), findsOneWidget);

    /// Find and tap the close button
    await tester.tap(find.byKey(Key('close')));
    await tester.pumpAndSettle();

    /// Verify the modal is closed
    expect(find.byType(PostModal), findsNothing);
  });

  testWidgets('Search functionality test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: CommunityScreen(),
        ),
      ),
    );

    /// Find the search field
    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    /// Enter text in the search field
    await tester.enterText(searchField, 'Sweden');
    await tester.pump();

    await tester.pumpAndSettle();

    /// Look specifically for the list tile with Sweden text
    final swedenListTile = find.widgetWithText(ListTile, 'Sweden');
    expect(swedenListTile, findsOneWidget);
  });

  testWidgets('TabChip toggle test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: CommunityScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final initialToggleState =
        tester.state<ConsumerState>(find.byType(CommunityScreen));
    final initialTabIndex = initialToggleState.ref.read(toggleProviderProvider);
    expect(initialTabIndex, 0);

    final secondTab = find.byKey(ValueKey('tab_1'));
    expect(secondTab, findsOneWidget);

    await tester.tap(secondTab);
    await tester.pumpAndSettle();

    final toggleState =
        tester.state<ConsumerState>(find.byType(CommunityScreen));
    final tabIndex = toggleState.ref.read(toggleProviderProvider);
    expect(tabIndex, 1);
  });
}
