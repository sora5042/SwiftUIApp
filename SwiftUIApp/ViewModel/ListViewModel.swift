//
//  ListViewModel.swift
//  SwiftUIApp
//
//  Created by 大谷空 on 2022/02/25.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var isShowAddView = false
    @Published var todos: [Todo] = []
    @Published var title = ""
    @Published var comment = ""
    @Published var updatingTodo: Todo? = nil
    
    init () { // new
        fetchTodos()
    }
    
    func fetchTodos() { // new
        self.todos = Todo.fetchAllTodo()!
    }
    
    func addTodo() {
        Todo.addTodo(title: title, comment: comment)
        self.title = ""
        self.comment = ""
        fetchTodos()
    }
    
    // todoリストの更新
    func updateTodo() {
        Todo.updateTodo(todo: updatingTodo!, newTitle: self.title, newComment: self.comment)
        // 初期化
        self.title = ""
        self.comment = ""
        updatingTodo = nil
        fetchTodos()
    }
    
    func deleteTodo(todo: Todo) {
        Todo.deleteTodo(todo: todo)
        fetchTodos()
    }
    
    static let shared = ListViewModel() // シングルトンとする
}
