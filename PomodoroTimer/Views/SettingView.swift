//
//  SettingView.swift
//  PomodoroTimer
//
//  Created by 渡邉雅晃 on 2023/03/15.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var focusTime = 25.0
    @State var restTime = 5.0
    @State var cycles = 4.0
    @State var isEditing = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(alignment: .center) {
                    
                    Spacer()
                    
                    Text("集中時間: \(Int(focusTime))分")
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.black)
                    Slider(value: $focusTime, in: 1...120, step: 1)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                        .padding(.bottom, 30)
                    
                    Text("休憩時間: \(Int(restTime))分")
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.black)
                    Slider(value: $restTime, in: 1...30, step: 1)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                        .padding(.bottom, 30)
                    
                    Text("サイクル: \(Int(cycles))回")
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.black)
                    Slider(value: $cycles, in: 1...20, step: 1)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                        .padding(.bottom, 30)
                    
                    Text("所要時間: \(Int((focusTime + restTime) * cycles - restTime))分")
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.black)
                        .padding(.bottom, 50)
                    
                    Spacer()
                    
                    NavigationLink {
                        TimerView(focusTime: Int(focusTime), restTime: Int(restTime), cycles: Int(cycles))
                            .navigationBarBackButtonHidden(true)
//                            .toolbar {
//                                ToolbarItem(placement: .navigationBarLeading, content: {
//                                    Button(action: {
//                                        print("custom action")
//                                        dismiss()
//                                    }, label: {
//                                        Text("戻る")
//                                    })
//                                })
//                            }
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

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
