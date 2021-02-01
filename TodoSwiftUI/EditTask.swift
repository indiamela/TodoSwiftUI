//
//  EditTask.swift
//  TodoSwiftUI
//
//  Created by Taishi Kusunose on 2021/01/31.
//

import SwiftUI

struct EditTask: View {
    @ObservedObject var todo: TodoEntity //変更がDBに反映される
    @State var showingSheet: Bool
    var categories: [TodoEntity.Category] = [.ImpUrg_1st, .ImpNUrg_2nd, .NImpUrg_3rd, .NImpNUrg_4th]
    @Environment(\.managedObjectContext) var viewContext
    fileprivate func save(){
        do {
            try self.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("\(nserror.userInfo)")
        }
    }
    
    fileprivate func delete() {
        viewContext.delete(todo)
        save()
    }
    
    @Environment(\.presentationMode) var presentationMode
    //アプリ全体で処理したいものをEnvironmentで指定する　参照したいものをキーパスで渡す　目的のオブジェクトをバインディングにする
    var body: some View {
        Form {
            Section(header: Text("タスク")){
                TextField("タスクを入力", text: Binding($todo.task,"new task"))
            }
            Section(header: Toggle(isOn: Binding(isNotNil: $todo.time, defaultValue:Date())){Text("時間を指定する")}){
                if todo.time != nil {
                    DatePicker(selection: Binding($todo.time,Date()), label: { Text("日時")})
                } else {
                    Text("時間未指定").foregroundColor(.secondary)
                }
            }
            Picker(selection: $todo.category, label: Text("種類"), content: {
                ForEach(categories, id: \.self){ category in
                    //自分自身をidにしている
                    HStack{
                        CategoryImage(category)
                        Text(category.toString())
                    }.tag(category.rawValue)
                }
            })
            Section(header:Text("操作")){
                Button(action: {
                    self.showingSheet = true
                }, label: {
                    HStack(alignment: .center){
                        Image(systemName: "minus.circle.fill")
                        Text("delete")
                    }
                    .foregroundColor(.red)
                    
                })
            }
            }.navigationBarTitle("タスクの編集") //タイトルの追加
            .navigationBarItems(trailing: Button(action: {
                self.save()
                self.presentationMode.wrappedValue.dismiss() //modalが隠れる
            }) {
                Text("閉じる")
            })
        .actionSheet(isPresented: $showingSheet, content: {
            ActionSheet(title: Text("タスクの削除"), message: Text("このタスクを削除します。よろしいですか？"), buttons: [
                .destructive(Text("削除")){
                    //destructiveはキャンセルなどに使う赤いボタン
                    self.delete()
                    self.presentationMode.wrappedValue.dismiss()
                },
                .cancel(Text("キャンセル"))
            ])
        })
    }
}

struct EditTask_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var previews: some View {
        let newTodo = TodoEntity(context: context)
        return NavigationView{
            EditTask(todo: newTodo, showingSheet: false)
                .environment(\.managedObjectContext, context)
        }
    }
}

//navigatioView

