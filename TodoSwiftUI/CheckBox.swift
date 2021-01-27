//
//  CheckBox.swift
//  TodoSwiftUI
//
//  Created by Taishi Kusunose on 2021/01/28.
//

import SwiftUI

struct CheckBox: View {
//    @State var checked: Bool = false
    @Binding var checked:Bool //初期値を設定しない場合 //@Steteとは、変数をSwiftUIで管理すること。これを使うとUI上で変更できる。
    var body: some View {
        
        Image (systemName: checked ? "checkmark.circle" : "circle")
            .onTapGesture {
                self.checked.toggle()
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
        Group {
            CheckBox(checked: .constant(false))
            CheckBox(checked: .constant(true))
        }
    }
}
