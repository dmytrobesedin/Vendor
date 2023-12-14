//
//  MockVendorAPIService.swift
//  VendorTests
//
//  Created by Dmytro Besedin on 14.12.2023.
//

import Foundation
import XCTest
@testable import Vendor

class MockVendorAPIService: VendorAPIServiceProtocol {
    // MARK: Properties
    var forResource = ""
    var ofType = ""
    
    // MARK: Private properties
    private(set) var isGetBundlePathMethodCalled = false
    private(set) var isGetDataMethodCalled = false
    private(set) var isFetchVendorsMethodCalled = false
    
    // MARK: - Methods
    func getBundlePath(forResource: String, ofType: String) throws -> String {
        guard forResource.elementsEqual("vendors") && ofType.elementsEqual("json") else {
            throw VendorAPIError.invalidBundlePath
        }
        
        isGetBundlePathMethodCalled.toggle()
        return "/Vendor.app/\(forResource).\(ofType)"
    }
    
    func getData(_ path: String) throws -> Data {
        guard path.elementsEqual("/Vendor.app/vendors.json") else {
            throw VendorAPIError.invalidData
        }
        isGetDataMethodCalled.toggle()
        return jsonDataExample()
    }
    
    func fetchVendors() async throws -> [Vendor] {
        let jsonDecoder = JSONDecoder()
        do {
            let path = try getBundlePath(forResource: forResource, ofType: ofType)
            let data = try getData(path)
            let decodeData = try jsonDecoder.decode(VendorRespond.self, from: data)
            isFetchVendorsMethodCalled = true
            return decodeData.vendors
        } catch {
            isFetchVendorsMethodCalled = false
            throw error
        }
    }
}
