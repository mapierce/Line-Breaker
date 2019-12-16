//
//  LineBreakerTests.swift
//  LineBreakerTests
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import XCTest
@testable import LineBreaker

final class LineBreakerTests: XCTestCase {
    
    private struct Constants {

        static let funcNameOne = "func fetchCities(withAdType adType: DaftAdTypeType,someTuple t: (id: Int, name: String), adCreation: Bool, completion: @escaping (QueryAreaGroup?, _ error: APIError?) -> ()) {"
        static let funcNameTwo = "internal class func persistCustomLocations(_ customLocations: Array<CustomLocation>, url: URL? = defaultURL, completion: @escaping (_ completed: Bool) -> Void) {"
        static let funcNameThree = "func load<T>(_ resource: Resource<T>,completion: @escaping (Result<T, APIError>) -> Void) {"
        static let funcNameFour = "func presentInNewWindow(_ viewController: UIViewController,animated: Bool,completion: (() -> Void)?) {"
        static let funcNameFive = "init(withBaseURL baseURL: String, withWebService webService: WebService, withUserCredential userCredential: UserCredentialProtocol) {"
        static let chainedFunctionOne = #"    Image("turtlerock").clipShape(Circle()).overlay(Circle().stroke(Color.white, lineWidth: 4)).shadow(radius: 10)"#
        static let chainedFunctionTwo = "let dotIndexes = line.enumerated().compactMap { $0.element == Constants.dot ? $0.offset : nil }.filter { line[0..<$0].filter { $0 == Constants.openBracket }.count == line[0..<$0].filter { $0 == Constants.closedBracket }.count }.map { $0 - 1}"
        static let chainedFunctionThree = "let invokedSelectors: [Selector] = self._methodInvokedForSelector.values.filter { $0.hasObservers }.map { $0.selector }"
        static let ifLetOne = "if let errorHandler = self.errorHandler, let jsonRaw = try? JSONSerialization.jsonObject(with: data, options: []), let json = jsonRaw as? JSONDictionary, let error = errorHandler.errorFromJSONResponse(json, andRequest: resource.request, andResponse: response) {"
        static let ifLetTwo = #"if let contractType = adDictionary["contract_type"] as? Int, adType.type == DaftAdTypeCommercial {"#
        static let ifLetThree = #"if let rawJson = try? JSONSerialization.jsonObject(with: data, options: []), let json = rawJson as? JSONDictionary, let count = json["count"] as? Int, count == 0 {"#
        static let guardLetOne = "guard let searchResults = searchResults, let relativeIndexAndAdUnit = relativeIndexAndAdUnit(), paginator.currentPage < 3, Int(paginator.loadedResults - paginator.firstResultInCurrentPage) > relativeIndexAndAdUnit.index  else {"
        static let guardLetTwo = #"guard let userInfo = notification.userInfo, let id = userInfo["id"] as? Int, let type = userInfo["type"] as? String, let adType = DaftAdType(string: type), let daysLeft = userInfo["days_left"] as? Int, let index = indexOfAd(withId: id, andAdType: adType.type) else {"#
        static let guardLetThree = "guard let indexPath = indexPath, let collectionView = getCollectionViewController([fromViewController, toViewController]), let openingFrame = getConvertedRectFoIndexPath(indexPath, collectionView: collectionView)  else {"
        static let arrayOne = "let arr: [(Int, Int)] = [(1, 2), (3, 4), (5, 6),(7,8), (9,9),(0,0)]"
        static let arrayTwo = #"let arr2: [String?] = ["", "Hi, there", "", nil, "one"]"#
        static let dictOne = #"let dictOne: [String: (Int, Any)] = ["Hi": (1, 4.0), "There": (0, "hd,fsf"), "now": (2, 2), "d": (1, true)]"#
        static let dictTwo = "let dictTwo: [Int: Int] = [1: 1, 2: 2, 3: 3: 4: 4]"
        static let guardOne = "guard self.count <= maximumCharactersAllowed && self.count > 4 || somethingElse == true else {"
        static let guardTwo = #"guard funcCall() == 5 && someVal == "thisVal" || self != nil else {"#
        static let ifOne = #"if (val == 1 && otherVal == 3) || (funcCall() && otherFuncCall()) {"#
        static let ifTwo = #"if self.value != nil && thisThing > 5 {"#

    }

    var lineBreakerFactory: LineBreakerFactory!

    // MARK: - Setup and tear down

    override func setUp() {
        super.setUp()

        lineBreakerFactory = LineBreakerFactoryBase()
    }

    override func tearDown() {
        super.tearDown()

        lineBreakerFactory = nil
    }
    
    // MARK: - Unit test methods

    func testGetLineBreaker() {
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.funcNameOne) is FunctionDefinitionBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.funcNameTwo) is FunctionDefinitionBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.funcNameThree) is FunctionDefinitionBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.funcNameFour) is FunctionDefinitionBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.funcNameFive) is FunctionDefinitionBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.chainedFunctionOne) is DotSeparatorBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.chainedFunctionTwo) is DotSeparatorBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.chainedFunctionThree) is DotSeparatorBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.ifLetOne) is UnwrapBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.ifLetTwo) is UnwrapBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.ifLetThree) is UnwrapBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.ifLetThree) is UnwrapBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.guardLetOne) is UnwrapBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.guardLetTwo) is UnwrapBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.guardLetThree) is UnwrapBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.arrayOne) is ArrayBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.arrayTwo) is ArrayBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.dictOne) is DictionaryBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.dictTwo) is DictionaryBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.guardOne) is StandardGuardBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.guardTwo) is StandardGuardBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.ifOne) is StandardIfBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.ifTwo) is StandardIfBreaker)
    }
    
    func testFunctionBreaker() {
        let funcOneExpectedLine = """
            func fetchCities(withAdType adType: DaftAdTypeType,
                             someTuple t: (id: Int, name: String),
                             adCreation: Bool,
                             completion: @escaping (QueryAreaGroup?, _ error: APIError?) -> ()) {
            """
        let funcTwoExpectedLine = """
            internal class func persistCustomLocations(_ customLocations: Array<CustomLocation>,
                                                       url: URL? = defaultURL,
                                                       completion: @escaping (_ completed: Bool) -> Void) {
            """
        let funcThreeExpectedLine = """
            func load<T>(_ resource: Resource<T>,
                         completion: @escaping (Result<T, APIError>) -> Void) {
            """
        let funcFourExpectedLine = """
            func presentInNewWindow(_ viewController: UIViewController,
                                    animated: Bool,
                                    completion: (() -> Void)?) {
            """
        let funcFiveExpectedLine = """
            init(withBaseURL baseURL: String,
                 withWebService webService: WebService,
                 withUserCredential userCredential: UserCredentialProtocol) {
            """
        let breaker = FunctionDefinitionBreaker()
        let brokenLineOne = breaker.breakLine(Constants.funcNameOne)
        let brokenLineTwo = breaker.breakLine(Constants.funcNameTwo)
        let brokenLineThree = breaker.breakLine(Constants.funcNameThree)
        let brokenLineFour = breaker.breakLine(Constants.funcNameFour)
        let brokenLineFive = breaker.breakLine(Constants.funcNameFive)
        XCTAssertEqual(brokenLineOne, funcOneExpectedLine)
        XCTAssertEqual(brokenLineTwo, funcTwoExpectedLine)
        XCTAssertEqual(brokenLineThree, funcThreeExpectedLine)
        XCTAssertEqual(brokenLineFour, funcFourExpectedLine)
        XCTAssertEqual(brokenLineFive, funcFiveExpectedLine)
    }
    
    func testDotBreaker() {
        let brokenOneExpected = """
                Image("turtlerock")
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            """
        let brokenTwoExpected = """
            let dotIndexes = line
                .enumerated()
                .compactMap { $0.element == Constants.dot ? $0.offset : nil }
                .filter { line[0..<$0].filter { $0 == Constants.openBracket }.count == line[0..<$0].filter { $0 == Constants.closedBracket }.count }
                .map { $0 - 1}
            """
        let brokenThreeExpected = """
            let invokedSelectors: [Selector] = self
                ._methodInvokedForSelector
                .values
                .filter { $0.hasObservers }
                .map { $0.selector }
            """
        let breaker = DotSeparatorBreaker()
        let brokenLineOne = breaker.breakLine(Constants.chainedFunctionOne)!
        let brokenLineTwo = breaker.breakLine(Constants.chainedFunctionTwo)!
        let brokenLineThree = breaker.breakLine(Constants.chainedFunctionThree)!
        XCTAssertEqual(brokenLineOne, brokenOneExpected)
        XCTAssertEqual(brokenLineTwo, brokenTwoExpected)
        XCTAssertEqual(brokenLineThree, brokenThreeExpected)
    }
    
    func testIfLetBreaker() {
        let brokenOneExpected = """
            if let errorHandler = self.errorHandler,
                let jsonRaw = try? JSONSerialization.jsonObject(with: data, options: []),
                let json = jsonRaw as? JSONDictionary,
                let error = errorHandler.errorFromJSONResponse(json, andRequest: resource.request, andResponse: response) {
            """
        let brokenTwoExpected = """
            if let contractType = adDictionary["contract_type"] as? Int,
                adType.type == DaftAdTypeCommercial {
            """
        let brokenThreeExpected = """
            if let rawJson = try? JSONSerialization.jsonObject(with: data, options: []),
                let json = rawJson as? JSONDictionary,
                let count = json["count"] as? Int,
                count == 0 {
            """
        let brokenFourExpected = """
            guard let searchResults = searchResults,
                let relativeIndexAndAdUnit = relativeIndexAndAdUnit(),
                paginator.currentPage < 3,
                Int(paginator.loadedResults - paginator.firstResultInCurrentPage) > relativeIndexAndAdUnit.index  else {
            """
        let brokenFiveExpected = """
            guard let userInfo = notification.userInfo,
                let id = userInfo["id"] as? Int,
                let type = userInfo["type"] as? String,
                let adType = DaftAdType(string: type),
                let daysLeft = userInfo["days_left"] as? Int,
                let index = indexOfAd(withId: id, andAdType: adType.type) else {
            """
        let brokenSixExpected = """
            guard let indexPath = indexPath,
                let collectionView = getCollectionViewController([fromViewController, toViewController]),
                let openingFrame = getConvertedRectFoIndexPath(indexPath, collectionView: collectionView)  else {
            """
        let breaker = UnwrapBreaker()
        let brokenLineOne = breaker.breakLine(Constants.ifLetOne)!
        let brokenLineTwo = breaker.breakLine(Constants.ifLetTwo)!
        let brokenLineThree = breaker.breakLine(Constants.ifLetThree)!
        let brokenLineFour = breaker.breakLine(Constants.guardLetOne)!
        let brokenLineFive = breaker.breakLine(Constants.guardLetTwo)!
        let brokenLineSix = breaker.breakLine(Constants.guardLetThree)!
        XCTAssertEqual(brokenLineOne, brokenOneExpected)
        XCTAssertEqual(brokenLineTwo, brokenTwoExpected)
        XCTAssertEqual(brokenLineThree, brokenThreeExpected)
        XCTAssertEqual(brokenLineFour, brokenFourExpected)
        XCTAssertEqual(brokenLineFive, brokenFiveExpected)
        XCTAssertEqual(brokenLineSix, brokenSixExpected)
    }

}
