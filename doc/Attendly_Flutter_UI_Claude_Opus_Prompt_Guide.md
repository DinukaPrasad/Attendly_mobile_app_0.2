# Attendly Mobile App

## Claude Opus--Optimized Prompt Guide

### (Flutter UI-Only Implementation -- Final Year Project)

------------------------------------------------------------------------

# HOW TO USE THIS FILE

Copy each section step-by-step into Claude Opus while implementing.
Claude should generate UI-only Flutter code.

STRICT RULES FOR CLAUDE: - UI ONLY - NO backend logic - NO API calls -
NO authentication logic - Logic files must contain comments only (no
implementation) - Use clean, readable Flutter code - Follow Material 3
design - Keep code simple and academic-level

------------------------------------------------------------------------

# MASTER CONTEXT PROMPT (Paste First)

You are a Flutter expert helping build a university final year project
prototype called Attendly.

This is a UI-only project.

Rules: - Do not implement backend logic. - Do not add API calls. - Do
not implement authentication. - Create clean folder-based structure. -
Create ViewModel files but add only descriptive comments (no logic). -
Use dummy data for UI rendering. - Use Material 3. - Keep code simple
but structured. - Avoid overengineering. - Keep widgets clean and
readable.

We are building a secure university attendance system prototype.

------------------------------------------------------------------------

# STEP 1 --- PROJECT STRUCTURE

Generate folder structure under lib/:

lib/ main.dart app/ app.dart routes.dart theme.dart screens/ splash/
auth/ student/ lecturer/ profile/ widgets/ models/ data/

Do not add logic yet.

------------------------------------------------------------------------

# STEP 2 --- THEME SETUP

Generate theme.dart with: - Primary color - Background color - Material
3 enabled - ElevatedButton theme - Card theme - InputDecoration theme -
Consistent border radius

Keep it clean and modern.

------------------------------------------------------------------------

# STEP 3 --- ROUTING

Generate routes.dart using named routes.

Include: - Route constants - Route map - Comments describing future
role-based guards - No guard logic implementation

------------------------------------------------------------------------

# STEP 4 --- SPLASH SCREEN

Generate splash_screen.dart with:

UI: - Centered logo - Subtitle text - CircularProgressIndicator -
Version text at bottom

Also generate splash_viewmodel.dart containing ONLY comments describing:

-   Token validation
-   Device trust check
-   Role-based routing
-   Future API call flow

No implementation.

------------------------------------------------------------------------

# STEP 5 --- LOGIN SCREEN

Generate login_screen.dart with:

UI: - Email TextField - Password TextField - Login Button - Forgot
password text - Continue button (for demo navigation)

Generate auth_viewmodel.dart with ONLY comments describing:

-   Form validation
-   API authentication
-   Token storage
-   Error handling
-   Future secure storage usage

------------------------------------------------------------------------

# STEP 6 --- ROLE SELECT SCREEN

Generate role_select_screen.dart with:

UI: - Large selectable cards: - Student - Lecturer - Admin (optional) -
Navigation on tap (UI only)

------------------------------------------------------------------------

# STEP 7 --- STUDENT SCREENS

Generate:

1)  student_home_screen.dart
    -   Greeting
    -   Today's sessions list
    -   Status chips
    -   View details button
2)  timetable_screen.dart
    -   Week/List toggle
    -   Grouped session list
    -   Filter chips
3)  session_details_screen.dart
    -   Session info card
    -   Eligibility checks block (UI only)
    -   Start Check-in button
4)  checkin_wizard_screen.dart
    -   Stepper UI
    -   Steps: Time Check Location Check WiFi Check Face/Liveness (mock
        UI) Confirm
    -   UI only
5)  attendance_history_screen.dart
    -   Filter dropdown
    -   List of past records
    -   Bottom sheet details

------------------------------------------------------------------------

# STEP 8 --- LECTURER SCREENS

Generate:

1)  lecturer_sessions_screen.dart
    -   Module dropdown
    -   Session list
    -   Open/Close buttons (UI only)
2)  live_attendance_screen.dart
    -   Summary counters
    -   Search field
    -   Student list
    -   Status chips

------------------------------------------------------------------------

# STEP 9 --- PROFILE SCREEN

Generate profile_screen.dart with:

-   User info card
-   Programme display
-   Trusted device status (UI)
-   Settings toggles
-   Logout button

------------------------------------------------------------------------

# STEP 10 --- REUSABLE WIDGETS

Generate reusable widgets:

-   attendly_app_bar.dart
-   attendly_button.dart
-   attendly_card.dart
-   status_chip.dart
-   empty_state.dart

Keep them clean and reusable.

------------------------------------------------------------------------

# STEP 11 --- MODELS

Generate simple model classes:

-   user_model.dart
-   session_model.dart
-   attendance_model.dart

Only include fields necessary for UI rendering.

------------------------------------------------------------------------

# STEP 12 --- DUMMY DATA

Generate dummy_data.dart containing:

-   List of sample sessions
-   List of attendance records
-   List of students (for lecturer screen)

No network calls.

------------------------------------------------------------------------

# FINAL RESULT EXPECTATION

After completing all steps, the app should:

-   Be fully navigable
-   Contain realistic UI
-   Look professional
-   Be ready for demo
-   Be suitable for screenshots in dissertation

No backend logic implemented.

------------------------------------------------------------------------

End of Claude Opus Optimized Prompt Guide.
