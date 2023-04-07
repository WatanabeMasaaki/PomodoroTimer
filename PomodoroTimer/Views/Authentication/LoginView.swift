//
//  LoginView.swift
//  PomodoroTimer
//
//  Created by 渡邉雅晃 on 2023/04/07.
//

import SwiftUI

struct LoginView: View {
    @State var currentShowingView: String = "login"
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                Text(currentShowingView == "login" ? "ログイン" : "会員登録")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                TextField("メールアドレス", text: $email)
                    .padding()
                
                TextField("パスワード", text: $password)
                    .padding()
                
                Button(action: {
                    withAnimation {
                        if(self.currentShowingView == "login") {
                            self.currentShowingView = "signup"
                        } else {
                            self.currentShowingView = "login"
                        }
                    }
                    
                }, label: {
                    Text("アカウントを持ってい\(currentShowingView == "login" ? "る" : "ない")方はこちら")
                })
                
                Text(self.currentShowingView)
                
                Spacer()
                
                Button(action: {}, label: {
                    Text(currentShowingView == "login" ? "ログイン" : "登録")
                        .font(.title)
                        .frame(width: 300, height: 70)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.blue, lineWidth: 4))
                })
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
