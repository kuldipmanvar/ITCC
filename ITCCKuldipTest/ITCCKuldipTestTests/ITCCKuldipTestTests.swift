//
//  ITCCKuldipTestTests.swift
//  ITCCKuldipTestTests
//
//  Created by Kuldip Mac on 12/01/22.
//

import XCTest
@testable import ITCCKuldipTest

class ITCCKuldipTestTests: XCTestCase {
    
    
    //MARK: email Validationtest case
    func stringCheck()  {
        var helloworls: String?
        XCTAssertNil(helloworls)
        
        helloworls = "hello world"
       // XCTAssertEqual(helloworls, "hello w")
        XCTAssertEqual(helloworls, "hello world")
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    

}
