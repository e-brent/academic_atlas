## How to run Pitt Academic Atlas
* IDE: Android Studio
* Flutter: 3.24.3
* Dart: 3.5.3
* Simulator Device: Medium Phone
* Simulator System Image:
  * Release Name: VanillaIceCream
  * API Level: 35
  * ABI: x86-64
  * Target: Android 15.0 (Google Play)
  * 

*Android Studio settings have been exported and uploaded to this repository in `/academic_atlas/settings.zip`*

## Core tasks
1. Find, search, and filter locations around campus

   **Status: Half implemented**
    * Users are able to see and click on campus buildings from the home page of our app.
    * Searching and filtering are lower on our priority list, as they are features that add convenience to the app, but don't change the broader use cases for the app. We have added the icons for these functions, but have not yet implemented any functionality.
    * We would like to add connections between the map markers and the locations list, to offer alternative ways of navigating the app to users.


2. View details about a location

   **Status: Almost complete**
    * When a user selects a building from the locations list, they are brought to the location details page. From here, they are able to select a specific study space from the dropdown menu to view the crowd level, current amenities, and other information about the building and the space they are in.
    * We have created the viewmodels required to retrieve the correct data about each study space, and are now just completing the styling to display the data in an aesthetically pleasing and easy to understand format. 

    
3. Update crowd level and available amenities

   **Status: Almost complete**  
    * From the location details page, a user can select the "Update Crowd" button at the bottom of the screen, and from there they will be taken to the form where they can update the crowd level using a slider and select additional information about the current state of a study space.
    * This page is visually complete, but we still have to connect the view model and router to update the study space model and take the user back to the location details page when they press the submit button. 


4. Favorite locations and leave reviews

   **Status: Mostly not implemented**  
    * This task was also lower on our priority list, so we have not yet dedicated time to working on it. 
    * We have included a favorites star on the location list, but it is not connected to the user model and nothing changes when a user presses the button. The user model and a simple user viewmodel have been created, but they have not been connected to any views yet.
    * Due to teh scope of the project and our priorities, we have not yet implemented any reviewing capabilities. 

## Project changes
Our project has not meaningfully deviated since DEV-2 in terms of our goals. However, as we have began implementation we have realized that additional viewmodels and widgets are required to efficiently build the pages and connect the views and models. 

We have primarily been setting up models, viewmodels, and implementing providers and routing so far, so that the groundwork has been done for us to easily create our views. 
