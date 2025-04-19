Tip Calculator App

Overview
The Tip Calculator App is a Flutter-based mobile application designed to help users calculate tips based on a bill amount, select predefined tip percentages, or input a custom tip. Additional features include splitting the bill among multiple people, viewing a history of calculations, and a showcase view to guide new users. The app follows a clean, maintainable code structure and is hosted on Firebase Hosting. The source code is available on GitHub, and an APK file is provided for testing.
Features

Bill Amount Input: Users can input the total bill amount.
Tip Percentage Selection: Predefined tip percentages (15%, 20%, 25%) are available for quick selection.
Custom Tip: Users can input a custom tip percentage for more flexibility.
Bill Splitting: Allows users to split the total amount (including tip) among multiple people.
Recap Screen: Displays a history of previous calculations for reference.
Showcase View: A guided tour on the home screen to help new users understand the app's functionality.
Visually Appealing UI: The UI is inspired by the provided reference design, using similar color schemes, icons, and layout patterns.

Technical Details

Framework: Flutter (Dart)
State Management: StatefulWidget for managing UI updates
UI Design: Follows the referenced UI design for color scheme, icons, and layout
Hosting: Deployed on Firebase Hosting
Code Structure: Clean and maintainable with modular components
Additional Dependencies:
showcaseview: For the guided tour feature
shared_preferences: For storing calculation history locally


Usage

Home Screen:
On first launch, a showcase view highlights key features like bill input and tip selection.Currently, the showcase appears every time since the check for previous display hasn't been implemented. Task: Add logic to track and skip the showcase after the first launch.


Input Bill Amount:
Enter the total bill amount using the numeric input field.


Select Tip:
Choose a predefined tip percentage (15%, 20%, 25%) or enter a custom percentage.


Split Bill:
Specify the number of people to split the total amount (bill + tip).
The app displays the amount per person.


View Results:
The total amount (bill + tip) and per-person amount (if split) are displayed instantly.


Recap Screen:
Navigate to the recap screen to view a history of previous calculations.


Reset or Save:
Reset the inputs to start a new calculation or save the current calculation to the history.



