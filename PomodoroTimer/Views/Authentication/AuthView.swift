//
//  AuthView.swift
//  PomodoroTimer
//
//  Created by 渡邉雅晃 on 2023/04/07.
//

import SwiftUI

struct AuthView: View {
    @State private var currentViewShowing: String = "login"
    
    var body: some View {
        
        if(currentViewShowing == "login"){
            LoginView(currentShowingView: $currentViewShowing)
        } else {
            SignupView(currentShowingView: $currentViewShowing)
        }
        
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
