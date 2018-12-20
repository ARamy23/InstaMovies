# Changelog
## Unreleased
### Added
- improve caching
- improve binding
## 0.1.5 - 2018-12-20
### Added
- fixed a typo in the readme 
## 0.1.4 - 2018-12-20
### Added
- expanding and collapsing movieCell to read more about the movie
## 0.1.3 - 2018-12-20
### Changed
- refactored ImagesManager to be more efficient with threads and less ui-blocking
## 0.1.2 - 2018-12-20
### Added
- readme file
- license file
- contributing file
- added typealias concept to use more than one name for the validators to increase code readability when writing validations function
## 0.1.1 - 2018-12-19
## Changed 
- moviePoster image setting to be the controller responsiblity since it carries too much logic for the view to handle
- moviePoster is now rounded to have some `cornerRadius`
- when cell is reused the image is set to nil
- roundImage extension function to round all corners rather than specific corners because it introduced design in-consistency
## Removed
- Camera Action from the addNewMovie module since we want the user to just select something from his gallery
## 0.1.0 - 2018-12-19
### Changed
- download images extension into an ImagesManager to download and *soft*-cache images
## 0.0.9 - 2018-12-19
### Added
- unit tests for discover module
- unit tests for addMovie module
- router mock
- set up baseModuleTest
### Changed
- router refreshing is now fully implemented
## 0.0.8 - 2018-12-18
### Added
- fix for keyboard hiding content
## 0.0.7 - 2018-12-18
### Added
- add new movie feature
- added newMovie module interactor, viewModel
- added newMovie validations
- added `isEmpty` validationError
- added a roundedTextView to accomdate overview writing
### Changed
- base interactor to allow for a non-internet dependant task while still allowing for validations
- movieCell population to load user entered image rather
- discoverTableView to display user added movies section `My Movies`
## 0.0.6 - 2018-12-18
### Added
- a fix for images not being shown correctly
## 0.0.5 - 2018-12-18
### Added
- Pagination
## 0.0.4 - 2018-12-18
### Added
- interactor layer
### Changed
- architecture to MVVM
## 0.0.3 - 2018-12-18
### Added
- activity indicator extension
- download image extension
### Changed
- finished up network layer
- finished up models
- finished up validators
- finished up routing
- designed movieCell
## 0.0.2 - 2018-12-18
### Added
- set up the foundation for the project
- added my native network layer inspired by [@yoloAbdo](https://github.com/Yoloabdo).
- set up the MVVM Pattern folder heirarchy
- set up validators
- set up error types (APIErrors and ValidationErrors)
- set up utilities
- set up router
- set up basic extensions
- set up mainTabBar
### Removed
- main storyboard 

## 0.0.1 - 2018-12-17
### Added
- Creation of project

