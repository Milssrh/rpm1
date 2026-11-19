import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('App builds without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const NotesApp());
    expect(find.text('Мои заметки'), findsOneWidget);
  });

  testWidgets('Note gestures view, mark, edit, restore and delete notes',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NotesApp());

    await tester.enterText(find.byType(TextField), 'Первая версия');
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Первая версия'));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('Заметка'), findsOneWidget);
    expect(find.text('Первая версия'), findsNWidgets(2));
    await tester.tap(find.text('Закрыть'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Первая версия'));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Первая версия'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.star), findsOneWidget);

    await tester.drag(find.text('Первая версия').first, const Offset(350, 0));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.star), findsNothing);

    await tester.longPress(find.text('Первая версия'));
    await tester.pumpAndSettle();
    expect(find.text('Обновить'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Обновленная версия');
    await tester.tap(find.text('Обновить'));
    await tester.pumpAndSettle();
    expect(find.text('Обновленная версия'), findsOneWidget);

    await tester.drag(find.text('Обновленная версия'), const Offset(-350, 0));
    await tester.pumpAndSettle();
    expect(find.text('Обновленная версия'), findsNothing);
  });
}
