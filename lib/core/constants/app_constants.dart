// app-wide constants in one place
// avoids magic strings/numbers scattered across the codebase
class AppConstants {
  // App identity
  static const appName = 'Tasks';
  static const appVersion = '0.1.0-alpha';
  static const appBuild = '1';
  static const appTagline = 'Your tasks. Your flow.';

  // Brand
  static const brandName = 'AROICE';
  static const brandWebsite = 'https://aroice.in';

  // Developer
  static const developerName = 'Aryan Techie';
  static const developerGithub = 'https://github.com/aryan-techie';

  // how long the splash screen stays before going to home
  static const splashDuration = 2;

  // About page constants
  static const aboutVersion = 'Version $appVersion (Build $appBuild)';
  static const aboutDescription = 'A simple task manager app.';
  static const aboutLicense = 'MIT License';
}