//
//  MainViewModelTests.swift
//  VendorTests
//
//  Created by Dmytro Besedin on 14.12.2023.
//

import XCTest
@testable import Vendor

final class MainViewModelTests: XCTestCase {
    private var mockVendorAPIService: MockVendorAPIService!
    private var sut: MainViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockVendorAPIService = MockVendorAPIService()
        sut = MainViewModel(vendorAPIService: mockVendorAPIService)
    }

    override func tearDownWithError() throws {
        mockVendorAPIService = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testGetBundlePath_WithForResourceIsAppleAndOfTypeIsJson_shouldThrowInvalidBundlePathError() {
        var thrownError: Error?
        let errorHandler = { thrownError = $0 }

        do {
            let _ = try sut.vendorAPIService.getBundlePath(forResource: "apple", ofType: "json")
        } catch {
            errorHandler(error)
        }

        XCTAssertEqual(thrownError as? VendorAPIError, .invalidBundlePath, "Expected throw error when get a wrong resource")
        XCTAssertFalse(mockVendorAPIService.isGetBundlePathMethodCalled, "When the resource and the type are anything apart from vendors.json accordingly, the getBundlePath() should throw error")
    }

    func testGetBundlePath_WithForResourceIsVendorsAndOfTypeIsJson_shouldReturnVendorsPath() {
        var resultBundlePath: String?
        let resultHandler = { resultBundlePath = $0 }

        do {
            let result = try sut.vendorAPIService.getBundlePath(forResource: "vendors", ofType: "json")
            resultHandler(result)

        } catch {
            XCTAssertNil(error)
        }

        XCTAssertEqual(resultBundlePath, "/Vendor.app/vendors.json", "Expected return vendors when get a right resource")
        XCTAssertTrue(mockVendorAPIService.isGetBundlePathMethodCalled, "When resource and the type are vendors, json accordingly, the getBundlePath() should be called.")
    }

    func testGetBundlePath_WithForResourceIsVendorsOfTypeIsPng_shouldThrowInvalidBundlePathError() {
        var thrownError: Error?
        let errorHandler = { thrownError = $0 }

        do {
            let _ = try sut.vendorAPIService.getBundlePath(forResource: "vendors", ofType: "png")

        } catch {
            errorHandler(error)
        }

        XCTAssertEqual(thrownError as? VendorAPIError, .invalidBundlePath, "Expected throw error when get a wrong type")
        XCTAssertFalse(mockVendorAPIService.isGetBundlePathMethodCalled, "When the resource and the type are anything apart from vendors.json accordingly, the getBundlePath() should throw error")
    }

    func testGetBundlePath_WithForResourceIsAppleAndOfTypeIsJpeg_shouldThrowInvalidBundlePathError() {
        var thrownError: Error?
        let errorHandler = { thrownError = $0 }

        do {
            let _ = try sut.vendorAPIService.getBundlePath(forResource: "apple", ofType: "jpeg")
        } catch {
            errorHandler(error)
        }

        XCTAssertEqual(thrownError as? VendorAPIError, .invalidBundlePath, "Expected throw error when get a wrong resource and a wrong type")
        XCTAssertFalse(mockVendorAPIService.isGetBundlePathMethodCalled, "When the resource and the type are anything apart from vendors.json accordingly, the getBundlePath() should throw error")
    }

    func testGetData_WithPathIsCarsJsonPath_shouldThrowInvalidDataError() {
        var thrownError: Error?
        let errorHandler = { thrownError = $0 }

        do {
            _ = try sut.vendorAPIService.getData("/Vendor.app/cars.json")
        } catch  {
            errorHandler(error)
        }

        XCTAssertEqual(thrownError as? VendorAPIError, .invalidData, "Expected throw error when get a wrong path")
        XCTAssertFalse(mockVendorAPIService.isGetDataMethodCalled, "When the bundle path is anything apart from /Vendor.app/cars.json, the getData() should throw error")
    }

    func testGetData_WithPathIsVendorsJsonPath_shouldReturnData() {
        var resultData: Data?
        let resultHandler = { resultData = $0 }

        do {
            let result = try sut.vendorAPIService.getData("/Vendor.app/vendors.json")
            resultHandler(result)
        } catch {
            XCTAssertNil(error)
        }

        XCTAssertEqual(resultData, jsonDataExample(), "Expected return vendors data")
        XCTAssertTrue(mockVendorAPIService.isGetDataMethodCalled, "When the bundle path is /Vendor.app/cars.json, the getData() should be called.")
    }


    func testFetchVendors_WithForResourceIsCarsAndOfTypeIsJson_shouldThrowInvalidBundlePathError() async {
        let expectation = expectation(description: "testFetchVendors")
        var thrownError: Error?
        let errorHandler = { thrownError = $0 }

        mockVendorAPIService.forResource = "cars"
        mockVendorAPIService.ofType = "json"

        Task {
            do {
                let _ = try await sut.vendorAPIService.fetchVendors()
            } catch  {
                errorHandler(error)
            }
            expectation.fulfill()
        }
        
        await waitForExpectations(timeout: 1)

        XCTAssertEqual(thrownError as? VendorAPIError, .invalidBundlePath, "Expected throw when get a wrong resource")
        XCTAssertFalse(mockVendorAPIService.isFetchVendorsMethodCalled, "When the resource and the type are anything apart from vendors.json accordingly, the fetchVendors() should throw error")
    }

    func testFetchVendors_WithForResourceIsVendorsAndOfTypeIsJsson_shouldThrowInvalidBundlePathError() async {
        let expectation = expectation(description: "testFetchVendors")
        var thrownError: Error?
        let errorHandler = { thrownError = $0 }

        mockVendorAPIService.forResource = "vendors"
        mockVendorAPIService.ofType = "jsson"

        Task {
            do {
                let _ = try await sut.vendorAPIService.fetchVendors()
            } catch  {
                errorHandler(error)
            }
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 1)

        XCTAssertEqual(thrownError as? VendorAPIError, .invalidBundlePath, "Expected throw when get a wrong type")
        XCTAssertFalse(mockVendorAPIService.isFetchVendorsMethodCalled, "When the resource and the type are anything apart from vendors.json accordingly, the fetchVendors() should throw error")
    }

    func testFetchVendors_WithForResourceIsVendorsAndOfTypeIsJson_shouldReturnVendors() async {
        let expectation = expectation(description: "testFetchVendors")
        var resultVendors: [Vendor]?
        let resultHandler = { resultVendors = $0 }

        mockVendorAPIService.forResource = "vendors"
        mockVendorAPIService.ofType = "json"

        Task {
            do {
                let result = try await sut.vendorAPIService.fetchVendors()
                resultHandler(result)
            } catch  {
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }

        await waitForExpectations(timeout: 1)

        XCTAssertEqual(resultVendors?.first?.companyName, "Florists + Fashion", "Expected get array with vendors")
        XCTAssertTrue(mockVendorAPIService.isFetchVendorsMethodCalled, "When resource and the type are vendors, json accordingly, the fetchVendors() should be called.")
    }
}


