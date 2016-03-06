//
//  PerformanceTests.swift
//  Cashier
//
//  Created by Chris Combs on 06/03/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import XCTest
import Cashier

class PerformanceTests: XCTestCase {
	
	var bigModels: [PerformanceTestModel]!
	
    override func setUp() {
        super.setUp()
		
		guard let path = NSBundle(forClass: self.dynamicType).pathForResource("PerformanceTest", ofType: "json"), data = NSData(contentsOfFile: path) else {
			XCTFail("Couldn't load data from file")
			return
		}
		let jsonDict = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? NSDictionary
		bigModels = PerformanceTestModel.array(jsonDict!["data"])
		
    }
	
    func testCaching() {
        self.measureBlock {
			PersistentStore.defaultCache().setSerializable(self.bigModels, forKey: "Test")
        }
		
    }
	
	func testCashLoading() {
		self.measureBlock {
			BridgingBox.sharedBoxCache.removeAll()
			let data : [PerformanceTestModel] = PersistentStore.defaultCache().serializableForKey("Test")!
			print(data.count)
		}
		
		
	}
	
    
}
