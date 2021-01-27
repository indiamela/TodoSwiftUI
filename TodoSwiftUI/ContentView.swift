//
//  ContentView.swift
//  TodoSwiftUI
//
//  Created by Taishi Kusunose on 2021/01/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(systemName: "tortoise.fill")
            .resizable() //リサイズ
            .scaledToFit() //スケールをあわせる
            .frame(width: 30, height: 30)
            .foregroundColor(.white)
            .background(Color(#colorLiteral(red: 0.7246091962, green: 0.8572179675, blue: 0.5617229342, alpha: 1)))
        //.background(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
            .cornerRadius(6.0)
            .padding(2.0)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
