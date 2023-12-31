//
//  Vertex.swift
//  MetalTest
//
//  Created by Maochun on 2023/9/14.
//

import Foundation

struct Vertex {
    var x, y, z: Float      // position data
    var r, g, b, a: Float   // color data
    
    func floatBuffer() -> [Float] {
        return [x, y, z, r, g, b, a]
    }
}
