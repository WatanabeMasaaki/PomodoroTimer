//
//  CycleProgressView.swift
//  PomodoroTimer
//
//  Created by 渡邉雅晃 on 2023/03/23.
//

import SwiftUI

struct CycleProgressView: View {
    var cycles: Int
    @State var completed: Int
    var body: some View {
        HStack {
            ForEach (0..<completed) { _ in
                Image(systemName: "circle.fill")
            }
            ForEach (completed..<cycles) { _ in
                Image(systemName: "circle")
            }
        }
        .foregroundColor(.black)
    }
}

struct CycleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CycleProgressView(cycles: 2, completed: 0)
    }
}
