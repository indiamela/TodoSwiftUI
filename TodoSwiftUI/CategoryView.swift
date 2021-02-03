//
//  CategoryView.swift
//  TodoSwiftUI
//
//  Created by Taishi Kusunose on 2021/01/30.
//

import SwiftUI

struct CategoryView: View {
    var category: TodoEntity.Category
    @State var numberOfTasks = 0
    @State var showList = false
    @Environment(\.managedObjectContext) var viewContext
    @State var addNewtask = false
    //viewContextはDBを操作するために必要
    fileprivate func update() {
        self.numberOfTasks = TodoEntity.count(in: self.viewContext,category: self.category)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: category.image())
                .font(.largeTitle)
                .sheet(isPresented: $showList, onDismiss: {self.update()},content: {
                    //showListがtrueになったらsheetを表示
                    TodoList(category: self.category)
                        .environment(\.managedObjectContext, self.viewContext)
                        //DBを扱う
                })
                Text(category.toString())
                Text(" - \(numberOfTasks)タスク")
                Button(action:{
                    self.addNewtask = true
                }) {
                    //新規タスク追加
                    Image(systemName: "plus")
                }.sheet(isPresented: $addNewtask, onDismiss: {self.update()}, content: {
                    NewTask(category: self.category.rawValue)
                        .environment(\.managedObjectContext, self.viewContext)
                })
                Spacer()
            }
        .padding()
        .frame(maxWidth:.infinity ,minHeight: 150)
        .foregroundColor(.white)
        .background(category.color())
        .cornerRadius(20)
        .onTapGesture {
            //showListがtrueになったらsheetを表示
            self.showList = true
        }
        .onAppear{
            self.update()
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        VStack {
            CategoryView(category: .ImpUrg_1st,numberOfTasks: 100)
            CategoryView(category: .ImpNUrg_2nd)
            CategoryView(category: .NImpUrg_3rd)
            CategoryView(category: .NImpNUrg_4th)
        }.environment(\.managedObjectContext, context)
    }
}
