# Attendly Mobile App

## Flutter UI-Only Implementation Guide (Final Year Project)

------------------------------------------------------------------------

## Project Scope

This guide outlines a clean, simple, and professional Flutter UI
structure for the Attendly mobile application.

⚠️ Important Rules: - UI only (no backend logic implemented) - Logic
files may exist but must contain comments only - Clean folder structure
suitable for a university final project - Use dummy data for realistic
UI demonstration

------------------------------------------------------------------------

# Step 1 -- Folder Structure

Create this structure inside `lib/`:

    lib/
      main.dart

      app/
        app.dart
        routes.dart
        theme.dart

      screens/
        splash/
          splash_screen.dart
          splash_viewmodel.dart   // comments only
        auth/
          login_screen.dart
          role_select_screen.dart
          auth_viewmodel.dart     // comments only
        student/
          student_home_screen.dart
          timetable_screen.dart
          session_details_screen.dart
          checkin_wizard_screen.dart
          attendance_history_screen.dart
        lecturer/
          lecturer_sessions_screen.dart
          live_attendance_screen.dart
        profile/
          profile_screen.dart

      widgets/
        attendly_app_bar.dart
        attendly_button.dart
        attendly_card.dart
        status_chip.dart
        empty_state.dart

      models/
        user_model.dart
        session_model.dart
        attendance_model.dart

      data/
        dummy_data.dart

------------------------------------------------------------------------

# Step 2 -- App Theme

Create `app/theme.dart`.

Include: - Primary color - Background color - Text theme - Button
theme - Card theme - Input decoration theme

Purpose: Ensure consistent UI styling across the entire app.

------------------------------------------------------------------------

# Step 3 -- Navigation Setup

Create `app/routes.dart`.

Define: - Named routes - Route constants - Navigation table - Comments
describing future route guards

Use simple `Navigator.pushNamed()` for clarity.

------------------------------------------------------------------------

# Step 4 -- Splash Screen

File: `screens/splash/splash_screen.dart`

UI Includes: - Centered logo/title - Subtext: "Secure Attendance
System" - Circular progress indicator - App version text

Create: `splash_viewmodel.dart`

Inside viewmodel file, include comments describing: - Token validation -
Device trust check - Role-based navigation - Future API calls

No implementation code.

------------------------------------------------------------------------

# Step 5 -- Login Screen

File: `screens/auth/login_screen.dart`

UI Includes: - Email field - Password field - Login button - Forgot
password text - Continue button (for demo)

Create: `auth_viewmodel.dart`

Comments should describe: - Form validation - API authentication - Token
storage - Error handling

------------------------------------------------------------------------

# Step 6 -- Role Select Screen

File: `screens/auth/role_select_screen.dart`

UI Includes: - Student button - Lecturer button - Admin button
(optional)

Purpose: Allows demo navigation without backend.

------------------------------------------------------------------------

# Step 7 -- Student Screens

## Student Home

`screens/student/student_home_screen.dart`

Includes: - Greeting - Today's session list - Status chips - View
details button

## Timetable

`timetable_screen.dart`

Includes: - Week/List toggle - Grouped session list - Filter chips

## Session Details

`session_details_screen.dart`

Includes: - Session information - Eligibility check UI block - Start
Check-in button

## Check-in Wizard

`checkin_wizard_screen.dart`

Includes Stepper UI: 1. Time Check 2. Location Check 3. WiFi Check 4.
Face/Liveness Mock UI 5. Confirm & Submit

UI only --- no logic.

## Attendance History

`attendance_history_screen.dart`

Includes: - Filter dropdown - Past sessions list - Bottom sheet for
details

------------------------------------------------------------------------

# Step 8 -- Lecturer Screens

## Lecturer Sessions

`screens/lecturer/lecturer_sessions_screen.dart`

Includes: - Module dropdown - Session list - Open/Close buttons (UI
only)

## Live Attendance

`live_attendance_screen.dart`

Includes: - Summary counters - Search bar - Student list - Status chips

------------------------------------------------------------------------

# Step 9 -- Profile Screen

File: `screens/profile/profile_screen.dart`

Includes: - User info card - Programme info - Device trust status -
Settings toggles - Logout button

------------------------------------------------------------------------

# Step 10 -- Reusable Widgets

Create reusable components:

-   attendly_app_bar.dart
-   attendly_button.dart
-   attendly_card.dart
-   status_chip.dart
-   empty_state.dart

Purpose: Keep screens clean and reusable.

------------------------------------------------------------------------

# Step 11 -- Models

Create basic model classes:

-   user_model.dart
-   session_model.dart
-   attendance_model.dart

Only define fields necessary for UI rendering.

------------------------------------------------------------------------

# Step 12 -- Dummy Data

Create `data/dummy_data.dart`.

Include: - Sample sessions - Sample attendance records - Sample lecturer
student list

Used to populate UI.

------------------------------------------------------------------------

# Final Outcome

You will have:

-   Fully navigable Flutter UI prototype
-   Clean academic-level architecture
-   Reusable components
-   Realistic demo flow
-   Screens ready for screenshots in report

------------------------------------------------------------------------

End of Guide.
