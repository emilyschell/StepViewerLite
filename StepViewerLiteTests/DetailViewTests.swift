//
//  DetailViewTests.swift
//  StepViewerLiteTests
//
//  Created by Emily Schell on 1/14/24.
//

import XCTest
@testable import StepViewerLite


final class DetailViewTests: XCTestCase {
    private var demoData: [DailyData] = DemoData().demoStepsData

    func testInitiatesAveragesCorrectly() {
        let detailView = DetailView(stepsData: demoData, selectedIndex: 0)
        
        let correctAverages = WeeklyAverages(steps: 5165.428571428572, distance: 5235.142857142857, pace: 0.6414285714285715, floorsAscended: 11.571428571428571)
        
        XCTAssert(detailView.weeklyAverages == correctAverages)
    }
}
