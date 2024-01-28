//
//  RobotTests.swift
//  RobotTests
//
//  Created by Hisaki Sato on 2023/12/23.
//

import XCTest
@testable import Robot

class RobotTests: XCTestCase {

    @MainActor
    func AIChatModelSucccess() async throws {
        let model: AIChatModel = .init()
        model.model_name = "llama chat 2 7B iphone 12"
        await model.send(message: "Hello")
        Swift.print(model.messages.first?.text)
        Swift.dump(model.messages)
    }

}
