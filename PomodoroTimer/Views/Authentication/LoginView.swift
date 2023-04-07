//
//  LoginView.swift
//  PomodoroTimer
//
//  Created by 渡邉雅晃 on 2023/04/07.
//

import SwiftUI

struct LoginView: View {
    @Binding var currentShowingView: String
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                Text("ログイン")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                TextField("メールアドレス", text: $email)
                    .padding()
                
                TextField("パスワード", text: $password)
                    .padding()
                
                Button(action: {
                    withAnimation{
                        currentShowingView = "signup"
                    }
                }, label: {
                    Text("アカウントを持っていない方はこちら")
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("ログイン")
                        .font(.title)
                        .frame(width: 300, height: 70)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.blue, lineWidth: 4))
                })
            }
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
