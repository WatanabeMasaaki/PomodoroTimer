//
//  MenuView.swift
//  PomodoroTimer
//
//  Created by 渡邉雅晃 on 2023/03/21.
//

import SwiftUI
import Foundation
import FirebaseAuth

struct MenuView: View {
    @AppStorage("uid") var userID: String = ""
    //日付
    @State var date = Date()
    @State var dateText = ""
    private let df = DateFormatter()
    init() {
        df.dateFormat = "MM月dd日(E) HH:mm"
        df.locale = Locale(identifier: "ja_jp")
    }
    
    //勉強時間
    @AppStorage("total_time") var totalTime = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    Text("\(userID)さん、こんにちは")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.leading, 20)
                    
                    Button(action: {
                        let firebaseAuth = Auth.auth()
                        do {
                            try firebaseAuth.signOut()
                            withAnimation {
                                userID = ""
                            }
                        } catch let signOutError as NSError {
                            print("Error signing out: %@", signOutError)
                        }
                      
                    }, label: {
                        Text("ログアウト")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .padding(.leading, 20)
                    })
                    
                    HStack {
                        Spacer()
                        
                        //日付表示
                        Text(dateText.isEmpty ? "\(df.string(from: date))" : dateText)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                    self.date = Date()
                                    dateText = "\(df.string(from: date))"
                                }
                            }
                    }
                    
                    Spacer()
                    
                    Text("総集中時間")
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                    Text("\(totalTime)")
                        .font(.system(size: 70, weight: .semibold, design: .rounded))
                        .foregroundColor(.blue)
                    Text("min")
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    NavigationLink {
                        SettingView()
                    } label: {
                        Label("勉強を始める！", systemImage: "figure.walk")
                            .font(.title)
                            .frame(width: 300, height: 70)
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.blue, lineWidth: 4))
                    }
                    
                }
            }
        }
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
