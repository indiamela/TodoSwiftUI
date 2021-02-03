//
//  TodoList.swift
//  TodoSwiftUI
//
//  Created by Taishi Kusunose on 2021/01/30.
//

import SwiftUI
import CoreData

struct TodoList: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoEntity.time,
                                           ascending: true)],
        animation: .default)
    var todoList: FetchedResults<TodoEntity>
    
    @Environment(\.managedObjectContext) var viewContext

    fileprivate func deleteTodo(at offsets: IndexSet){
        for index in offsets{
            let entity = todoList[index]
            viewContext.delete(entity)
        }
        do {
            try viewContext.save()
        } catch {
            print("Delete Error. \(offsets)")
        }
    }
    
    let category: TodoEntity.Category
    var body: some View {
        NavigationView{
            VStack {
                List{
                    ForEach(todoList){ todo in
                        if todo.category == self.category.rawValue{
                            NavigationLink(
                                destination: EditTask(todo: todo)){
                                TodoDetailRow(todo: todo, hideIcon: true)
                            }
                        }
                    }.onDelete(perform:deleteTodo) //スワイプ処理
                }
                QuickNewTask(category: category)
                    .padding()
            }.navigationBarTitle(category.toString()) //タイトル
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    //コンテキストをつかってデータを生成、保存する
    static let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    static let context = container.viewContext
    
    static var previews: some View {
        
        // テストデータの全削除
        let request = NSBatchDeleteRequest(
            fetchRequest: NSFetchRequest(entityName: "TodoEntity"))
        try! container.persistentStoreCoordinator.execute(request,
                                                          with: context)

        // データを追加
        TodoEntity.create(in: context,
                          category: .ImpUrg_1st, task: "炎上プロジェクト")
        TodoEntity.create(in: context,
                          category: .ImpNUrg_2nd, task: "自己啓発")
        TodoEntity.create(in: context,
                          category: .NImpUrg_3rd, task: "意味のない会議")
        TodoEntity.create(in: context,
                          category: .NImpNUrg_4th, task: "暇つぶし")

        return TodoList(category: .ImpUrg_1st)
            .environment(\.managedObjectContext, context)
        
    }
}
