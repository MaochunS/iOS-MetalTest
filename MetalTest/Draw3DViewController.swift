//
//  Draw3DViewController.swift
//  MetalTest
//
//  Created by Maochun on 2023/9/13.
//

import Foundation
import UIKit
import Metal
import GLKit
import MetalKit
import MetricKit



class Draw3DViewController: UIViewController {
    
    var device: MTLDevice!
    var metalLayer: CAMetalLayer!
    var pipelineState: MTLRenderPipelineState!
    var commandQueue: MTLCommandQueue!
    
    var timer: CADisplayLink!
    
//    var objectToDraw: Triangle!
    var objectToDraw: Cube!
    
    var projectionMatrix: Matrix4!
    
    var lastFrameTimestamp: CFTimeInterval = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        projectionMatrix = Matrix4.makePerspectiveViewAngle(Matrix4.degrees(toRad: 85.0), aspectRatio: Float(self.view.bounds.size.width / self.view.bounds.size.height), nearZ: 0.01, farZ: 100.0)

        
        self.device = MTLCreateSystemDefaultDevice()
        
        metalLayer = CAMetalLayer()          // 1
        metalLayer.device = device           // 2
        metalLayer.pixelFormat = .bgra8Unorm // 3
        metalLayer.framebufferOnly = true    // 4
        metalLayer.frame = view.layer.frame  // 5
        view.layer.addSublayer(metalLayer)   // 6
        
//        objectToDraw = Triangle(device: device)
        objectToDraw = Cube(device: device)
        
//        objectToDraw.positionX = -0.25
//        objectToDraw.rotationZ = Matrix4.degrees(toRad: 45)
//        objectToDraw.scale = 0.5
        
//        objectToDraw.positionX = 0.0
//        objectToDraw.positionY =  0.0
//        objectToDraw.positionZ = -2.0
//        objectToDraw.rotationZ = Matrix4.degrees(toRad: 45);
//        objectToDraw.scale = 0.5
        
        // 1
        let defaultLibrary = device.makeDefaultLibrary()!
        let fragmentProgram = defaultLibrary.makeFunction(name: "basic_fragment2")
        let vertexProgram = defaultLibrary.makeFunction(name: "basic_vertex3")
            
        // 2
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
            
        // 3
        pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        
        commandQueue = device.makeCommandQueue()
        
//        timer = CADisplayLink(target: self, selector: #selector(gameloop))
        timer = CADisplayLink(target: self, selector: #selector(Draw3DViewController.newFrame(displayLink:)))
        timer.add(to: RunLoop.main, forMode: .default)
        
        
    }
    
    func render() {
        guard let drawable = metalLayer?.nextDrawable() else { return }
//      objectToDraw.render(commandQueue: commandQueue, pipelineState: pipelineState, drawable: drawable, clearColor: nil)
//        objectToDraw.render(commandQueue: commandQueue, pipelineState: pipelineState, drawable: drawable,projectionMatrix: projectionMatrix, clearColor: nil)
        let worldModelMatrix = Matrix4()
        worldModelMatrix.translate(0.0, y: 0.0, z: -7.0)
        worldModelMatrix.rotateAroundX(Matrix4.degrees(toRad: 25), y: 0.0, z: 0.0)

            
        objectToDraw.render(commandQueue: commandQueue, pipelineState: pipelineState, drawable: drawable, parentModelViewMatrix: worldModelMatrix, projectionMatrix: projectionMatrix ,clearColor: nil)
    }
    
    // 1
    @objc func newFrame(displayLink: CADisplayLink){
        
      if lastFrameTimestamp == 0.0
      {
        lastFrameTimestamp = displayLink.timestamp
      }
        
      // 2
      let elapsed: CFTimeInterval = displayLink.timestamp - lastFrameTimestamp
      lastFrameTimestamp = displayLink.timestamp
        
      // 3
      gameloop(timeSinceLastUpdate: elapsed)
    }
      
    func gameloop(timeSinceLastUpdate: CFTimeInterval) {
        
      // 4
      objectToDraw.updateWithDelta(delta: timeSinceLastUpdate)
        
      // 5
      autoreleasepool {
        self.render()
      }
    }

}
