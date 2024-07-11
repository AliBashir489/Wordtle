Wordtle 🐢 

Wordtle is a word guessing game built using SwiftUI for iOS, inspired by the NYT Wordle game.

Description

Wordtle challenges players to guess a hidden word of a specified length by selecting letters from a virtual keyboard and receiving feedback on their guesses.


Features

- User Accounts and Data (with Firebase) Creating Accounts and Logging In. 
- Level Selection: Choose the length of the word to guess from a range of options (4 to 8 characters).
- Gameplay Grid: Interactive grid where players input their guesses.
- Feedback System: Colors indicate correct, incorrect, and partially correct guesses.
- Keyboard Input: Virtual keyboard for selecting letters, including Enter and Backspace functionality.


Technologies Used

SwiftUI: Used for building the user interface components.
State Management: Utilizes @State and @Binding for managing local state changes and data flow within views.
Custom Views: Implements custom views like GridView for displaying the game grid and KeyboardView for interactive letter selection.

Installation

Clone the repository.
Open the project in Xcode.
Run the project on a simulator or a physical device running iOS 14.0 or later.

Usage

- Launch the app.
- Select the desired word length, time and number of guesses in the level selection screen.
- Tap "Start Game" to begin guessing the hidden word.
- Use the virtual keyboard at the bottom to enter letters into the grid.
- Receive feedback on your guesses through colored indicators.
- Win by correctly guessing the entire word or lose after multiple incorrect attempts, within the time selected.

