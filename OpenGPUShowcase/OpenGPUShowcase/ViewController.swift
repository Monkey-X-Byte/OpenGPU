//
//  ViewController.swift
//  OpenGPUShowcase
//
//  Created by langren on 2020/3/12.
//  Copyright © 2020 langren. All rights reserved.
//

import UIKit
import AVFoundation

fileprivate let FragmentShader = """

varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
void main()
{
    gl_FragColor = texture2D(inputImageTexture, textureCoordinate);
}

"""

class ViewController: UIViewController {
    
    private var camera: OGCamera?
    private var displayView: OGRenderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        displayView = OGRenderView(frame: self.view.bounds)
        self.view.addSubview(displayView)
        camera = OGCamera(capturePreset: AVCaptureSession.Preset.hd1280x720, cameraPosition: .back, captureAsYUV: false)
        
//        let filter = OGBaseFilter(vertexShader: ThreeInputVertexShader, fragmentShader: FragmentShader, numberOfInput: 2)
        let filter = RGBFilter();
        
        camera?.addTarget(target: filter, atTargetIndex: 0)
        
        
        filter --> displayView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        camera?.startCapture()
    }
    
}

