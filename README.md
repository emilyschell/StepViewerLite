# StepViewerLite
## _View your steps, and that's it_

StepViewerLite is a demo iPhone app in Swift and SwiftUI, using XCTest and Swift Snapshot Testing for unit testing.

## Features

- Access your device's motion data to show this week's steps at a glance
- Load demo data if used on a simulator or unable to access device's steps
- Tap any day of the week for a closer analysis of that day's steps

Some areas I would improve in this app in the future or if doing it again:

- Do a better job of dependency injection to facilitate better unit testing coverage
- Handle case with denied permissions gracefully (inform user and load demo data)
- Move more business logic into ViewModels and out of the Views
- Break more of the View logic into smaller re-usable components (eg. a "daily steps row", "detail view row" etc.)
- Have a repository for holding steps data and possibly retrieve data more efficiently
- Move bar chart out of list (figure out how to scroll outer view with a nested list)
- Add splash screen/loading indicators
- Improve UI/styling
- Better organize file structure


## Installation

Open this project in Xcode and run to an iPhone simulator or device.
