//
//  LineBreakerTests.swift
//  LineBreakerTests
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import XCTest

final class LineBreakerTests: XCTestCase {
    
    private struct Constants {

        static let funcNameOne = "    func fetchCities(withAdType adType: DaftAdTypeType,someTuple t: (id: Int, name: String), adCreation: Bool, completion: @escaping (QueryAreaGroup?, _ error: APIError?) -> ()) {"
        static let funcNameTwo = "    internal class func persistCustomLocations(_ customLocations: Array<CustomLocation>, url: URL? = defaultURL, completion: @escaping (_ completed: Bool) -> Void) {"
        static let funcNameThree = "    func load<T>(_ resource: Resource<T>,completion: @escaping (Result<T, APIError>) -> Void) {"
        static let funcNameFour = "    func presentInNewWindow(_ viewController: UIViewController,animated: Bool,completion: (() -> Void)?) {"
        static let funcNameFive = "    init(withBaseURL baseURL: String, withWebService webService: WebService, withUserCredential userCredential: UserCredentialProtocol) {"
        static let funcNameSix = "static func makeGetRequest<T: Decodable>(request: APIRequest,withSuccess success: @escaping (T) -> Void,withFailure failure: @escaping (Error?) -> Void) {"
        static let funcNameSeven = "static func fetchRealtimeInfo(for stopNumbers: [String], completion: @escaping ([RealtimeResponse]?) -> Void, failure: @escaping (Error?) -> Void) {"
        static let chainedFunctionOne = #"    Image("turtlerock").clipShape(Circle()).overlay(Circle().stroke(Color.white, lineWidth: 4)).shadow(radius: 10)"#
        static let chainedFunctionTwo = "    let dotIndexes = line.enumerated().compactMap { $0.element == Constants.dot ? $0.offset : nil }.filter { line[0..<$0].filter { $0 == Constants.openBracket }.count == line[0..<$0].filter { $0 == Constants.closedBracket }.count }.map { $0 - 1}"
        static let chainedFunctionThree = "    let invokedSelectors: [Selector] = self._methodInvokedForSelector.values.filter { $0.hasObservers }.map { $0.selector }"
        static let ifLetOne = "    if let errorHandler = self.errorHandler, let jsonRaw = try? JSONSerialization.jsonObject(with: data, options: []), let json = jsonRaw as? JSONDictionary, let error = errorHandler.errorFromJSONResponse(json, andRequest: resource.request, andResponse: response) {"
        static let ifLetTwo = #"    if let contractType = adDictionary["contract_type"] as? Int, adType.type == DaftAdTypeCommercial {"#
        static let ifLetThree = #"    if let rawJson = try? JSONSerialization.jsonObject(with: data, options: []), let json = rawJson as? JSONDictionary, let count = json["count"] as? Int, count == 0 {"#
        static let guardLetOne = "    guard let searchResults = searchResults, let relativeIndexAndAdUnit = relativeIndexAndAdUnit(), paginator.currentPage < 3, Int(paginator.loadedResults - paginator.firstResultInCurrentPage) > relativeIndexAndAdUnit.index  else {"
        static let guardLetTwo = #"    guard let userInfo = notification.userInfo, let id = userInfo["id"] as? Int, let type = userInfo["type"] as? String, let adType = DaftAdType(string: type), let daysLeft = userInfo["days_left"] as? Int, let index = indexOfAd(withId: id, andAdType: adType.type) else {"#
        static let guardLetThree = "    guard let indexPath = indexPath, let collectionView = getCollectionViewController([fromViewController, toViewController]), let openingFrame = getConvertedRectFoIndexPath(indexPath, collectionView: collectionView)  else {"
        static let arrayOne = "    let arr: [(Int, Int)] = [(1, 2), (3, 4), (5, 6),(7,8), (9,9),(0,0)]"
        static let arrayTwo = #"    let arr2: [String?] = ["", "Hi, there", "", nil, "one"]"#
        static let arrayThree = #"let tokenList: [(String, TokenGenerator)] = [("^[^a-zA-Z0-9]", { Token(SingleCharacter(rawValue: $0)) }),("^@[a-zA-Z0-9]*", { .attribute($0) }),("^[a-zA-Z0-9]*", { Token(Keyword(rawValue: $0)) ?? .identifier($0) }),("[.]", { Token.identifier($0) })]"#
        static let dictOne = #"    let dictOne: [String: (Int, Any)] = ["Hi": (1, 4.0), "There": (0, "hd,fsf"), "now": (2, 2), "d": (1, true)]"#
        static let dictTwo = "    let dictTwo: [Int: Int] = [1: 1, 2: 2, 3: 3, 4: 4]"
        static let dictThree = #"    return [ "DecreaseAccess" : .decreaseAccess ,"IncreaseAccess" : .increaseAccess,"MakeAPI" : .makeAPI,"RemoveAPI" : .removeAPI,"MakePublic": .singleLevel(.public),"MakeInternal": .singleLevel(.internal),"MakePrivate": .singleLevel(.private),"MakeFileprivate": .singleLevel(.fileprivate),"Remove": .singleLevel(.remove)]"#
        static let guardOne = "    guard self.count <= maximumCharactersAllowed && self.count > 4 || somethingElse == true else {"
        static let guardTwo = #"    guard funcCall() == 5 && someVal == "thisVal" || self != nil else {"#
        static let ifOne = #"    if (val == 1 && otherVal == 3) || (funcCall() && otherFuncCall()) {"#
        static let ifTwo = #"    if self.value != nil && thisThing > 5 {"#
        static let ifThree = #"    if range.start.line == range.end.line && range.start.column == range.end.column {"#

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
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.funcNameSix) is FunctionDefinitionBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.funcNameSeven) is FunctionDefinitionBreaker)
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
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.arrayOne) is CollectionBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.arrayTwo) is CollectionBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.arrayThree) is CollectionBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.dictOne) is CollectionBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.dictTwo) is CollectionBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.dictThree) is CollectionBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.guardOne) is BooleanBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.guardTwo) is BooleanBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.ifOne) is BooleanBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.ifTwo) is BooleanBreaker)
        XCTAssertTrue(lineBreakerFactory.getLineBreaker(from: Constants.ifThree) is BooleanBreaker)
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
        let funcSixExpectedLine = """
            static func makeGetRequest<T: Decodable>(request: APIRequest,
                                                     withSuccess success: @escaping (T) -> Void,
                                                     withFailure failure: @escaping (Error?) -> Void) {
            """
        let funcSevenExpectedLine = """
            static func fetchRealtimeInfo(for stopNumbers: [String],
                                          completion: @escaping ([RealtimeResponse]?) -> Void,
                                          failure: @escaping (Error?) -> Void) {
            """
        let breaker = FunctionDefinitionBreaker()
        let brokenLineOne = breaker.breakLine(Constants.funcNameOne, tabWidth: 4)!
        let brokenLineTwo = breaker.breakLine(Constants.funcNameTwo, tabWidth: 4)!
        let brokenLineThree = breaker.breakLine(Constants.funcNameThree, tabWidth: 4)!
        let brokenLineFour = breaker.breakLine(Constants.funcNameFour, tabWidth: 4)!
        let brokenLineFive = breaker.breakLine(Constants.funcNameFive, tabWidth: 4)!
        let brokenLineSix = breaker.breakLine(Constants.funcNameSix, tabWidth: 4)!
        let brokenLineSeven = breaker.breakLine(Constants.funcNameSeven, tabWidth: 4)!
        XCTAssertEqual(brokenLineOne, funcOneExpectedLine)
        XCTAssertEqual(brokenLineTwo, funcTwoExpectedLine)
        XCTAssertEqual(brokenLineThree, funcThreeExpectedLine)
        XCTAssertEqual(brokenLineFour, funcFourExpectedLine)
        XCTAssertEqual(brokenLineFive, funcFiveExpectedLine)
        XCTAssertEqual(brokenLineSix, funcSixExpectedLine)
        XCTAssertEqual(brokenLineSeven, funcSevenExpectedLine)
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
        let brokenLineOne = breaker.breakLine(Constants.chainedFunctionOne, tabWidth: 4)!
        let brokenLineTwo = breaker.breakLine(Constants.chainedFunctionTwo, tabWidth: 4)!
        let brokenLineThree = breaker.breakLine(Constants.chainedFunctionThree, tabWidth: 4)!
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
        let brokenLineOne = breaker.breakLine(Constants.ifLetOne, tabWidth: 4)!
        let brokenLineTwo = breaker.breakLine(Constants.ifLetTwo, tabWidth: 4)!
        let brokenLineThree = breaker.breakLine(Constants.ifLetThree, tabWidth: 4)!
        let brokenLineFour = breaker.breakLine(Constants.guardLetOne, tabWidth: 4)!
        let brokenLineFive = breaker.breakLine(Constants.guardLetTwo, tabWidth: 4)!
        let brokenLineSix = breaker.breakLine(Constants.guardLetThree, tabWidth: 4)!
        XCTAssertEqual(brokenLineOne, brokenOneExpected)
        XCTAssertEqual(brokenLineTwo, brokenTwoExpected)
        XCTAssertEqual(brokenLineThree, brokenThreeExpected)
        XCTAssertEqual(brokenLineFour, brokenFourExpected)
        XCTAssertEqual(brokenLineFive, brokenFiveExpected)
        XCTAssertEqual(brokenLineSix, brokenSixExpected)
    }
    
    func testCollectionBreaker() {
        let brokenOneExpected = """
                let arr: [(Int, Int)] = [(1, 2),
                                         (3, 4),
                                         (5, 6),
                                         (7,8),
                                         (9,9),
                                         (0,0)]
            """
        let brokenTwoExpected = """
                let arr2: [String?] = ["",
                                       "Hi, there",
                                       "",
                                       nil,
                                       "one"]
            """
        let brokenThreeExpected = """
                let dictOne: [String: (Int, Any)] = ["Hi": (1, 4.0),
                                                     "There": (0, "hd,fsf"),
                                                     "now": (2, 2),
                                                     "d": (1, true)]
            """
        let brokenFourExpected = """
                let dictTwo: [Int: Int] = [1: 1,
                                           2: 2,
                                           3: 3,
                                           4: 4]
            """
        let brokenFiveExpected = """
                return [ "DecreaseAccess" : .decreaseAccess ,
                        "IncreaseAccess" : .increaseAccess,
                        "MakeAPI" : .makeAPI,
                        "RemoveAPI" : .removeAPI,
                        "MakePublic": .singleLevel(.public),
                        "MakeInternal": .singleLevel(.internal),
                        "MakePrivate": .singleLevel(.private),
                        "MakeFileprivate": .singleLevel(.fileprivate),
                        "Remove": .singleLevel(.remove)]
            """
        let brokenSixExpected = """
            let tokenList: [(String, TokenGenerator)] = [("^[^a-zA-Z0-9]", { Token(SingleCharacter(rawValue: $0)) }),
                                                         ("^@[a-zA-Z0-9]*", { .attribute($0) }),
                                                         ("^[a-zA-Z0-9]*", { Token(Keyword(rawValue: $0)) ?? .identifier($0) }),
                                                         ("[.]", { Token.identifier($0) })]
            """
        let breaker = CollectionBreaker()
        let brokenLineOne = breaker.breakLine(Constants.arrayOne, tabWidth: 4)!
        let brokenLineTwo = breaker.breakLine(Constants.arrayTwo, tabWidth: 4)!
        let brokenLineThree = breaker.breakLine(Constants.dictOne, tabWidth: 4)!
        let brokenLineFour = breaker.breakLine(Constants.dictTwo, tabWidth: 4)!
        let brokenLineFive = breaker.breakLine(Constants.dictThree, tabWidth: 4)!
        let brokenLineSix = breaker.breakLine(Constants.arrayThree, tabWidth: 4)!
        XCTAssertEqual(brokenLineOne, brokenOneExpected)
        XCTAssertEqual(brokenLineTwo, brokenTwoExpected)
        XCTAssertEqual(brokenLineThree, brokenThreeExpected)
        XCTAssertEqual(brokenLineFour, brokenFourExpected)
        XCTAssertEqual(brokenLineFive, brokenFiveExpected)
        XCTAssertEqual(brokenLineSix, brokenSixExpected)
    }
    
    func testBooleanBreaker() {
        let brokenOneExpected = """
                if (val == 1 && otherVal == 3) ||
                    (funcCall() && otherFuncCall()) {
            """
        let brokenTwoExpected = """
                if self.value != nil &&
                    thisThing > 5 {
            """
        let brokenThreeExpected = """
                if range.start.line == range.end.line &&
                    range.start.column == range.end.column {
            """
        let brokenFourExpected = """
                guard self.count <= maximumCharactersAllowed &&
                    self.count > 4 ||
                    somethingElse == true else {
            """
        let brokenFiveExpected = """
                guard funcCall() == 5 &&
                    someVal == "thisVal" ||
                    self != nil else {
            """
        let breaker = BooleanBreaker()
        let brokenLineOne = breaker.breakLine(Constants.ifOne, tabWidth: 4)!
        let brokenLineTwo = breaker.breakLine(Constants.ifTwo, tabWidth: 4)!
        let brokenLineThree = breaker.breakLine(Constants.ifThree, tabWidth: 4)!
        let brokenLineFour = breaker.breakLine(Constants.guardOne, tabWidth: 4)!
        let brokenLineFive = breaker.breakLine(Constants.guardTwo, tabWidth: 4)!
        XCTAssertEqual(brokenLineOne, brokenOneExpected)
        XCTAssertEqual(brokenLineTwo, brokenTwoExpected)
        XCTAssertEqual(brokenLineThree, brokenThreeExpected)
        XCTAssertEqual(brokenLineFour, brokenFourExpected)
        XCTAssertEqual(brokenLineFive, brokenFiveExpected)
    }

}
