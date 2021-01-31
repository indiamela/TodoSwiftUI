//
//  ContentView.swift
//  TodoSwiftUI
//
//  Created by Taishi Kusunose on 2021/01/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Color.tBackground
                .edgesIgnoringSafeArea(.top)
                .frame(height:0)
            UserView(image: Image("profile"), userName: "Taishi Kusunose")
            VStack {
                HStack(spacing:0) {
                    CategoryView(category: .ImpUrg_1st)
                    Spacer()
                    CategoryView(category: .ImpNUrg_2nd)
                }
                HStack(spacing:0) {
                    CategoryView(category: .NImpUrg_3rd)
                    Spacer()
                    CategoryView(category: .NImpNUrg_4th)
                }
            }.padding()
        }.background(Color.tBackground)
        .edgesIgnoringSafeArea(.bottom) //sageAreaを無視して描画できる
    }
}

struct ContentView_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, context)
    }
}
