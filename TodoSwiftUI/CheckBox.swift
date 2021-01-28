//
//  CheckBox.swift
//  TodoSwiftUI
//
//  Created by Taishi Kusunose on 2021/01/28.
//

import SwiftUI

struct CheckBox<Label>: View where Label: View{ //型バインディング
//    @State var checked: Bool = false @Steteとは、変数をSwiftUIで管理すること。これを使うとUI上で変更できる。
    @Binding var checked:Bool //初期値を設定しない場合
    private var label: () -> Label
    
    public init(checked: Binding<Bool>,@ViewBuilder label: @escaping () -> Label){
        self._checked = checked
        self.label = label
    }
    var body: some View {
        
        HStack {
            Image (systemName: checked ? "checkmark.circle" : "circle")
                .onTapGesture {
                    self.checked.toggle()
            }
            label()
        }
//        Toggle(isOn: $checked, label: {
//            //バインディング構造体　toggleを変更するとcheckedに反映される。
//            Text("チェックボックス")
//        })
    }
}

struct CheckBox_Previews: PreviewProvider {
    //プレビュー画面に描画するメソッド
    static var previews: some View {
        VStack {
            CheckBox(checked: .constant(false)){
                Text("牛乳を買う")
            }
            CheckBox(checked: .constant(true)){
                Image(systemName: "hand.thumbsup")
            }
        }
    }
}
