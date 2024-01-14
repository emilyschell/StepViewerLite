# StepViewerLite
## _View your steps, and that's it_

StepViewerLite is a demo iPhone app in Swift and SwiftUI, using Apple's CMPedometer library and XCTest for unit testing.

## Features

- Access your device's motion data to show this week's steps at a glance
- Load demo data if used on a simulator or unable to access device's steps
- Tap any day of the week for a closer analysis of that day's steps

### Some areas I would improve in this app in the future or if doing it again:

- Currently unit tests are written to work with the demo data that is loaded on a simulator. They will fail if the app attempts to use CMPedometer on a device. Need to pass in a bool to manually enforce using demo data, and/or mock CMPedometer class to control its data for testing. (see below re: dependency injection)
- On a physical device, loading and displaying the pedometer data is very slow and the display does not convey that data is loading
  - This was smoother when the logic to get pedometer data was inside the View before I moved it into a ViewModel. Need to work on how stepsData is updated and published to improve this.
  - Add splash screen/loading indicators to improve UI while waiting
- Do a better job of dependency injection to facilitate better unit testing coverage
  - Example: refactor WeeklyViewModel to take CMPedometer as an argument, pass in through app component, mock CMPedometer in unit tests and verify called and data retrieved correctly
 - Handle case with denied permissions gracefully (inform user and load demo data)
- Break more of the View logic into smaller re-usable components (eg. a "daily steps row", "detail view row" etc.)
- Write out test demo data for DetailViewTests so that test is less tightly coupled with DemoData class
- Move bar chart out of list (figure out how to scroll outer view with a nested list)
- Improve UI/styling
- Better organize file structure
- Use Swift SnapshotTesting and ViewInspector libraries to add UI tests verifying all expected components are rendered
- Handle rotating device orientation
- Adapt DetailView UI for dark mode (box background disappears)


## Installation

Open this project in Xcode and run to an iPhone simulator or device.
