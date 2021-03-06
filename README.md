RottenTomatoes Box Office
=========================

Time spent:  27 hours spent in total

Completed User Stories: 

- [x] Required: Can view a list of movies from Rotten Tomatoes. Poster images loaded ansync.
- [x] Required: User can view movie details by tapping on a cell
- [x] Required: User sees loading state while waiting for movies API. 
- [x] Required: User sees error message when there's a networking error. (not shown in the gif but it slides down)
- [x] Required: User can pull to refresh the movie list. 
- [x] Optional: All images fade in 
- [x] Optional: For the large poster, load the low-res image first, switch to high-res when complete
- [x] Optional: All images should be cached in memory and disk.
- [x] Optional: Customize the highlight and selection effect of the cell.
- [x] Optional: Customize the navigation bar.
- [x] Optional: Add a tab bar for Box Office and DVD.
- [x] Optional: Add a search bar.


References Used: 


  1. Install CocoaPods : https://github.com/thecodepath/ios_guides/wiki/Installing-CocoaPods
  2. Create a New Xcode Project: https://github.com/thecodepath/ios_guides/wiki/Creating-an-XCode-project
  3. Create a New View Controller: https://github.com/thecodepath/ios_guides/wiki/Introduction-to-View-Controllers
  4. Set the view controller as the root: https://github.com/thecodepath/ios_guides/wiki/Setting-the-Root-View-Controller
  5. Tab Bar Controller: https://github.com/thecodepath/ios_guides/wiki/Using-Tab-Bar-Controllers
  6. Caching: http://blog.originate.com/blog/2014/02/20/afimagecache-vs-nsurlcache/
  7. Scroll View: Create a scroll view bigger than the screen dimension, autolayout false.
  8. Array to String: http://stackoverflow.com/questions/12199619/construct-nsstring-from-the-description-method-of-each-nsarray-item


A description of the project:
Project uses Rotten Tomatoes Api to pull information about latest dvd and movies, shows it in a table View. It also has a search functionality. 

LICENSE to the repository: 

Open-Source libraries used:
  1. AFNetworking
  2. SVProgressHUD

Gif Image


![Alt Text](RottenTomatoesDemo.gif)

CodePath HW1 Rotten Tomatoes Due: June 10. 2014 10pm
