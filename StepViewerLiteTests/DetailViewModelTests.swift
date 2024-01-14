//
//  DetailViewModelTests.swift
//  StepViewerLiteTests
//
//  Created by Emily Schell on 1/14/24.
//

import XCTest
@testable import StepViewerLite

final class DetailViewModelTests: XCTestCase {
    private var viewModel: DetailViewModel = DetailViewModel()

    func testCompareToAverageReturnsCorrectAboveAverageString() {
        let result = viewModel.compareToAverage(metric: 25.5, average: 50)
        XCTAssert(result == "24.50 below this week's average")
    }
    
    func testCompareToAverageReturnsCorrectBelowAverageString() {
        let result = viewModel.compareToAverage(metric: 50, average: 5)
        XCTAssert(result == "45.00 above this week's average")
    }
    
    func testMetersToMilesCalculatesCorrectly() {
        let correctValue = 0.0310685596118667
        let result = viewModel.metersToMiles(distance: 50)
        XCTAssert(result == correctValue)
    }
    
    func testSecPerMeterToMPHCalculatesCorrectly() {
        let correctValue = 3.35541
        let result = viewModel.secPerMeterToMPH(pace: 1.5)
        XCTAssert(result == correctValue)
    }
}
