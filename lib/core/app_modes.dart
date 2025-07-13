class AppMode {
  final String id;
  final String icon;
  final String label;
  final List<Color> gradientColors;
  
  const AppMode({
    required this.id,
    required this.icon,
    required this.label,
    required this.gradientColors,
  });
}

class AppModes {
  static const List<AppMode> modes = [
    AppMode(
      id: 'date',
      icon: '💖',
      label: 'Date',
      gradientColors: [Color(0xFFEC4899), Color(0xFFEF4444)],
    ),
    AppMode(
      id: 'interview',
      icon: '💼',
      label: 'Interview',
      gradientColors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
    ),
    AppMode(
      id: 'exam',
      icon: '📚',
      label: 'Exam',
      gradientColors: [Color(0xFF3B82F6), Color(0xFF10B981)],
    ),
    AppMode(
      id: 'boss',
      icon: '🔥',
      label: 'Boss',
      gradientColors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
    ),
    AppMode(
      id: 'comeback',
      icon: '⚡',
      label: 'Comeback',
      gradientColors: [Color(0xFF8B5CF6), Color(0xFFEAB308)],
    ),
  ];
  
  static AppMode getById(String id) {
    return modes.firstWhere((mode) => mode.id == id);
  }
}
