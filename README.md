# movies_app

A new Flutter project.

Project Explanations
1.	API Handling:
•	Used the Dio package for making API requests in the MovieApiClient class.
2.	Data Model:
•	Defined a Movie class in the model directory to represent movie data.
3.	Local Data Storage:
•	Implemented local data caching with Hive in the hive_database directory.
•	Created the MovieCacheData class extending HiveObject with Hive annotations.
4.	Screens:
•	Developed screens in the screens directory, e.g., MyHomeScreen , DetailScreen, videoScreen,  and BookingScreen.
•	MyHomePage fetches and caches movie data, displaying it with a clean UI.
•	VideoPlayerScreen plays YouTube videos with landscape mode support.
5.	Package Integration:
•	Integrated packages like cached_network_image for image caching, orientation for handling orientation, and youtube_player_flutter for YouTube video playback.

