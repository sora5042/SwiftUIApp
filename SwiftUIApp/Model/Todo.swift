//
//  ToDo.swift
//  SwiftUIApp
//
//  Created by 大谷空 on 2022/02/25.
//

import Foundation
import RealmSwift

class Todo: Object, Identifiable {
    @Persisted var title = ""
    @Persisted var comment = ""
}

extension Todo {
    // 追加
    static func addTodo(title: String, comment: String) {
        let todo = Todo()
        todo.title = title
        todo.comment = comment
        
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.add(todo)
        }
    }
    // 更新
    static func updateTodo(todo: Todo, newTitle: String, newComment: String) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            todo.title = newTitle
            todo.comment = newComment
        }
    }
    // 取得
    static func fetchAllTodo() -> [Todo]? {
        guard let localRealm = try? Realm() else { return nil }
        let todos = localRealm.objects(Todo.self)
        return Array(todos)
    }
    // 削除
    static func deleteTodo(todo: Todo) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.delete(todo)
        }
    }
}
