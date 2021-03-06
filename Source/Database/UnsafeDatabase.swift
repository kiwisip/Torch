//
//  UnsafeDatabase.swift
//  Torch
//
//  Created by Filip Dolnik on 20.07.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

/// Wrapper for Database that is crashing with fatalError instead of throwing errors.
public class UnsafeDatabase {

    private let database: Database

    internal init(database: Database) {
        self.database = database
    }

}

// MARK: - Load
extension UnsafeDatabase {

    public func load<T: TorchEntity>(type: T.Type, sortBy sortDescriptors: SortDescriptor<T>...) -> [T] {
        return load(type, sortBy: sortDescriptors)
    }

    public func load<T: TorchEntity>(type: T.Type, sortBy sortDescriptors: [SortDescriptor<T>]) -> [T] {
        do {
            return try database.load(type, sortBy: sortDescriptors)
        } catch {
            fatalError(String(error))
        }
    }

    public func load<T: TorchEntity, P: PredicateConvertible where P.ParentType == T>(type: T.Type, where predicate: P, sortBy sortDescriptors: SortDescriptor<T>...) -> [T] {
        return load(type, where: predicate, sortBy: sortDescriptors)
    }

    public func load<T: TorchEntity, P: PredicateConvertible where P.ParentType == T>(type: T.Type, where predicate: P, sortBy sortDescriptors: [SortDescriptor<T>]) -> [T] {
        do {
            return try database.load(type, where: predicate, sortBy: sortDescriptors)
        } catch {
            fatalError(String(error))
        }
    }

}

// MARK: - Save
extension UnsafeDatabase {

    /// See `Database.save`
    public func save<T: TorchEntity>(entities: T...) -> UnsafeDatabase {
        return save(entities)
    }

    public func save<T: TorchEntity>(entities: [T]) -> UnsafeDatabase {
        do {
            try database.save(entities)
        } catch {
            fatalError(String(error))
        }
        return self
    }

    /// See `Database.create`
    public func create<T: TorchEntity>(inout entity: T) -> UnsafeDatabase {
        do {
            try database.create(&entity)
        } catch {
            fatalError(String(error))
        }
        return self
    }

    public func create<T: TorchEntity>(inout entities: [T]) -> UnsafeDatabase {
        do {
            try database.create(&entities)
        } catch {
            fatalError(String(error))
        }
        return self
    }
}

// MARK: - Delete
extension UnsafeDatabase {

    public func delete<T: TorchEntity>(entities: T...) -> UnsafeDatabase {
        delete(entities)
        return self
    }

    public func delete<T: TorchEntity>(entities: [T]) -> UnsafeDatabase {
        do {
            try database.delete(entities)
        } catch {
            fatalError(String(error))
        }
        return self
    }

    public func delete<T: TorchEntity, P: PredicateConvertible where P.ParentType == T>(type: T.Type, where predicate: P) -> UnsafeDatabase {
        do {
            try database.delete(type, where: predicate)
        } catch {
            fatalError(String(error))
        }
        return self
    }

    public func deleteAll<T: TorchEntity>(type: T.Type) -> UnsafeDatabase {
        do {
            try database.deleteAll(type)
        } catch {
            fatalError(String(error))
        }
        return self
    }

}

// MARK: - Transaction
extension UnsafeDatabase {

    public func rollback() -> UnsafeDatabase {
        database.rollback()
        return self
    }

    public func write(@noescape closure: () -> () = {}) -> UnsafeDatabase {
        do {
            try database.write(closure)
        } catch {
            fatalError(String(error))
        }
        return self
    }
}
