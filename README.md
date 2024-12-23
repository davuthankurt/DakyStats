During development, I encountered an issue while pushing to the original repository due to a version mismatch.
To resolve this, I decided to make the original repository private and share the final version of the project in this new repository.

The app is built using the MVVM architecture, ensuring a clear separation of concerns between data, UI logic, and the user interface.

Firebase Authentication is used for user login and registration. User favorites are stored and managed via Firebase Realtime Database.

Networking tasks are handled using Alamofire. To streamline API calls and ensure type safety, a generic function was implemented. This function supports generic decoding of API responses, making it reusable across different endpoints.

To create a visually appealing and engaging user interface, the app incorporates a variety of tools and design techniques such as Stack View, Collection View Compositional and Flow layouts, Core Animation etc.
