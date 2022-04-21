//
//  DBManager.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import Foundation
import RealmSwift

class DBManager {
    // MARK: Properties
    fileprivate var realm: Realm?

    // Can't init is singleton
    private init() {
        initializeRealm()
    }

    // MARK: Shared Instance
    fileprivate static let shared = DBManager()

    // MARK: Adding and Creating objects
    private func add(_ object: Object, update: Realm.UpdatePolicy = .modified) {
        guard let realm = realm else {
            print("DBManager needs to be initialized first. Call `initialize`")
            return
        }
        DispatchQueue.main.async {
            try? realm.write {
                realm.add(object, update: update)
            }
        }
    }

    public func add<S: Sequence>(_ objects: S, update: Realm.UpdatePolicy = .error) where S.Iterator.Element: Object {
        guard let realm = realm else {
            print("DBManager needs to be initialized first. Call `initialize`")
            return
        }
        DispatchQueue.main.async {
            try? realm.write {
                realm.add(objects, update: update)
            }
        }
    }

    private func objects<Element: Object>(_ type: Element.Type) -> Results<Element> {
        guard let realm = realm else {
            fatalError("DBManager needs to be initialized first. Call `initialize(with eventCode: String)`")
        }
        return realm.objects(type)
    }

    /// Need to be called after set the activeEventCode
    private func initializeRealm() {
        let name = "TvMazeApp"
        var config = Realm.Configuration()
        config.fileURL?.deleteLastPathComponent()
        config.fileURL?.appendPathComponent(name)
        config.fileURL?.appendPathExtension("realm")
        print("Realm Path: " + (config.fileURL?.absoluteString ?? "No Path"))
        realm = try! Realm(configuration: config)
    }
}

extension DBManager {
    // MARK: Adding and Creating objects
    static func add(_ object: Object, update: Realm.UpdatePolicy = .modified) {
        shared.add(object, update: update)
    }

    static func add<S: Sequence>(_ objects: S, update: Realm.UpdatePolicy = .modified) where S.Iterator.Element: Object {
        shared.add(objects, update: update)
    }

    // MARK: - Read Reactive
    static func objects<Element: Object>(_ type: Element.Type) -> Results<Element> {
        return shared.objects(type)
    }
}
