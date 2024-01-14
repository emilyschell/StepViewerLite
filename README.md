# StepViewerLite
## _View your steps, and that's it_

StepViewerLite is a demo iPhone app in Swift and SwiftUI, using Apple's CMPedometer library and XCTest for unit testing.

## Features

- Access your device's motion data to show this week's steps at a glance
- Load demo data if used on a simulator or unable to access device's steps
- Tap any day of the week for a closer analysis of that day's steps

Some areas I would improve in this app in the future or if doing it again:

- Do a better job of dependency injection to facilitate better unit testing coverage
- Example: refactor WeeklyViewModel to take CMPedometer as an argument, pass in through app component, mock CMPedometer in unit tests and verify called and data retrieved correctly
- Write out test demo data for DetailViewTests so that test is less tightly coupled with DemoData class
- Handle case with denied permissions gracefully (inform user and load demo data)
- Break more of the View logic into smaller re-usable components (eg. a "daily steps row", "detail view row" etc.)
- Have a repository for holding steps data and possibly retrieve data more efficiently from CMPedometer
- Move bar chart out of list (figure out how to scroll outer view with a nested list)
- Add splash screen/loading indicators
- Improve UI/styling
- Better organize file structure
- Use Swift SnapshotTesting and ViewInspector libraries to add UI tests verifying all expected components are rendered


## Installation

Open this project in Xcode and run to an iPhone simulator or device.
