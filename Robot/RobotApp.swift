//
//  RobotApp.swift
//  Robot
//
//  Created by Hisaki Sato on 2023/12/23.
//

import SwiftUI

@main
struct RobotApp: App {
    
    let model: RobotModel = .init()
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
            
        }.windowStyle(.volumetric)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
