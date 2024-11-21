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

*Android Studio settings have been exported and uploaded to this repository in `/academic_atlas/settings.zip`*

## Core tasks
1. Find, search, and filter locations around campus

   *Status: Half implemented*
    * Users are able to see and click on campus buildings from the home page of our app.
    * Searching and filtering are lower on our priority list, so they have not been implemented yet. These features add convenience to the app, but they are not a necessity to allow a user to find a spot, so we have not prioritized them. We have added the icons for these functions, but they are not yet functional. 
    * We would like to add connections between the map markers and the locations list, to offer alternative ways of navigating the app to users.

   *User story:* A student is looking for a place to study between classes, so open the app to see a list of buildings around campus. The markers for each building are also shown on the map. They can scroll through the list of buildings until they find one that interests them, perhaps they see on the map that it is on the way to their next class. From here, they are able to select the building.  

3. View details about a location

   *Status: Almost complete*
    * When a user selects a building from the locations list, they are brought to the location details page. From here, they are able to select a specific study space from the dropdown menu to view the crowd level, current amenities, and other information about the building and the space they are in.
    * We have created the viewmodels required to retrieve the correct data about each study space, and are now just completing the styling to display the data in an aesthetically pleasing and easy-to-understand format. 

   *User story:* When the student has found and selected a building they are interested in, they still need to check if there is actually a space that's a good fit. They need a quiet space with outlets, so they can charge their laptop before class. Using the dropdown menu, they can quickly select and check the crowd level at different places in the building, and see whether other students have recently reported that a study space is quiet. Once they have found a study space that is quiet, they can scroll down to the general amenities of a study space and see if that location has outlets at each table. Satisfied with the options at this location, the student can make their way to the study space of their choice. 
    
4. Update crowd level and available amenities

   *Status: Almost complete*  
    * From the location details page, a user can select the "Update Crowd" button at the bottom of the screen, and from there they will be taken to the form where they can update the crowd level using a slider and select additional information about the current state of a study space.
    * This page is visually complete, but we still have to connect the view model and router to update the study space model and take the user back to the location details page when they press the submit button. 


5. Favorite locations and leave reviews

   *Status: Mostly not implemented*  
    * This task was also lower on our priority list, so we have not dedicated as much time to working on it. This is because we think users will benefit more from viewing details about a location and updating the crowd level. The favorite location and leave reviews is for the more experienced Pitt student.
    * We have included a favorites star on the location list. It is a version that allows the user to click on the star, and it updates the location model. However, if we decide to connect it to our user model, we will have to edit this version. 
    * Due to the scope of the project and our priorities, we have not yet implemented any reviewing capabilities. 

## Project changes
Our project has not meaningfully deviated since DEV-2 in terms of our goals. However, as we have began implementation we have realized that additional viewmodels and widgets are required to efficiently build the pages and connect the views and models. 

We have primarily been setting up models, viewmodels, and implementing providers and routing so far, so that the groundwork has been done for us to easily create our views. 

We also are changing the way notifications work in our app. Originally, we wanted to have the application notify users when they are near a location to remind them to update the crowd level. After some thought, we decided that we need to rethink this feature because not all users will appreciate this reminder. We are considering allowing the user to decide whether they would like these reminders or not instead of just assuming they would like them automatically. 
