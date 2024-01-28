//
//  ContentView.swift
//  Robot
//
//  Created by Hisaki Sato on 2023/12/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State var inputText: String = ""
    @State var sending: Bool = false
    @EnvironmentObject var model: RobotModel
    
    var body: some View {
        ScrollView {
            ForEach(model.messages) { message in
                Text(message.text)
            }
            Text(model.latestText)
        }
        .frame(width: 500, height: 300)
        .padding()
        .glassBackgroundEffect()
        
        HStack {
            TextField("Message", text:$inputText)
                .padding()
            Button(action: {
                Task { @MainActor in
                    sending = true
                    try? await model.send(inputText)
                    sending = false
                }
            }, label: {
                Text("Send")
            })
            .padding()
            .disabled(sending)
        }
        .frame(width:500)
        .padding()
        .glassBackgroundEffect()
        
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
        .environmentObject(RobotModel())
}
