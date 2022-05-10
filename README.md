# Teamway Demo Quiz

A quiz app for Teamway onboarding

Taking inspiration from https://www.psychologies.co.uk/test/are-you-an-introvert-or-an-extrovert/#test

## Overview
This app is a demo quiz app designed for Teamway onboarding. It takes a few questions from [this](https://www.psychologies.co.uk/test/are-you-an-introvert-or-an-extrovert/#test) website and then generates a result at the end explaining whether the user is an introvert or an extrovert.

The app uses BLoC pattern for state management. 

The questions for the quiz are stored in assets/questions.json file and extracted at runtime.

## Questions.json

This file contains json array of questions. Each question has a list of options as multiple choice.

Each option has a text and a result of either 'introvert' or an 'extrovert' to keep track of the answers. 

To calculate the result, the answers are stored in a temporary Map in Home Bloc. The keys of this Map are the index of the questions in the questions list in quiz_repo.dart. The adjacent values are the answers that user chooses. 

## File Organisation

Within the lib folder, the following main folders are created:
- blocs
    - contains all blocs used within the app
- models
    - contains all model classes
- repositories
    - contains all data repositories and relevant API calls 
- utilities
    - contains app configuration, routing, contants, error responses and helper functions
- views
    - contains the UI of the app. If a screen has multiple components, it will have its own folder and subfiles/subfolders. Widgets that are common will be put in a separate file/folder

## File Details

### main.dart
- Repository provider and Multibloc provider is used to create respository and blocs. This helps in making sure both types of provides are available in the app files globally.
- ColorScheme is created using constant color values located in constants.dart.
- AppRouter file is used for initial route and on route generation. 

### Splash Screen and Splash Bloc
- Splash screen has simple animation to generate visual appeal.
- Splash bloc simply mocks an API call, waits for 2 seconds and navigates to home screen. In a production app, this is where perloading of any relevant data is done. 

### Home Screen and Home Bloc
- The default view on home screen is the start quiz view. It simply explains the quiz and shows a button that will trigger the quiz beginning. 
- When Start Quiz is pressed, mock API call is triggered in the quiz_repo.dart which populates questions list in the said repo. This list is used to view questions in the questions view on home screen. 
- Start Quiz indicates the bloc to begin the quiz, which changes Home screen to question view. 
- Next and previous buttons may be used to move to next question or previous one as needed. 
- When the last question is in view, Next button changes to Finish. Pressing Finish will compile the result and switch to result view. 
- The quiz can be restarted from result view. 
- If Next button is pressed without choosing an option, a warning snackbar is shown. 

### Quiz Repo
- This file contains a single function that decodes the questions from questions.json asset file and maps them into an array of Questions. 
- To mock an API call, it awaits for 1 second. 

### Question Model
- To properly integrate the questions from json into our UI, this model is used. 

### Utilities
- App Config file contains:
    - Root context (base screen context) to show snack bar. 
    - Media Query data such as device size and safe area. 
    - Text Style for global use. 
    - Confirmation, success and failure snack bars. 
- App Router gives an initial route and a function to navigate as needed throughout the app life cycle.
- Constants.dart contains all the constants used within the app, including enums. 
- Helper functions are extra functions that help with various logical flows. 
