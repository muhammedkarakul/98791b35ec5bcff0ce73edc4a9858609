//
//  UserDefaultsAccessible.swift
//  98791b35ec5bcff0ce73edc4a9858609
//
//  Created by Muhammed Karakul on 13.06.2021.
//

import Foundation

protocol UserDefaultsAccessible {
    func setUserDefaultsValue(_ value: Any, forKey defaultName: DefaultName)
    func getUserDefaultValue<T>(_ valueType: T.Type, forKey defaultName: DefaultName) throws -> T
}

extension UserDefaultsAccessible {
    private var userDefaults: UserDefaults {
        UserDefaults.standard
    }
    
    func setUserDefaultsValue(_ value: Any, forKey defaultName: DefaultName) {
        userDefaults.set(value, forKey: defaultName.rawValue)
    }
    
    func getUserDefaultValue<T>(_ valueType: T.Type, forKey defaultName: DefaultName) throws -> T {
        switch valueType {
        case is String.Type:
            guard let value = userDefaults.string(forKey: defaultName.rawValue) as? T else { throw UserDefaultError.valueNotFound }
            return value
            
        case is Int.Type:
            guard let value = userDefaults.integer(forKey: defaultName.rawValue) as? T else { throw UserDefaultError.valueNotFound }
            return value
            
        case is Double.Type:
            guard let value = userDefaults.double(forKey: defaultName.rawValue) as? T else { throw UserDefaultError.valueNotFound }
            return value
            
        case is Float.Type:
            guard let value = userDefaults.float(forKey: defaultName.rawValue) as? T else { throw UserDefaultError.valueNotFound }
            return value
            
        case is Bool.Type:
            guard let value = userDefaults.bool(forKey: defaultName.rawValue) as? T else { throw UserDefaultError.valueNotFound }
            return value
            
        case is Array<Any>.Type:
            guard let value = userDefaults.array(forKey: defaultName.rawValue) as? T else { throw UserDefaultError.valueNotFound }
            return value
            
        case is Dictionary<String, Any>.Type:
            guard let value = userDefaults.dictionary(forKey: defaultName.rawValue) as? T else { throw UserDefaultError.valueNotFound }
            return value
            
        case is URL.Type:
            guard let value = userDefaults.url(forKey: defaultName.rawValue) as? T else { throw UserDefaultError.valueNotFound }
            return value
            
        case is Data.Type:
            guard let value = userDefaults.data(forKey: defaultName.rawValue) as? T else { throw UserDefaultError.valueNotFound }
            return value
            
        default:
            throw UserDefaultError.valueTypeNotCorrect
        }
    }
}

// MARK: - DefaultNames
extension UserDefaultsAccessible {
    var isSpacecraftCreated: Bool {
        do {
            return try getUserDefaultValue(Bool.self, forKey: .isSpaceCraftCreated)
        } catch {
            debugPrint("isSpaceCraftCreated data not found. \(error)")
            return false
        }
    }
}
