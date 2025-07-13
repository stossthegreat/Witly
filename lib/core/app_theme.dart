class AppTheme {
  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppConstants.backgroundColor,
    primaryColor: AppConstants.accentColor,
    
    // App bar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppConstants.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    
    // Text theme
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppConstants.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppConstants.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: AppConstants.textPrimary,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppConstants.textSecondary,
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        color: AppConstants.textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
      ),
    ),
    
    // Bottom navigation theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppConstants.cardColor,
      selectedItemColor: AppConstants.accentColor,
      unselectedItemColor: AppConstants.textSecondary,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
