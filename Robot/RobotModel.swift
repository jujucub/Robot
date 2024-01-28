//
//  RobotModel.swift
//  Robot
//
//  Created by Hisaki Sato on 2023/12/29.
//

import Foundation
import llmfarm_core

public class RobotModel: ObservableObject {
    
    public class Message : Identifiable {
        public var time: Double = 0
        public var text: String = ""
    }
    
    private var _ai: AI? = nil
    private var _messages: [Message] = []
    public var messages: [Message] { get { return _messages } }
    @Published public var latestText:String = ""

    init() {
        guard let modelPath = Bundle.main.path(forResource: "calm2-7b-chat.Q2_K", ofType: "gguf") else { return }
        _ai = .init(_modelPath:modelPath, _chatName: "Robot")
    }
    
    public func send(_ input:String) async throws -> Message {
        
        if _ai?.model == nil {
            guard (try? _ai?.loadModel(.LLama_gguf)) != nil else { return .init() }
        }
        
        let message = Message()
        return try await withCheckedThrowingContinuation{ continuation in
            _ai?.conversation("USER:\(input)\nASSISTANT:") { text, time in
                print("continuatio:", text)
                self.latestText.append(text)
                message.text.append(text)
                message.time += time
            } _: { text in
                message.text = text
                self.latestText = ""
                self._messages.append(message)
                continuation.resume(returning: message)
                print("complete \(text)")
            }
        }
    }
}
