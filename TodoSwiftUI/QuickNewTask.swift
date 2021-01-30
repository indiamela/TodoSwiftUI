//
//  QuickNewTask.swift
//  TodoSwiftUI
//
//  Created by Taishi Kusunose on 2021/01/30.
//

import SwiftUI

struct QuickNewTask: View {
    let category: TodoEntity.Category
    @State var newTask: String = ""
    
    fileprivate func addNewTask(){
        self.newTask = ""
    }
    
    fileprivate func cancelTask(){
        self.newTask = ""
    }
    
    var body: some View {
        HStack {
            //Binding変数を入れることによって書いたものがそのままQuickNewTaskViewに反映される
            TextField("新しいタスク", text: $newTask, onCommit: {
                self.addNewTask()
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {self.addNewTask()}) {
                Text("追加")
            }
            Button(action: {self.cancelTask()}) {
                Text("Cancel")
                    .foregroundColor(.red)
            }
        }
        
    }
}

struct QuickNewTask_Previews: PreviewProvider {
    static var previews: some View {
        QuickNewTask(category: .ImpUrg_1st)
    }
}
