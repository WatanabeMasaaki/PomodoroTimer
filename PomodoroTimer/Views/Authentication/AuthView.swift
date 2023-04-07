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
        
        
            LoginView()
                .preferredColorScheme(.light)
        
        
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
