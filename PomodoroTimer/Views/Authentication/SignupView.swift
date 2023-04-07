//
//  SignupView.swift
//  PomodoroTimer
//
//  Created by 渡邉雅晃 on 2023/04/07.
//

import SwiftUI

struct SignupView: View {
    @Binding var currentShowingView: String
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                Text("会員登録")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                TextField("メールアドレス", text: $email)
                    .padding()
                
                TextField("パスワード", text: $password)
                    .padding()
                
                Button(action: {
                    withAnimation{
                        self.currentShowingView = "login"
                    }
                }, label: {
                    Text("アカウントを持っている方はこちら")
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("登録")
                        .font(.title)
                        .frame(width: 300, height: 70)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.blue, lineWidth: 4))
                })
            }
        }
    }
}

//struct SignupView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupView()
//    }
//}
