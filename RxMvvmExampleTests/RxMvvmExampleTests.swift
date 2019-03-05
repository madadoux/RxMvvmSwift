//
//  RxMvvmExampleTests.swift
//  RxMvvmExampleTests
//
//  Created by mhmohamed on 3/5/19.
//  Copyright © 2019 mhmohamed. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
@testable import RxMvvmExample

class RxMvvmExampleTests: XCTestCase {
    var userViewModel : UserViewModel?
    var dbag:DisposeBag = DisposeBag()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        userViewModel = UserViewModel()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    
    func testLoginEmptyUserName() {
        let user = userViewModel?.signIn(userName: "", password: "12332432")
        XCTAssert(user != nil)
    }
    
    func testLoginEmptyPassword() {
        let user = userViewModel?.signIn(userName: "user1", password: "")
        XCTAssert(user == nil)
        
    }
    
    func testLoginExistUser() {
        let user = userViewModel?.signIn(userName: "user1", password: "12345678")
        XCTAssert(user != nil)
        XCTAssert(user?.name != nil)
        
    }
    
    func testLoginNonExistUser() {
        let user = userViewModel?.signIn(userName: "user2", password: "12345678")
        XCTAssert(user != nil)
        XCTAssert(user?.name != nil)
        
    }
    
    
    func testSucessfulRegister() {
        let user = userViewModel?.signIn(userName: "user1", password: "12345678")
        XCTAssert(user != nil)
        XCTAssert(user?.name != nil)
        
    }
    
    
    
    func testChangePasswordSucessful() {
        
        if let res = userViewModel?.changePassword(userName: "user1", oldPass: "12345678", newPass: "951753"){
            
            XCTAssert(res.responceCode == 200)
            XCTAssert(res.serverCode == 1)
        }
        else {
            XCTFail()
        }
    }
    
    func testChangePasswordFailed() {
        
        if let res = userViewModel?.changePassword(userName: "user2", oldPass: "12345678", newPass: "951753"){
            
            XCTAssert(res.responceCode == 404)
            XCTAssert(res.serverCode == 0)
        }
        else {
            XCTFail()
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
