//
//  StepViewerLiteTests.swift
//  StepViewerLiteTests
//
//  Created by Emily Schell on 1/12/24.
//

import XCTest
@testable import StepViewerLite

final class WeeklyViewModelTests: XCTestCase {
    private var viewModel: WeeklyViewModel = WeeklyViewModel()
    
    func testStepsDataStartsEmpty() {
        XCTAssert(viewModel.stepsData == [])
    }
    
    func testUsingDemoDataStartsFalse() {
        XCTAssert(viewModel.usingDemoData == false)
    }
    
    func testGetStepsFuncGetsDemoData()  {
        viewModel.getSteps()
        XCTAssert(viewModel.usingDemoData == true)
        XCTAssert(viewModel.stepsData != [])
        XCTAssert(viewModel.stepsData[0].numberOfSteps == 5878)
    }
}
