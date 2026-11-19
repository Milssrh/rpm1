class NotesState {
  final List<String> notes;
  final Set<int> importantNotes;
  final int editingIndex;

  NotesState({
    required this.notes,
    this.importantNotes = const {},
    this.editingIndex = -1,
  });

  NotesState copyWith({
    List<String>? notes,
    Set<int>? importantNotes,
    int? editingIndex,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      importantNotes: importantNotes ?? this.importantNotes,
      editingIndex: editingIndex ?? this.editingIndex,
    );
  }
}
