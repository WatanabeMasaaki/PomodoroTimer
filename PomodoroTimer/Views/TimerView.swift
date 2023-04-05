//
//  TimerView.swift
//  PomodoroTimer
//
//  Created by 渡邉雅晃 on 2023/03/15.
//

import SwiftUI

struct TimerView: View {
    @Environment (\.dismiss) private var dismiss
    
    @ObservedObject var timerController = TimerModel()
    var focusTime : Int
    var restTime : Int
    var cycles : Int
    @State var isTimerStop = true
    //このisTimerStartedは初めてスタートボタンが押されて以降trueになる
    @State var isTimerStarted = false
    
    //「戻る」を押した時にアラートを表示させるトリガー
    @State var alertBack = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                
                Button(action: {
                    alertBack = true
                    timerController.stop()
                    isTimerStop = true
                }, label: {
                    Text("戻る")
                })
                
                Spacer()
                
                Text("\(timerController.cycleStr)サイクル目")
                    .font(.system(size: 40, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.black)
                    .padding(.bottom, 10)
                
                Text(timerController.isFocus ? "集中" : "休憩")
                    .font(.system(size: 50, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.black)
                    .padding(.top, 10)
                
                Text(isTimerStarted ?
                     "\(timerController.minStr):\(timerController.secStr)" :
                        "\(String(format: focusTime < 10 ? "0%d" : "%d", focusTime)):00")
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.black)
                    .padding()
                
                //○でサイクルの達成数を可視化
                if (cycles < 10) {
                    HStack {
                        ForEach (0 ..< cycles) { i in
                            if(i < timerController.completed) {
                                Image(systemName: "circle.fill")
                            } else {
                                Image(systemName: "circle")
                            }
                            
                        }
                    }
                    .foregroundColor(.black)
                } else {
                    VStack {
                        HStack {
                            ForEach (0 ..< 10) { i in
                                if(i < timerController.completed) {
                                    Image(systemName: "circle.fill")
                                } else {
                                    Image(systemName: "circle")
                                }
                            }
                        }
                        .padding(.bottom, 10)
                        HStack {
                            ForEach (10 ..< cycles) { i in
                                if(i < timerController.completed) {
                                    Image(systemName: "circle.fill")
                                } else {
                                    Image(systemName: "circle")
                                }
                            }

                        }
                    }
                    .foregroundColor(.black)
                }
                
                Spacer()
                
                Button(action: {
                    if(timerController.timer == nil){
                        timerController.start(focusTime: focusTime, restTime: restTime, cycles: cycles)
                        isTimerStop = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isTimerStarted = true
                        }
                    } else {
                        timerController.stop()
                        isTimerStop = true
                    }
                }, label: {
                    Label(isTimerStop ? "START" : "STOP",systemImage: isTimerStop ? "play.fill" : "pause.fill")
                        .font(.title)
                        .frame(width: 300, height: 70)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.blue, lineWidth: 4))
                })
                .padding()
            }
        }
        .alert("よくがんばりました！！", isPresented: $timerController.showAlert, actions: {
            Button("OK", role: .cancel) {
                timerController.stopSuccess()
                dismiss()
            }
        })
        .alert("本当に戻りますか？", isPresented: $alertBack, actions: {
            
            Button("戻る", role: .destructive, action: {
                timerController.timer = nil
                dismiss()
            })
            Button("キャンセル", role: .cancel, action: {
                alertBack = false
            })
        }, message: {
            Text("\(focusTime * timerController.completed)分の集中時間が記録されます")
        })
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(focusTime: 1, restTime: 1, cycles: 15)
    }
}
