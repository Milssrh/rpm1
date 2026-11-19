import 'package:flutter_bloc/flutter_bloc.dart';
import 'present_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesState(notes: []));

  void saveNote(String text) {
    String inputValue = text.trim();
    if (inputValue.isEmpty) return;

    List<String> currentNotes = List.from(state.notes);
    int currentEditingIndex = state.editingIndex;

    if (currentEditingIndex == -1) {
      currentNotes.add(inputValue);
    } else {
      currentNotes[currentEditingIndex] = inputValue;
      currentEditingIndex = -1;
    }

    emit(state.copyWith(notes: currentNotes, editingIndex: currentEditingIndex));
  }

  void deleteNote(int index) {
    List<String> currentNotes = List.from(state.notes);
    currentNotes.removeAt(index);

    final currentImportantNotes = state.importantNotes
        .where((importantIndex) => importantIndex != index)
        .map((importantIndex) => importantIndex > index ? importantIndex - 1 : importantIndex)
        .toSet();
    
    int currentEditingIndex = state.editingIndex;
    if (currentEditingIndex == index) {
      currentEditingIndex = -1;
    } else if (currentEditingIndex > index) {
      currentEditingIndex--;
    }

    emit(state.copyWith(
      notes: currentNotes,
      importantNotes: currentImportantNotes,
      editingIndex: currentEditingIndex,
    ));
  }

  void editNote(int index) {
    emit(state.copyWith(editingIndex: index));
  }

  void toggleImportant(int index) {
    final importantNotes = Set<int>.from(state.importantNotes);
    if (!importantNotes.add(index)) {
      importantNotes.remove(index);
    }
    emit(state.copyWith(importantNotes: importantNotes));
  }

  void clearImportant(int index) {
    if (!state.importantNotes.contains(index)) return;
    final importantNotes = Set<int>.from(state.importantNotes)..remove(index);
    emit(state.copyWith(importantNotes: importantNotes));
  }
}
