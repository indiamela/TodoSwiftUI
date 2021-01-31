//
//  NewTask.swift
//  TodoSwiftUI
//
//  Created by Taishi Kusunose on 2021/01/31.
//

import SwiftUI

struct NewTask: View {
    @State var task: String = ""
    @State var time: Date? = Date()
    @State var category:Int16 = TodoEntity.Category.ImpUrg_1st.rawValue
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
    
    @Environment(\.presentationMode) var presentationMode
    //アプリ全体で処理したいものをEnvironmentで指定する　参照したいものをキーパスで渡す　目的のオブジェクトをバインディングにする
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("タスク")){
                    TextField("タスクを入力", text: $task)
                }
                Section(header: Toggle(isOn: Binding(isNotNil: $time, defaultValue:Date())){Text("時間を指定する")}){
                    if time != nil {
                        DatePicker(selection: Binding($time,Date()), label: { Text("日時")})
                    } else {
                        Text("時間未指定").foregroundColor(.secondary)
                    }
                }
                Picker(selection: $category, label: Text("種類"), content: {
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
                        self.presentationMode.wrappedValue.dismiss() //modalが隠れる
                    }, label: {
                        HStack(alignment: .center){
                            Image(systemName: "minus.circle.fill")
                            Text("キャンセル")
                        }
                        .foregroundColor(.red)
                        
                    })
                }
            }.navigationBarTitle("タスクの追加") //タイトルの追加
            .navigationBarItems(trailing: Button(action: {
                TodoEntity.create(in: self.viewContext,
                                  category: TodoEntity.Category(rawValue:self.category) ?? .ImpUrg_1st,
                                  task: self.task,
                                  time: self.time)
                self.save()
                self.presentationMode.wrappedValue.dismiss() //modalが隠れる
            }) {
                Text("保存")
            })
        }
    }
}

struct NewTask_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var previews: some View {
        NewTask()
            .environment(\.managedObjectContext, context)
    }
}

//navigatioView

