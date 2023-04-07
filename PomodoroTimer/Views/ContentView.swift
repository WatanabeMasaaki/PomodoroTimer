//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by 渡邉雅晃 on 2023/03/15.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("uid") var userID: String = ""
    
    var body: some View {
        if(userID == ""){
            LoginView()
        } else {
            MenuView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
