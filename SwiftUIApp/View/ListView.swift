//
//  ListView.swift
//  SwiftUIApp
//
//  Created by 大谷空 on 2022/02/25.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var viewModel = ListViewModel.shared
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.todos) { todo in
                    HStack {
                        Image(systemName: "circlebadge.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.blue)
                        VStack {
                            Text("タイトル")
                                .font(.title3)
                            Text("デスクリプション")
                                .font(.caption2)
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            viewModel.deleteTodo(todo: todo)
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            viewModel.updatingTodo = todo
                            viewModel.title = todo.title
                            viewModel.comment = todo.comment
                            print("show edit view")
                        } label: {
                            Image(systemName: "pencil.circle")
                        }
                        .tint(.green)
                    }
                }
            }
            .navigationTitle("Realm Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.isShowAddView.toggle()
                    }) {
                        
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $viewModel.isShowAddView) { // new
                AddTodo()
            }
        }
    }
    
    struct ListView_Previews: PreviewProvider {
        static var previews: some View {
            ListView()
        }
    }
}
