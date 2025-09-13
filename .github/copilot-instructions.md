# Uni-Option Flutter App - AI Coding Agent Instructions

## Project Overview

Uni-Option is a Flutter mobile app providing a centralized University Information and Application Portal for Pakistani universities. The app uses Provider state management, Supabase backend, and Material 3 design with Pakistani-themed green color scheme.

## Architecture Patterns

### State Management - Provider Pattern

- **Primary Provider**: `UniversityProvider` in `lib/providers/university_provider.dart`
  - Manages university data fetching from Supabase
  - Handles favorites persistence via SharedPreferences
  - Implements search/filtering logic
  - Notification integration for user actions
- **Theme Provider**: `ThemeProvider` for light/dark mode switching
- **Setup**: MultiProvider configured in `main.dart` with both providers

### Data Layer Structure

- **Models**: Located in `lib/models/` - use factory constructors for JSON parsing
  - `University` model: Complex nested structure with degrees and application steps
  - Defensive JSON parsing with null safety and type checking
  - Fallback values for missing fields (e.g., `programs` derived from degrees)
- **Data Source**: `lib/data/universities_data.dart` contains static fallback data
- **Backend**: Supabase integration with PostgreSQL queries in `UniversityProvider`

### UI Architecture

- **Navigation**: Named routes in `main.dart` with argument passing via `ModalRoute.of(context)!.settings.arguments`
- **Screens**: Feature-based organization in `lib/screens/`
  - Separate admin panel with login (`screens/admin/`)
  - University detail screen receives University object as route argument
- **Widgets**: Reusable components in `lib/widgets/`
  - `MainDrawer`: Navigation drawer with theme switching
  - Custom widgets follow Material 3 design patterns

### Theme System (`lib/utils/theme.dart`)

- **Custom Color Palette**: Pakistani flag-inspired greens
  - Primary: `#01411C` (Dark green)
  - Secondary: `#00A86B` (Medium green)
  - Accent: Gold `#F8C100` for achievements
- **Typography**: Google Fonts (Montserrat headers, Lato body text)
- **Material 3**: Full Material 3 theming with light/dark variants

## Key Integration Points

### Supabase Backend

- **Configuration**: Keys in `main.dart` (replace with environment variables in production)
- **Data Fetching**: Complex joins with `universities`, `degrees`, and `application_steps` tables
- **Query Pattern**: `.select('*, degrees(*), application_steps(*)')` for nested data

### Notifications

- **Service**: `NotificationService` singleton using flutter_local_notifications
- **Integration**: Provider actions trigger notifications (favorites, unfavorites)
- **Setup**: Initialize in `main.dart` before app launch

### Persistence

- **SharedPreferences**: Used for favorites and theme persistence
- **Pattern**: JSON encoding/decoding of complex objects in `UniversityProvider`

## Development Conventions

### File Organization

```
lib/
├── main.dart              # App entry, providers, routes
├── models/               # Data models with JSON serialization
├── providers/           # State management (Provider pattern)
├── screens/            # Feature-based screen organization
├── widgets/           # Reusable UI components
├── services/         # External service integrations
├── utils/           # Utilities (theme, constants)
└── data/           # Static/fallback data
```

### Coding Patterns

- **JSON Parsing**: Always include null safety with fallback values
- **State Updates**: Call `notifyListeners()` after state changes in providers
- **Error Handling**: Try-catch blocks with user-friendly error messages
- **Asset Management**: University logos in `assets/images/` with pubspec.yaml registration

### UI Patterns

- **Material 3**: Use `useMaterial3: true` and new ColorScheme APIs
- **Responsive Design**: Cards with consistent margins and elevation
- **Animations**: `animations` package for shared element transitions
- **Loading States**: Boolean flags in providers with UI loading indicators

## Testing & Quality

- **Linting**: Uses `flutter_lints` package with default rules
- **Analysis**: Standard `analysis_options.yaml` configuration
- **Testing**: Basic widget tests in `test/` directory

## Common Tasks

### Adding New Universities

1. Update `universities_data.dart` with new University object
2. Ensure all required fields are populated (use existing entries as template)
3. Add university logo to `assets/images/` and update pubspec.yaml

### New Feature Screens

1. Create screen in appropriate `lib/screens/` subdirectory
2. Add route to `main.dart` routes map
3. Update `MainDrawer` navigation if needed
4. Follow existing patterns for Provider consumption

### Backend Schema Changes

1. Update model classes with new fields
2. Add defensive parsing in `fromJson` methods
3. Update Supabase queries in `UniversityProvider`
4. Test with both populated and null field scenarios

Remember: This app serves Pakistani university applicants, so maintain cultural context and regional relevance in features and content.
