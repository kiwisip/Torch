//
//  Property.swift
//  Torch
//
//  Created by Filip Dolnik on 20.07.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

public struct Property<PARENT: TorchEntity, T: PropertyType> {
    
    public let name: String
    
    public var torchName: String {
        return Database.COLUMN_PREFIX + name
    }
    
    public init(name: String) {
        self.name = name
    }
}