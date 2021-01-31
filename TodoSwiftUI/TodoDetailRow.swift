//
//  TodoDetailRow.swift
//  TodoSwiftUI
//
//  Created by Taishi Kusunose on 2021/01/30.
//

import SwiftUI

struct TodoDetailRow: View {
    @ObservedObject var todo: TodoEntity
    //@ObservedObjectは変数がもつメンバに変更があれば画面に反映
    //@Stateは変数を監視して画面を反映させる
    var hideIcon = false
    var body: some View {
        HStack{
            if !hideIcon{
                CategoryImage(TodoEntity.Category(rawValue: todo.category))
            }
            CheckBox(checked: Binding(get: {
                self.todo.state == TodoEntity.State.done.rawValue
            },
            set: {
                self.todo.state = $0 ? TodoEntity.State.done.rawValue : TodoEntity.State.todo.rawValue
                
            })){
                if self.todo.state == TodoEntity.State.done.rawValue {
                    Text(self.todo.task ?? "no title").strikethrough()
                } else {
                    Text(self.todo.task ?? "no title")
                }
            }.foregroundColor(self.todo.state == TodoEntity.State.done.rawValue ? .secondary : .primary)
            //secondaryの場合は薄いグレーになる
        }.gesture(DragGesture().onChanged({ value in
            //valueに座標情報がはいる
            if value.predictedEndTranslation.width > 200 {
                //predictedEndTranslation　指の位置がどれだけうごいたか
                if self.todo.state != TodoEntity.State.done.rawValue {
                    self.todo.state = TodoEntity.State.done.rawValue
                }
            } else if value.predictedEndTranslation.width < -200 {
                if self.todo.state != TodoEntity.State.todo.rawValue {
                    self.todo.state = TodoEntity.State.todo.rawValue
                }
            }
        }))
        
    }
}

struct TodoDetailRow_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
        let newTodo = TodoEntity(context: context)
        newTodo.task = "将来への人間関係づくり"
        newTodo.state = TodoEntity.State.done.rawValue
        newTodo.category = 0
        let newTodo1 = TodoEntity(context: context)
        newTodo1.task="クレームへの対応"
        newTodo.category = 1
        let newTodo2 = TodoEntity(context: context)
        newTodo2.task="無意味な接待や付き合い"
        newTodo2.category = 2
        let newTodo3 = TodoEntity(context: context)
        newTodo3.task="長時間、必要以上の息抜き"
        newTodo3.category = 3
        return VStack(alignment: .leading) {
            VStack {
                TodoDetailRow(todo: newTodo)
                TodoDetailRow(todo: newTodo, hideIcon: true)
                TodoDetailRow(todo: newTodo1)
                TodoDetailRow(todo: newTodo2)
                TodoDetailRow(todo: newTodo3)
            }.environment(\.managedObjectContext, context)
        }
    }
}
