//
//  AdoTodo.swift
//  SwiftUIApp
//
//  Created by 大谷空 on 2022/02/25.
//

import SwiftUI

struct AddTodo: View {
    
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel = ListViewModel.shared
    @State private var selectionDate = Date()
    
    var body: some View {
        NavigationView {
           
            List {
                Section(header: Text("タイトル")) {
                    TextField("", text: $viewModel.title)
                }
                Section(header: Text("デスクリプション")) {
                    TextField("", text: $viewModel.comment)
                }
                Section(header: Text("日時選択")) {
                    DatePicker("日時を選択", selection: $selectionDate)
                        .datePickerStyle(WheelDatePickerStyle())
                }
            }
            .navigationTitle(viewModel.updatingTodo == nil ? "ToDoを追加" : "ToDoを更新")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // 追加
                        if (viewModel.updatingTodo == nil) {
                            viewModel.addTodo()
                        } else {
                            // 更新
                            viewModel.updateTodo()
                        }
                    }) {
                        Text("完了")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }) {
                        Text("キャンセル")
                    }
                }
            }
        }
    }
}

struct AdoTodo_Previews: PreviewProvider {
    static var previews: some View {
        AddTodo()
    }
}
